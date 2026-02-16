import 'package:hive/hive.dart';

part 'app_user.g.dart';

/// Represents the authenticated user
@HiveType(typeId: 3)
class AppUser extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? displayName;

  @HiveField(3)
  final String? photoUrl;

  @HiveField(4)
  final String authProvider; // "google", "apple", "email"

  @HiveField(5)
  final bool emailVerified;

  @HiveField(6)
  final String createdAt;

  @HiveField(7)
  String lastLoginAt;

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.authProvider,
    this.emailVerified = false,
    required this.createdAt,
    required this.lastLoginAt,
  });

  /// Create AppUser from Firebase User
  factory AppUser.fromFirebaseUser({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    required String authProvider,
    bool emailVerified = false,
    String? createdAt,
  }) {
    final now = DateTime.now().toIso8601String();
    return AppUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      authProvider: authProvider,
      emailVerified: emailVerified,
      createdAt: createdAt ?? now,
      lastLoginAt: now,
    );
  }

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? authProvider,
    bool? emailVerified,
    String? createdAt,
    String? lastLoginAt,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      authProvider: authProvider ?? this.authProvider,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  /// Get initials for avatar
  String get initials {
    if (displayName != null && displayName!.isNotEmpty) {
      final parts = displayName!.trim().split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return parts[0][0].toUpperCase();
    }
    if (email != null && email!.isNotEmpty) {
      return email![0].toUpperCase();
    }
    return '?';
  }

  /// Get display name or email fallback
  String get displayNameOrEmail {
    if (displayName != null && displayName!.isNotEmpty) {
      return displayName!;
    }
    return email ?? 'User';
  }

  /// Get auth provider display name
  String get authProviderDisplayName {
    switch (authProvider) {
      case 'google':
        return 'Google';
      case 'apple':
        return 'Apple';
      case 'email':
        return 'Email';
      default:
        return authProvider;
    }
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, displayName: $displayName, '
        'authProvider: $authProvider, emailVerified: $emailVerified)';
  }
}
