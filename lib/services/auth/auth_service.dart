import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Result wrapper for auth operations
class AuthResult {
  final User? user;
  final String? errorMessage;
  final bool requiresEmailVerification;

  AuthResult({
    this.user,
    this.errorMessage,
    this.requiresEmailVerification = false,
  });

  bool get isSuccess => user != null && errorMessage == null;
  bool get isCancelled => errorMessage?.contains('cancelled') ?? false;
}

/// Service for Firebase Authentication operations
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => currentUser != null;

  /// Check if Apple Sign-In is available
  bool get isAppleSignInAvailable {
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isMacOS;
  }

  // ============ Google Sign-In ============

  Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return AuthResult(errorMessage: 'Google sign-in cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return AuthResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      if (e.toString().contains('canceled') ||
          e.toString().contains('cancelled')) {
        return AuthResult(errorMessage: 'Google sign-in cancelled');
      }
      return AuthResult(errorMessage: 'Sign-in failed: ${e.toString()}');
    }
  }

  // ============ Apple Sign-In ============

  Future<AuthResult> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Update display name if provided (Apple only provides on first sign-in)
      if (appleCredential.givenName != null &&
          userCredential.user?.displayName == null) {
        final fullName =
            '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
                .trim();
        if (fullName.isNotEmpty) {
          await userCredential.user?.updateDisplayName(fullName);
          // Reload to get updated profile
          await userCredential.user?.reload();
        }
      }

      return AuthResult(user: _auth.currentUser);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return AuthResult(errorMessage: 'Apple sign-in cancelled');
      }
      return AuthResult(errorMessage: e.message);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      if (e.toString().contains('canceled') ||
          e.toString().contains('cancelled')) {
        return AuthResult(errorMessage: 'Apple sign-in cancelled');
      }
      return AuthResult(errorMessage: 'Sign-in failed: ${e.toString()}');
    }
  }

  // ============ Email/Password ============

  Future<AuthResult> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Send verification email
      await userCredential.user?.sendEmailVerification();

      return AuthResult(
        user: userCredential.user,
        requiresEmailVerification: true,
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'Sign-up failed: ${e.toString()}');
    }
  }

  Future<AuthResult> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        return AuthResult(
          user: userCredential.user,
          requiresEmailVerification: true,
        );
      }

      return AuthResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'Sign-in failed: ${e.toString()}');
    }
  }

  Future<void> sendEmailVerification() async {
    await currentUser?.sendEmailVerification();
  }

  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return AuthResult(); // Success with no user (just email sent)
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'Failed to send reset email');
    }
  }

  /// Reload current user to check for email verification status
  Future<bool> checkEmailVerified() async {
    await currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  // ============ Sign Out ============

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      // Ignore errors from Google sign out
    }
    await _auth.signOut();
  }

  // ============ Account Management ============

  Future<AuthResult> deleteAccount() async {
    try {
      await currentUser?.delete();
      return AuthResult();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return AuthResult(
          errorMessage: 'Please sign in again before deleting your account',
        );
      }
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'Failed to delete account');
    }
  }

  // ============ Error Messages ============

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try signing in instead.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email using a different sign-in method.';
      default:
        return 'Authentication error. Please try again.';
    }
  }
}
