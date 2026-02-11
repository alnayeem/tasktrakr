import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/core/router/route_params.dart';

void main() {
  group('AILoadingParams', () {
    group('constructor', () {
      test('creates with required parameters', () {
        final params = AILoadingParams(
          goalText: 'Read Quran daily',
          durationDays: 30,
        );

        expect(params.goalText, 'Read Quran daily');
        expect(params.durationDays, 30);
        expect(params.category, null);
      });

      test('creates with all parameters', () {
        final params = AILoadingParams(
          goalText: 'Read Quran daily',
          durationDays: 30,
          category: 'ramadan',
        );

        expect(params.goalText, 'Read Quran daily');
        expect(params.durationDays, 30);
        expect(params.category, 'ramadan');
      });
    });

    group('fromQueryParams', () {
      test('parses valid query params', () {
        final queryParams = {
          'goalText': Uri.encodeComponent('Read Quran daily'),
          'durationDays': '30',
          'category': 'ramadan',
        };

        final params = AILoadingParams.fromQueryParams(queryParams);

        expect(params.goalText, 'Read Quran daily');
        expect(params.durationDays, 30);
        expect(params.category, 'ramadan');
      });

      test('parses without optional category', () {
        final queryParams = {
          'goalText': Uri.encodeComponent('Exercise'),
          'durationDays': '7',
        };

        final params = AILoadingParams.fromQueryParams(queryParams);

        expect(params.goalText, 'Exercise');
        expect(params.durationDays, 7);
        expect(params.category, null);
      });

      test('throws when goalText is missing', () {
        final queryParams = {'durationDays': '30'};

        expect(
          () => AILoadingParams.fromQueryParams(queryParams),
          throwsArgumentError,
        );
      });

      test('throws when durationDays is missing', () {
        final queryParams = {'goalText': 'Test'};

        expect(
          () => AILoadingParams.fromQueryParams(queryParams),
          throwsArgumentError,
        );
      });

      test('handles URL encoded special characters', () {
        final queryParams = {
          'goalText': Uri.encodeComponent('Goal with spaces & symbols!'),
          'durationDays': '14',
        };

        final params = AILoadingParams.fromQueryParams(queryParams);

        expect(params.goalText, 'Goal with spaces & symbols!');
      });
    });

    group('toQueryParams', () {
      test('converts to query params map', () {
        final params = AILoadingParams(
          goalText: 'Read Quran',
          durationDays: 30,
          category: 'ramadan',
        );

        final queryParams = params.toQueryParams();

        expect(queryParams['goalText'], Uri.encodeComponent('Read Quran'));
        expect(queryParams['durationDays'], '30');
        expect(queryParams['category'], 'ramadan');
      });

      test('excludes null category', () {
        final params = AILoadingParams(
          goalText: 'Exercise',
          durationDays: 7,
        );

        final queryParams = params.toQueryParams();

        expect(queryParams.containsKey('category'), false);
      });
    });

    group('toQueryString', () {
      test('builds valid query string', () {
        final params = AILoadingParams(
          goalText: 'Test',
          durationDays: 5,
          category: 'fitness',
        );

        final queryString = params.toQueryString();

        expect(queryString, contains('goalText=Test'));
        expect(queryString, contains('durationDays=5'));
        expect(queryString, contains('category=fitness'));
      });
    });

    group('equality', () {
      test('equal params are equal', () {
        final params1 = AILoadingParams(
          goalText: 'Test',
          durationDays: 10,
          category: 'fitness',
        );
        final params2 = AILoadingParams(
          goalText: 'Test',
          durationDays: 10,
          category: 'fitness',
        );

        expect(params1, equals(params2));
        expect(params1.hashCode, equals(params2.hashCode));
      });

      test('different params are not equal', () {
        final params1 = AILoadingParams(
          goalText: 'Test1',
          durationDays: 10,
        );
        final params2 = AILoadingParams(
          goalText: 'Test2',
          durationDays: 10,
        );

        expect(params1, isNot(equals(params2)));
      });
    });

    group('toString', () {
      test('returns readable string', () {
        final params = AILoadingParams(
          goalText: 'Test',
          durationDays: 10,
          category: 'fitness',
        );

        final str = params.toString();

        expect(str, contains('AILoadingParams'));
        expect(str, contains('Test'));
        expect(str, contains('10'));
        expect(str, contains('fitness'));
      });
    });
  });

  group('GoalDetailParams', () {
    group('constructor', () {
      test('creates with goalId', () {
        final params = GoalDetailParams(goalId: 'goal-123');

        expect(params.goalId, 'goal-123');
      });
    });

    group('fromPathParams', () {
      test('parses valid path params', () {
        final pathParams = {'goalId': 'abc-123'};

        final params = GoalDetailParams.fromPathParams(pathParams);

        expect(params.goalId, 'abc-123');
      });

      test('throws when goalId is missing', () {
        final pathParams = <String, String>{};

        expect(
          () => GoalDetailParams.fromPathParams(pathParams),
          throwsArgumentError,
        );
      });
    });

    group('equality', () {
      test('equal params are equal', () {
        final params1 = GoalDetailParams(goalId: 'id-1');
        final params2 = GoalDetailParams(goalId: 'id-1');

        expect(params1, equals(params2));
        expect(params1.hashCode, equals(params2.hashCode));
      });

      test('different params are not equal', () {
        final params1 = GoalDetailParams(goalId: 'id-1');
        final params2 = GoalDetailParams(goalId: 'id-2');

        expect(params1, isNot(equals(params2)));
      });
    });

    group('toString', () {
      test('returns readable string', () {
        final params = GoalDetailParams(goalId: 'goal-xyz');

        final str = params.toString();

        expect(str, contains('GoalDetailParams'));
        expect(str, contains('goal-xyz'));
      });
    });
  });
}
