import 'package:hive/hive.dart';
import '../models/app_user.dart';

/// Repository for managing authenticated user data in Hive
class AuthRepository {
  static const String boxName = 'auth';
  static const String _userKey = 'current_user';

  Box<AppUser> get _box => Hive.box<AppUser>(boxName);

  /// Get cached user from local storage
  AppUser? getCachedUser() {
    try {
      return _box.get(_userKey);
    } catch (e) {
      return null;
    }
  }

  /// Save user to local cache
  Future<void> cacheUser(AppUser user) async {
    await _box.put(_userKey, user);
  }

  /// Clear cached user (on sign out)
  Future<void> clearCachedUser() async {
    await _box.delete(_userKey);
  }

  /// Update last login time for cached user
  Future<void> updateLastLogin(String uid) async {
    final user = getCachedUser();
    if (user != null && user.uid == uid) {
      user.lastLoginAt = DateTime.now().toIso8601String();
      await user.save();
    }
  }

  /// Check if we have a cached user
  bool get hasCachedUser => getCachedUser() != null;

  /// Clear all auth data (for full reset)
  Future<void> clearAll() async {
    await _box.clear();
  }
}
