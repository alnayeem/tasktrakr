import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/models/user_preferences.dart';

void main() {
  group('UserPreferences', () {
    group('constructor', () {
      test('creates preferences with default values', () {
        final prefs = UserPreferences();

        expect(prefs.language, 'en');
        expect(prefs.notificationsEnabled, true);
        expect(prefs.reminderTime, isNull);
        expect(prefs.theme, 'system');
        expect(prefs.hapticsEnabled, true);
        expect(prefs.soundEnabled, true);
        expect(prefs.onboardingCompleted, false);
      });

      test('creates preferences with custom values', () {
        final prefs = UserPreferences(
          language: 'ar',
          notificationsEnabled: false,
          reminderTime: '09:00',
          theme: 'dark',
          hapticsEnabled: false,
          soundEnabled: false,
          onboardingCompleted: true,
        );

        expect(prefs.language, 'ar');
        expect(prefs.notificationsEnabled, false);
        expect(prefs.reminderTime, '09:00');
        expect(prefs.theme, 'dark');
        expect(prefs.hapticsEnabled, false);
        expect(prefs.soundEnabled, false);
        expect(prefs.onboardingCompleted, true);
      });
    });

    group('factory defaults', () {
      test('creates default preferences', () {
        final prefs = UserPreferences.defaults();

        expect(prefs.language, 'en');
        expect(prefs.theme, 'system');
        expect(prefs.onboardingCompleted, false);
      });
    });

    group('copyWith', () {
      test('copies with updated language', () {
        final prefs = UserPreferences();
        final updated = prefs.copyWith(language: 'ar');

        expect(updated.language, 'ar');
        expect(updated.theme, prefs.theme); // Unchanged
      });

      test('copies with updated theme', () {
        final prefs = UserPreferences();
        final updated = prefs.copyWith(theme: 'dark');

        expect(updated.theme, 'dark');
        expect(updated.language, prefs.language); // Unchanged
      });

      test('copies with updated notifications', () {
        final prefs = UserPreferences();
        final updated = prefs.copyWith(
          notificationsEnabled: false,
          reminderTime: '08:00',
        );

        expect(updated.notificationsEnabled, false);
        expect(updated.reminderTime, '08:00');
      });

      test('copies with all fields', () {
        final prefs = UserPreferences();
        final updated = prefs.copyWith(
          language: 'bn',
          notificationsEnabled: false,
          reminderTime: '07:30',
          theme: 'light',
          hapticsEnabled: false,
          soundEnabled: false,
          onboardingCompleted: true,
        );

        expect(updated.language, 'bn');
        expect(updated.notificationsEnabled, false);
        expect(updated.reminderTime, '07:30');
        expect(updated.theme, 'light');
        expect(updated.hapticsEnabled, false);
        expect(updated.soundEnabled, false);
        expect(updated.onboardingCompleted, true);
      });
    });

    group('mutable fields', () {
      test('language can be modified directly', () {
        final prefs = UserPreferences();
        prefs.language = 'ar';
        expect(prefs.language, 'ar');
      });

      test('theme can be modified directly', () {
        final prefs = UserPreferences();
        prefs.theme = 'dark';
        expect(prefs.theme, 'dark');
      });

      test('onboardingCompleted can be modified directly', () {
        final prefs = UserPreferences();
        prefs.onboardingCompleted = true;
        expect(prefs.onboardingCompleted, true);
      });
    });

    group('valid values', () {
      test('accepts valid language codes', () {
        final languages = ['en', 'ar', 'bn', 'de', 'es', 'fr', 'hi', 'id', 'ms', 'tr', 'ur', 'uz'];

        for (final lang in languages) {
          final prefs = UserPreferences(language: lang);
          expect(prefs.language, lang);
        }
      });

      test('accepts valid theme values', () {
        final themes = ['light', 'dark', 'system'];

        for (final theme in themes) {
          final prefs = UserPreferences(theme: theme);
          expect(prefs.theme, theme);
        }
      });

      test('accepts valid reminder time format', () {
        final times = ['00:00', '09:00', '12:30', '23:59'];

        for (final time in times) {
          final prefs = UserPreferences(reminderTime: time);
          expect(prefs.reminderTime, time);
        }
      });
    });
  });
}
