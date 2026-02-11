import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/core/router/app_routes.dart';

void main() {
  group('AppRoute', () {
    group('path', () {
      test('languageSelection has correct path', () {
        expect(AppRoute.languageSelection.path, '/language');
      });

      test('welcome has correct path', () {
        expect(AppRoute.welcome.path, '/welcome');
      });

      test('dashboard has correct path', () {
        expect(AppRoute.dashboard.path, '/dashboard');
      });

      test('goalCreation has correct path', () {
        expect(AppRoute.goalCreation.path, '/goal/create');
      });

      test('aiLoading has correct path', () {
        expect(AppRoute.aiLoading.path, '/goal/loading');
      });

      test('goalDetail has correct path with parameter', () {
        expect(AppRoute.goalDetail.path, '/goal/:goalId');
      });

      test('settings has correct path', () {
        expect(AppRoute.settings.path, '/settings');
      });
    });

    group('isInitial', () {
      test('languageSelection is initial', () {
        expect(AppRoute.languageSelection.isInitial, true);
      });

      test('dashboard is not initial', () {
        expect(AppRoute.dashboard.isInitial, false);
      });
    });

    group('isOnboarding', () {
      test('languageSelection is onboarding', () {
        expect(AppRoute.languageSelection.isOnboarding, true);
      });

      test('welcome is onboarding', () {
        expect(AppRoute.welcome.isOnboarding, true);
      });

      test('dashboard is not onboarding', () {
        expect(AppRoute.dashboard.isOnboarding, false);
      });

      test('settings is not onboarding', () {
        expect(AppRoute.settings.isOnboarding, false);
      });
    });

    group('requiresOnboardingComplete', () {
      test('languageSelection does not require onboarding complete', () {
        expect(AppRoute.languageSelection.requiresOnboardingComplete, false);
      });

      test('welcome does not require onboarding complete', () {
        expect(AppRoute.welcome.requiresOnboardingComplete, false);
      });

      test('dashboard requires onboarding complete', () {
        expect(AppRoute.dashboard.requiresOnboardingComplete, true);
      });

      test('goalCreation requires onboarding complete', () {
        expect(AppRoute.goalCreation.requiresOnboardingComplete, true);
      });

      test('settings requires onboarding complete', () {
        expect(AppRoute.settings.requiresOnboardingComplete, true);
      });
    });

    group('buildPath', () {
      test('builds path without parameters', () {
        expect(AppRoute.dashboard.buildPath(), '/dashboard');
      });

      test('builds path with parameters', () {
        final path = AppRoute.goalDetail.buildPath(
          params: {'goalId': 'abc123'},
        );
        expect(path, '/goal/abc123');
      });

      test('ignores unused parameters', () {
        final path = AppRoute.dashboard.buildPath(
          params: {'unused': 'value'},
        );
        expect(path, '/dashboard');
      });
    });

    group('fromPath', () {
      test('finds languageSelection from path', () {
        expect(AppRoute.fromPath('/language'), AppRoute.languageSelection);
      });

      test('finds dashboard from path', () {
        expect(AppRoute.fromPath('/dashboard'), AppRoute.dashboard);
      });

      test('finds goalDetail from path with parameter', () {
        expect(AppRoute.fromPath('/goal/abc123'), AppRoute.goalDetail);
      });

      test('returns null for unknown path', () {
        expect(AppRoute.fromPath('/unknown'), null);
      });

      test('ignores query parameters when matching', () {
        expect(AppRoute.fromPath('/dashboard?foo=bar'), AppRoute.dashboard);
      });
    });

    group('withGoalId', () {
      test('builds goal detail path with ID', () {
        final path = AppRoute.goalDetail.withGoalId('goal-123');
        expect(path, '/goal/goal-123');
      });

      test('throws for non-goalDetail routes', () {
        expect(
          () => AppRoute.dashboard.withGoalId('id'),
          throwsArgumentError,
        );
      });
    });
  });
}
