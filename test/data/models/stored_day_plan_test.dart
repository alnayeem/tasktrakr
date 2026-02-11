import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/models/stored_day_plan.dart';

void main() {
  group('StoredDayPlan', () {
    late StoredDayPlan dayPlan;
    late String todayDate;

    setUp(() {
      todayDate = DateTime.now().toIso8601String().substring(0, 10);

      dayPlan = StoredDayPlan(
        id: 'plan-1',
        goalId: 'goal-1',
        day: 5,
        date: todayDate,
        task: 'Read Juz 5 of the Quran',
        taskShort: 'Read Juz 5',
        estimatedMinutes: 30,
        notes: 'Focus on understanding the meaning',
        intensity: 'moderate',
        ramadanPhase: 'mercy',
        isLaylaulQadrNight: false,
        status: 'pending',
        minutesCompleted: 0,
      );
    });

    group('constructor', () {
      test('creates day plan with required fields', () {
        expect(dayPlan.id, 'plan-1');
        expect(dayPlan.goalId, 'goal-1');
        expect(dayPlan.day, 5);
        expect(dayPlan.date, todayDate);
      });

      test('creates day plan with default values', () {
        final plan = StoredDayPlan(
          id: 'plan-2',
          goalId: 'goal-1',
          day: 1,
          date: '2026-03-01',
        );

        expect(plan.task, isNull);
        expect(plan.status, 'pending');
        expect(plan.minutesCompleted, 0);
        expect(plan.isLaylaulQadrNight, false);
      });
    });

    group('hasAssignment', () {
      test('returns true when task is set', () {
        expect(dayPlan.hasAssignment, true);
      });

      test('returns false when task is null', () {
        final restDay = dayPlan.copyWith(task: null);
        // Note: copyWith doesn't allow setting to null, so we create new
        final restDayPlan = StoredDayPlan(
          id: 'plan-rest',
          goalId: 'goal-1',
          day: 7,
          date: '2026-03-07',
        );
        expect(restDayPlan.hasAssignment, false);
      });
    });

    group('isRestDay', () {
      test('returns false when task is set', () {
        expect(dayPlan.isRestDay, false);
      });

      test('returns true when task is null', () {
        final restDayPlan = StoredDayPlan(
          id: 'plan-rest',
          goalId: 'goal-1',
          day: 7,
          date: '2026-03-07',
        );
        expect(restDayPlan.isRestDay, true);
      });
    });

    group('isCompleted', () {
      test('returns true when status is completed', () {
        final completedPlan = dayPlan.copyWith(status: 'completed');
        expect(completedPlan.isCompleted, true);
      });

      test('returns false for other statuses', () {
        expect(dayPlan.isCompleted, false);

        final inProgress = dayPlan.copyWith(status: 'in_progress');
        expect(inProgress.isCompleted, false);

        final skipped = dayPlan.copyWith(status: 'skipped');
        expect(skipped.isCompleted, false);
      });
    });

    group('hasProgress', () {
      test('returns true when minutes completed > 0', () {
        final withProgress = dayPlan.copyWith(minutesCompleted: 10);
        expect(withProgress.hasProgress, true);
      });

      test('returns true when status is in_progress', () {
        final inProgress = dayPlan.copyWith(status: 'in_progress');
        expect(inProgress.hasProgress, true);
      });

      test('returns false when no progress', () {
        expect(dayPlan.hasProgress, false);
      });
    });

    group('progressPercentage', () {
      test('calculates correct percentage', () {
        final withProgress = dayPlan.copyWith(minutesCompleted: 15);
        expect(withProgress.progressPercentage, 0.5);
      });

      test('returns 0 when estimatedMinutes is null', () {
        final noEstimate = StoredDayPlan(
          id: 'plan-3',
          goalId: 'goal-1',
          day: 1,
          date: '2026-03-01',
          task: 'Some task',
          minutesCompleted: 10,
        );
        expect(noEstimate.progressPercentage, 0);
      });

      test('returns 0 when estimatedMinutes is 0', () {
        final zeroEstimate = dayPlan.copyWith(estimatedMinutes: 0);
        expect(zeroEstimate.progressPercentage, 0);
      });

      test('clamps to 1.0 when over 100%', () {
        final overComplete = dayPlan.copyWith(minutesCompleted: 60);
        expect(overComplete.progressPercentage, 1.0);
      });
    });

    group('isToday', () {
      test('returns true for today date', () {
        expect(dayPlan.isToday, true);
      });

      test('returns false for other dates', () {
        final yesterday = dayPlan.copyWith(date: '2020-01-01');
        expect(yesterday.isToday, false);
      });
    });

    group('isPast', () {
      test('returns true for past dates', () {
        final pastPlan = dayPlan.copyWith(date: '2020-01-01');
        expect(pastPlan.isPast, true);
      });

      test('returns false for today', () {
        // Today is not "past" - it's current
        expect(dayPlan.isPast, false);
      });

      test('returns false for future dates', () {
        final futurePlan = dayPlan.copyWith(date: '2030-12-31');
        expect(futurePlan.isPast, false);
      });
    });

    group('isFuture', () {
      test('returns true for future dates', () {
        final futurePlan = dayPlan.copyWith(date: '2030-12-31');
        expect(futurePlan.isFuture, true);
      });

      test('returns false for today', () {
        expect(dayPlan.isFuture, false);
      });

      test('returns false for past dates', () {
        final pastPlan = dayPlan.copyWith(date: '2020-01-01');
        expect(pastPlan.isFuture, false);
      });
    });

    group('dateTime', () {
      test('parses date correctly', () {
        final plan = dayPlan.copyWith(date: '2026-03-15');
        expect(plan.dateTime, DateTime(2026, 3, 15));
      });
    });

    group('copyWith', () {
      test('copies with updated status', () {
        final updated = dayPlan.copyWith(status: 'completed');
        expect(updated.status, 'completed');
        expect(updated.id, dayPlan.id);
      });

      test('copies with updated progress', () {
        final updated = dayPlan.copyWith(
          status: 'in_progress',
          minutesCompleted: 15,
          startedAt: '2026-03-05T10:00:00.000Z',
        );
        expect(updated.status, 'in_progress');
        expect(updated.minutesCompleted, 15);
        expect(updated.startedAt, '2026-03-05T10:00:00.000Z');
      });

      test('copies with user notes', () {
        final updated = dayPlan.copyWith(userNotes: 'Great progress today!');
        expect(updated.userNotes, 'Great progress today!');
      });
    });

    group('Ramadan features', () {
      test('stores ramadan phase', () {
        expect(dayPlan.ramadanPhase, 'mercy');
      });

      test('stores Laylatul Qadr flag', () {
        final qadrNight = dayPlan.copyWith(isLaylaulQadrNight: true);
        expect(qadrNight.isLaylaulQadrNight, true);
      });
    });
  });
}
