import 'package:hive/hive.dart';
import '../models/user_preferences.dart';

/// Repository for managing user preferences in Hive
class PreferencesRepository {
  static const String boxName = 'preferences';
  static const String _prefsKey = 'user_prefs';

  Box<UserPreferences> get _box => Hive.box<UserPreferences>(boxName);

  /// Get user preferences (creates default if not exists)
  UserPreferences getPreferences() {
    var prefs = _box.get(_prefsKey);
    if (prefs == null) {
      prefs = UserPreferences.defaults();
      _box.put(_prefsKey, prefs);
    }
    return prefs;
  }

  /// Save user preferences
  Future<void> savePreferences(UserPreferences prefs) async {
    await _box.put(_prefsKey, prefs);
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

  /// Reset preferences to defaults
  Future<void> resetToDefaults() async {
    await _box.put(_prefsKey, UserPreferences.defaults());
  }

  /// Clear all preferences (for testing or logout)
  Future<void> clear() async {
    await _box.clear();
  }
}
