import 'package:hive/hive.dart';

part 'user_preferences.g.dart';

/// Hive model for persisting user preferences locally
@HiveType(typeId: 2)
class UserPreferences extends HiveObject {
  @HiveField(0)
  String language; // "en", "ar", "bn", etc.

  @HiveField(1)
  bool notificationsEnabled;

  @HiveField(2)
  String? reminderTime; // "09:00" format

  @HiveField(3)
  String theme; // "light", "dark", "system"

  @HiveField(4)
  bool hapticsEnabled;

  @HiveField(5)
  bool soundEnabled;

  @HiveField(6)
  bool onboardingCompleted;

  UserPreferences({
    this.language = 'en',
    this.notificationsEnabled = true,
    this.reminderTime,
    this.theme = 'system',
    this.hapticsEnabled = true,
    this.soundEnabled = true,
    this.onboardingCompleted = false,
  });

  /// Create default preferences
  factory UserPreferences.defaults() => UserPreferences();

  /// Create a copy with updated fields
  UserPreferences copyWith({
    String? language,
    bool? notificationsEnabled,
    String? reminderTime,
    String? theme,
    bool? hapticsEnabled,
    bool? soundEnabled,
    bool? onboardingCompleted,
  }) {
    return UserPreferences(
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      theme: theme ?? this.theme,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }
}
