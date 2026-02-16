import 'package:hive/hive.dart';
import '../models/user_preferences.dart';

/// Repository for managing user preferences in Hive
class PreferencesRepository {
  static const String boxName = 'preferences';
  static const String _defaultPrefsKey = 'user_prefs';

  Box<UserPreferences> get _box => Hive.box<UserPreferences>(boxName);

  /// Get the storage key for a user (or default key if no userId)
  String _keyForUser(String? userId) => userId ?? _defaultPrefsKey;

  /// Get user preferences for a specific user (creates default if not exists)
  UserPreferences getPreferences({String? userId}) {
    final key = _keyForUser(userId);
    var prefs = _box.get(key);
    if (prefs == null) {
      prefs = UserPreferences.defaults();
      prefs.userId = userId;
      _box.put(key, prefs);
    }
    return prefs;
  }

  /// Save user preferences
  Future<void> savePreferences(UserPreferences prefs) async {
    final key = _keyForUser(prefs.userId);
    await _box.put(key, prefs);
  }

  /// Check if preferences exist for a user
  bool hasPreferences({String? userId}) {
    return _box.containsKey(_keyForUser(userId));
  }

  /// Migrate default preferences to a specific user (first sign-in)
  Future<bool> migrateDefaultPreferencesToUser(String userId) async {
    // Check if user already has preferences
    if (_box.containsKey(userId)) {
      return false; // Already has preferences, no migration needed
    }

    // Check if there are default preferences to migrate
    final defaultPrefs = _box.get(_defaultPrefsKey);
    if (defaultPrefs == null) {
      return false; // No default preferences to migrate
    }

    // Copy default preferences to user
    final userPrefs = UserPreferences(
      language: defaultPrefs.language,
      notificationsEnabled: defaultPrefs.notificationsEnabled,
      reminderTime: defaultPrefs.reminderTime,
      theme: defaultPrefs.theme,
      hapticsEnabled: defaultPrefs.hapticsEnabled,
      soundEnabled: defaultPrefs.soundEnabled,
      onboardingCompleted: defaultPrefs.onboardingCompleted,
      userId: userId,
      hasSeenAuthPrompt: true,
    );
    await _box.put(userId, userPrefs);
    return true;
  }

  // ============ Convenience Methods ============

  /// Get current language code
  String getLanguage() => getPreferences().language;

  /// Set language
  Future<void> setLanguage(String languageCode) async {
    final prefs = getPreferences();
    prefs.language = languageCode;
    await prefs.save();
  }

  /// Get current theme
  String getTheme() => getPreferences().theme;

  /// Set theme ("light", "dark", "system")
  Future<void> setTheme(String theme) async {
    final prefs = getPreferences();
    prefs.theme = theme;
    await prefs.save();
  }

  /// Check if onboarding is completed
  bool isOnboardingCompleted() => getPreferences().onboardingCompleted;

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    final prefs = getPreferences();
    prefs.onboardingCompleted = true;
    await prefs.save();
  }

  /// Get notifications enabled status
  bool areNotificationsEnabled() => getPreferences().notificationsEnabled;

  /// Set notifications enabled
  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = getPreferences();
    prefs.notificationsEnabled = enabled;
    await prefs.save();
  }

  /// Get reminder time
  String? getReminderTime() => getPreferences().reminderTime;

  /// Set reminder time
  Future<void> setReminderTime(String? time) async {
    final prefs = getPreferences();
    prefs.reminderTime = time;
    await prefs.save();
  }

  /// Get haptics enabled status
  bool areHapticsEnabled() => getPreferences().hapticsEnabled;

  /// Set haptics enabled
  Future<void> setHapticsEnabled(bool enabled) async {
    final prefs = getPreferences();
    prefs.hapticsEnabled = enabled;
    await prefs.save();
  }

  /// Get sound enabled status
  bool isSoundEnabled() => getPreferences().soundEnabled;

  /// Set sound enabled
  Future<void> setSoundEnabled(bool enabled) async {
    final prefs = getPreferences();
    prefs.soundEnabled = enabled;
    await prefs.save();
  }

  /// Reset preferences to defaults for a user
  Future<void> resetToDefaults({String? userId}) async {
    final key = _keyForUser(userId);
    final prefs = UserPreferences.defaults();
    prefs.userId = userId;
    await _box.put(key, prefs);
  }

  /// Clear all preferences (for testing or logout)
  Future<void> clear() async {
    await _box.clear();
  }

  /// Clear preferences for a specific user
  Future<void> clearForUser(String userId) async {
    await _box.delete(userId);
  }
}
