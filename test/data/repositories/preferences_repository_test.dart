import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/models/user_preferences.dart';
import 'package:tasktrakr/data/repositories/preferences_repository.dart';
import '../../helpers/hive_test_helper.dart';

void main() {
  group('PreferencesRepository', () {
    late PreferencesRepository repository;

    setUpAll(() async {
      await HiveTestHelper.setUp();
    });

    tearDownAll(() async {
      await HiveTestHelper.tearDown();
    });

    setUp(() async {
      await HiveTestHelper.clearBoxes();
      repository = PreferencesRepository();
    });

    group('getPreferences', () {
      test('returns default preferences when none exist', () {
        final prefs = repository.getPreferences();

        expect(prefs.language, 'en');
        expect(prefs.theme, 'system');
        expect(prefs.onboardingCompleted, false);
      });

      test('returns saved preferences', () async {
        final customPrefs = UserPreferences(
          language: 'ar',
          theme: 'dark',
          onboardingCompleted: true,
        );

        await repository.savePreferences(customPrefs);

        final retrieved = repository.getPreferences();
        expect(retrieved.language, 'ar');
        expect(retrieved.theme, 'dark');
        expect(retrieved.onboardingCompleted, true);
      });
    });

    group('savePreferences', () {
      test('saves and retrieves preferences', () async {
        final prefs = UserPreferences(
          language: 'bn',
          notificationsEnabled: false,
          reminderTime: '08:00',
          theme: 'light',
        );

        await repository.savePreferences(prefs);

        final retrieved = repository.getPreferences();
        expect(retrieved.language, 'bn');
        expect(retrieved.notificationsEnabled, false);
        expect(retrieved.reminderTime, '08:00');
        expect(retrieved.theme, 'light');
      });
    });

    group('setLanguage', () {
      test('updates language', () async {
        expect(repository.getLanguage(), 'en');

        await repository.setLanguage('ar');

        expect(repository.getLanguage(), 'ar');
      });

      test('preserves other settings', () async {
        await repository.setTheme('dark');
        await repository.setLanguage('ar');

        expect(repository.getTheme(), 'dark'); // Preserved
        expect(repository.getLanguage(), 'ar');
      });
    });

    group('getLanguage', () {
      test('returns current language', () {
        expect(repository.getLanguage(), 'en'); // Default
      });
    });

    group('setTheme', () {
      test('sets light theme', () async {
        await repository.setTheme('light');
        expect(repository.getTheme(), 'light');
      });

      test('sets dark theme', () async {
        await repository.setTheme('dark');
        expect(repository.getTheme(), 'dark');
      });

      test('sets system theme', () async {
        await repository.setTheme('system');
        expect(repository.getTheme(), 'system');
      });
    });

    group('getTheme', () {
      test('returns current theme', () {
        expect(repository.getTheme(), 'system'); // Default
      });
    });

    group('isOnboardingCompleted', () {
      test('returns false by default', () {
        expect(repository.isOnboardingCompleted(), false);
      });

      test('returns true after completion', () async {
        await repository.completeOnboarding();
        expect(repository.isOnboardingCompleted(), true);
      });
    });

    group('completeOnboarding', () {
      test('marks onboarding as completed', () async {
        expect(repository.isOnboardingCompleted(), false);

        await repository.completeOnboarding();

        expect(repository.isOnboardingCompleted(), true);
      });
    });

    group('notifications', () {
      test('areNotificationsEnabled returns true by default', () {
        expect(repository.areNotificationsEnabled(), true);
      });

      test('setNotificationsEnabled updates setting', () async {
        await repository.setNotificationsEnabled(false);
        expect(repository.areNotificationsEnabled(), false);

        await repository.setNotificationsEnabled(true);
        expect(repository.areNotificationsEnabled(), true);
      });
    });

    group('reminderTime', () {
      test('getReminderTime returns null by default', () {
        expect(repository.getReminderTime(), isNull);
      });

      test('setReminderTime updates setting', () async {
        await repository.setReminderTime('09:00');
        expect(repository.getReminderTime(), '09:00');

        await repository.setReminderTime('18:30');
        expect(repository.getReminderTime(), '18:30');
      });

      test('setReminderTime can clear setting', () async {
        await repository.setReminderTime('09:00');
        expect(repository.getReminderTime(), '09:00');

        await repository.setReminderTime(null);
        expect(repository.getReminderTime(), isNull);
      });
    });

    group('haptics', () {
      test('areHapticsEnabled returns true by default', () {
        expect(repository.areHapticsEnabled(), true);
      });

      test('setHapticsEnabled updates setting', () async {
        await repository.setHapticsEnabled(false);
        expect(repository.areHapticsEnabled(), false);
      });
    });

    group('sound', () {
      test('isSoundEnabled returns true by default', () {
        expect(repository.isSoundEnabled(), true);
      });

      test('setSoundEnabled updates setting', () async {
        await repository.setSoundEnabled(false);
        expect(repository.isSoundEnabled(), false);
      });
    });

    group('resetToDefaults', () {
      test('resets all settings to defaults', () async {
        // Set custom values
        await repository.setLanguage('ar');
        await repository.setTheme('dark');
        await repository.completeOnboarding();
        await repository.setNotificationsEnabled(false);
        await repository.setReminderTime('08:00');
        await repository.setHapticsEnabled(false);
        await repository.setSoundEnabled(false);

        // Reset
        await repository.resetToDefaults();

        // Verify defaults
        expect(repository.getLanguage(), 'en');
        expect(repository.getTheme(), 'system');
        expect(repository.isOnboardingCompleted(), false);
        expect(repository.areNotificationsEnabled(), true);
        expect(repository.getReminderTime(), isNull);
        expect(repository.areHapticsEnabled(), true);
        expect(repository.isSoundEnabled(), true);
      });
    });

    group('clear', () {
      test('clears all preferences', () async {
        await repository.setLanguage('ar');
        await repository.completeOnboarding();

        await repository.clear();

        // After clear, getting preferences creates new defaults
        expect(repository.getLanguage(), 'en');
        expect(repository.isOnboardingCompleted(), false);
      });
    });
  });
}
