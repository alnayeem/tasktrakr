import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/app_user.dart';
import '../data/repositories/auth_repository.dart';
import '../services/auth/auth_service.dart';
import 'goals_provider.dart';
import 'preferences_provider.dart';

/// Auth state enum
enum AuthStatus {
  /// Initial state, checking auth status
  initial,

  /// User is authenticated
  authenticated,

  /// User is not authenticated
  unauthenticated,

  /// Auth operation in progress
  loading,
}

/// Auth state class
class AuthState {
  final AuthStatus status;
  final AppUser? user;
  final String? errorMessage;
  final bool requiresEmailVerification;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.requiresEmailVerification = false,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
  bool get isInitial => status == AuthStatus.initial;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    String? errorMessage,
    bool? requiresEmailVerification,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : errorMessage,
      requiresEmailVerification:
          requiresEmailVerification ?? this.requiresEmailVerification,
    );
  }

  @override
  String toString() {
    return 'AuthState(status: $status, user: ${user?.uid}, error: $errorMessage)';
  }
}

/// Auth state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  final AuthService _authService;
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authSubscription;

  AuthNotifier(this._ref, this._authService, this._authRepository)
      : super(const AuthState()) {
    _init();
  }

  void _init() {
    // Listen to Firebase auth state changes
    _authSubscription = _authService.authStateChanges.listen(
      (firebaseUser) {
        if (firebaseUser != null) {
          _handleSignedIn(firebaseUser);
        } else {
          _handleSignedOut();
        }
      },
      onError: (error) {
        state = const AuthState(status: AuthStatus.unauthenticated);
      },
    );
  }

  void _handleSignedIn(User firebaseUser) {
    final appUser = AppUser.fromFirebaseUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      authProvider: _getAuthProvider(firebaseUser),
      emailVerified: firebaseUser.emailVerified,
      createdAt: firebaseUser.metadata.creationTime?.toIso8601String(),
    );

    _authRepository.cacheUser(appUser);

    // Load user-specific data (preferences and goals)
    _loadUserData(appUser.uid);

    // Check if email verification is required for email/password users
    final needsVerification = !firebaseUser.emailVerified &&
        firebaseUser.providerData.any((p) => p.providerId == 'password');

    state = AuthState(
      status: AuthStatus.authenticated,
      user: appUser,
      requiresEmailVerification: needsVerification,
    );
  }

  /// Load user-specific preferences and goals
  Future<void> _loadUserData(String userId) async {
    // Load preferences for this user (migrates default prefs if needed)
    await _ref.read(preferencesProvider.notifier).loadForUser(userId);

    // Load goals for this user (migrates orphan goals if needed)
    await _ref.read(goalsProvider.notifier).loadForUser(userId);
  }

  void _handleSignedOut() {
    _authRepository.clearCachedUser();

    // Clear user-specific data contexts
    _ref.read(preferencesProvider.notifier).clearUserContext();
    _ref.read(goalsProvider.notifier).clearUserContext();

    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  String _getAuthProvider(User user) {
    for (final provider in user.providerData) {
      if (provider.providerId == 'google.com') return 'google';
      if (provider.providerId == 'apple.com') return 'apple';
      if (provider.providerId == 'password') return 'email';
    }
    return 'unknown';
  }

  // ============ Sign-In Methods ============

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading, clearError: true);
    final result = await _authService.signInWithGoogle();
    if (!result.isSuccess && !result.isCancelled) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: result.errorMessage,
      );
    } else if (result.isCancelled) {
      // User cancelled, just go back to unauthenticated without error
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        clearError: true,
      );
    }
    // Success handled by auth state listener
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.loading, clearError: true);
    final result = await _authService.signInWithApple();
    if (!result.isSuccess && !result.isCancelled) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: result.errorMessage,
      );
    } else if (result.isCancelled) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        clearError: true,
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, clearError: true);
    final result = await _authService.signInWithEmail(email, password);
    if (!result.isSuccess) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: result.errorMessage,
      );
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, clearError: true);
    final result = await _authService.signUpWithEmail(email, password);
    if (!result.isSuccess) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: result.errorMessage,
      );
    }
    // If successful, will require email verification (handled by listener)
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    state = state.copyWith(status: AuthStatus.loading, clearError: true);
    final result = await _authService.sendPasswordResetEmail(email);
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      errorMessage: result.errorMessage,
    );
    return result.errorMessage == null;
  }

  Future<void> resendVerificationEmail() async {
    await _authService.sendEmailVerification();
  }

  Future<bool> checkEmailVerified() async {
    final verified = await _authService.checkEmailVerified();
    if (verified && state.user != null) {
      // Update state to remove verification requirement
      state = state.copyWith(
        requiresEmailVerification: false,
        user: state.user!.copyWith(emailVerified: true),
      );
    }
    return verified;
  }

  Future<void> signOut() async {
    state = state.copyWith(status: AuthStatus.loading);
    await _authService.signOut();
    // State will be updated by auth listener
  }

  Future<bool> deleteAccount() async {
    state = state.copyWith(status: AuthStatus.loading, clearError: true);
    final result = await _authService.deleteAccount();
    if (result.errorMessage != null) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        errorMessage: result.errorMessage,
      );
      return false;
    }
    // State will be updated by auth listener after deletion
    return true;
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Check if Apple Sign-In is available
  bool get isAppleSignInAvailable => _authService.isAppleSignInAvailable;

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

// ============ Providers ============

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Main auth state provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(ref, authService, authRepository);
});

/// Convenience provider: Check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

/// Convenience provider: Get current user
final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authProvider).user;
});

/// Convenience provider: Get user ID
final userIdProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).user?.uid;
});

/// Convenience provider: Get auth status
final authStatusProvider = Provider<AuthStatus>((ref) {
  return ref.watch(authProvider).status;
});

/// Convenience provider: Check if auth is still initializing
final authInitializingProvider = Provider<bool>((ref) {
  final status = ref.watch(authStatusProvider);
  return status == AuthStatus.initial;
});

/// Convenience provider: Check if email verification is needed
final needsEmailVerificationProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).requiresEmailVerification;
});
