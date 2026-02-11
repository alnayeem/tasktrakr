import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/repositories/preferences_repository.dart';
import 'package:tasktrakr/providers/preferences_provider.dart';
import 'package:tasktrakr/providers/repository_providers.dart';
import '../helpers/hive_test_helper.dart';

void main() {
  group('PreferencesProvider', () {
    late ProviderContainer container;
    late PreferencesRepository repository;

    setUpAll(() async {
      await HiveTestHelper.setUp();
    });

    tearDownAll(() async {
      await HiveTestHelper.tearDown();
    });

    setUp(() async {
      await HiveTestHelper.clearBoxes();
      container = ProviderContainer();
      repository = container.read(preferencesRepositoryProvider);
    });

    tearDown(() {
      container.dispose();
    });

    group('PreferencesState', () {
      test('initial state has default values', () {
        final state = PreferencesState.initial();

        expect(state.language, 'en');
        expect(state.theme, 'system');
        expect(state.onboardingCompleted, false);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });

      test('convenience getters work correctly', () {
        final state = PreferencesState.initial();

        expect(state.notificationsEnabled, true);
        expect(state.reminderTime, isNull);
        expect(state.hapticsEnabled, true);
        expect(state.soundEnabled, true);
      });

      test('copyWith updates fields', () {
        final original = PreferencesState.initial();
        final updated = original.copyWith(
          isLoading: true,
          error: 'Test error',
        );

        expect(updated.isLoading, true);
        expect(updated.error, 'Test error');
      });
    });

    group('PreferencesNotifier', () {
      test('loads preferences on initialization', () {
        final state = container.read(preferencesProvider);

        expect(state.language, 'en');
        expect(state.theme, 'system');
      });

      test('setLanguage updates language', () async {
        await container.read(preferencesProvider.notifier).setLanguage('ar');

        final state = container.read(preferencesProvider);
        expect(state.language, 'ar');
      });

      test('setTheme updates theme', () async {
        await container.read(preferencesProvider.notifier).setTheme('dark');

        final state = container.read(preferencesProvider);
        expect(state.theme, 'dark');
      });

      test('completeOnboarding sets flag', () async {
        expect(container.read(preferencesProvider).onboardingCompleted, false);

        await container.read(preferencesProvider.notifier).completeOnboarding();

        expect(container.read(preferencesProvider).onboardingCompleted, true);
      });

      test('setNotificationsEnabled updates setting', () async {
        await container
            .read(preferencesProvider.notifier)
            .setNotificationsEnabled(false);

        expect(container.read(preferencesProvider).notificationsEnabled, false);
      });

      test('setReminderTime updates setting', () async {
        await container
            .read(preferencesProvider.notifier)
            .setReminderTime('09:00');

        expect(container.read(preferencesProvider).reminderTime, '09:00');
      });

      test('setHapticsEnabled updates setting', () async {
        await container
            .read(preferencesProvider.notifier)
            .setHapticsEnabled(false);

        expect(container.read(preferencesProvider).hapticsEnabled, false);
      });

      test('setSoundEnabled updates setting', () async {
        await container
            .read(preferencesProvider.notifier)
            .setSoundEnabled(false);

        expect(container.read(preferencesProvider).soundEnabled, false);
      });

      test('resetToDefaults resets all settings', () async {
        // Set custom values
        await container.read(preferencesProvider.notifier).setLanguage('ar');
        await container.read(preferencesProvider.notifier).setTheme('dark');
        await container.read(preferencesProvider.notifier).completeOnboarding();

        // Reset
        await container.read(preferencesProvider.notifier).resetToDefaults();

        final state = container.read(preferencesProvider);
        expect(state.language, 'en');
        expect(state.theme, 'system');
        expect(state.onboardingCompleted, false);
      });

      test('refresh reloads from repository', () async {
        // Change directly in repository
        await repository.setLanguage('bn');

        // Refresh
        container.read(preferencesProvider.notifier).refresh();

        expect(container.read(preferencesProvider).language, 'bn');
      });
    });

    group('onboardingCompletedProvider', () {
      test('returns false by default', () {
        expect(container.read(onboardingCompletedProvider), false);
      });

      test('returns true after completion', () async {
        await container.read(preferencesProvider.notifier).completeOnboarding();

        expect(container.read(onboardingCompletedProvider), true);
      });
    });

    group('themeSettingProvider', () {
      test('returns system by default', () {
        expect(container.read(themeSettingProvider), 'system');
      });

      test('returns updated theme', () async {
        await container.read(preferencesProvider.notifier).setTheme('dark');

        expect(container.read(themeSettingProvider), 'dark');
      });
    });

    group('themeModeProvider', () {
      test('returns ThemeMode.system by default', () {
        expect(container.read(themeModeProvider), ThemeMode.system);
      });

      test('returns ThemeMode.light for light theme', () async {
        await container.read(preferencesProvider.notifier).setTheme('light');

        expect(container.read(themeModeProvider), ThemeMode.light);
      });

      test('returns ThemeMode.dark for dark theme', () async {
        await container.read(preferencesProvider.notifier).setTheme('dark');

        expect(container.read(themeModeProvider), ThemeMode.dark);
      });
    });

    group('notificationsEnabledProvider', () {
      test('returns true by default', () {
        expect(container.read(notificationsEnabledProvider), true);
      });

      test('returns updated value', () async {
        await container
            .read(preferencesProvider.notifier)
            .setNotificationsEnabled(false);

        expect(container.read(notificationsEnabledProvider), false);
      });
    });

    group('hapticsEnabledProvider', () {
      test('returns true by default', () {
        expect(container.read(hapticsEnabledProvider), true);
      });

      test('returns updated value', () async {
        await container
            .read(preferencesProvider.notifier)
            .setHapticsEnabled(false);

        expect(container.read(hapticsEnabledProvider), false);
      });
    });

    group('soundEnabledProvider', () {
      test('returns true by default', () {
        expect(container.read(soundEnabledProvider), true);
      });

      test('returns updated value', () async {
        await container
            .read(preferencesProvider.notifier)
            .setSoundEnabled(false);

        expect(container.read(soundEnabledProvider), false);
      });
    });
  });
}
