import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/models/stored_goal.dart';
import 'package:tasktrakr/data/models/stored_day_plan.dart';
import 'package:tasktrakr/data/repositories/goal_repository.dart';
import '../../helpers/hive_test_helper.dart';

void main() {
  group('GoalRepository', () {
    late GoalRepository repository;

    setUpAll(() async {
      await HiveTestHelper.setUp();
    });

    tearDownAll(() async {
      await HiveTestHelper.tearDown();
    });

    setUp(() async {
      await HiveTestHelper.clearBoxes();
      repository = GoalRepository();
    });

    group('saveGoal', () {
      test('saves goal with day plans', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id);

        await repository.saveGoal(goal, dayPlans);

        expect(repository.getAllGoals().length, 1);
        expect(repository.getDayPlansForGoal(goal.id).length, dayPlans.length);
      });

      test('saves multiple goals', () async {
        final goal1 = HiveTestHelper.createSampleGoal(id: 'goal-1');
        final goal2 = HiveTestHelper.createSampleGoal(id: 'goal-2', title: 'Exercise');

        await repository.saveGoal(goal1, []);
        await repository.saveGoal(goal2, []);

        expect(repository.getAllGoals().length, 2);
      });
    });

    group('getAllGoals', () {
      test('returns empty list when no goals', () {
        expect(repository.getAllGoals(), isEmpty);
      });

      test('returns goals sorted by createdAt descending', () async {
        final goal1 = HiveTestHelper.createSampleGoal(id: 'goal-1');
        await repository.saveGoal(goal1, []);

        // Create second goal with later timestamp
        await Future.delayed(const Duration(milliseconds: 10));
        final goal2 = HiveTestHelper.createSampleGoal(id: 'goal-2');
        await repository.saveGoal(goal2, []);

        final goals = repository.getAllGoals();
        expect(goals.length, 2);
        expect(goals.first.id, 'goal-2'); // Newest first
      });
    });

    group('getGoal', () {
      test('returns goal by ID', () async {
        final goal = HiveTestHelper.createSampleGoal();
        await repository.saveGoal(goal, []);

        final retrieved = repository.getGoal(goal.id);
        expect(retrieved, isNotNull);
        expect(retrieved!.id, goal.id);
        expect(retrieved.title, goal.title);
      });

      test('returns null for non-existent ID', () {
        expect(repository.getGoal('non-existent'), isNull);
      });
    });

    group('deleteGoal', () {
      test('deletes goal and its day plans', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id);

        await repository.saveGoal(goal, dayPlans);
        expect(repository.getAllGoals().length, 1);
        expect(repository.getDayPlansForGoal(goal.id).length, dayPlans.length);

        await repository.deleteGoal(goal.id);

        expect(repository.getAllGoals(), isEmpty);
        expect(repository.getDayPlansForGoal(goal.id), isEmpty);
      });

      test('does not affect other goals', () async {
        final goal1 = HiveTestHelper.createSampleGoal(id: 'goal-1');
        final goal2 = HiveTestHelper.createSampleGoal(id: 'goal-2');
        final plans1 = HiveTestHelper.createSampleDayPlans(goalId: 'goal-1');
        final plans2 = HiveTestHelper.createSampleDayPlans(goalId: 'goal-2');

        await repository.saveGoal(goal1, plans1);
        await repository.saveGoal(goal2, plans2);

        await repository.deleteGoal('goal-1');

        expect(repository.getAllGoals().length, 1);
        expect(repository.getGoal('goal-2'), isNotNull);
        expect(repository.getDayPlansForGoal('goal-2').length, plans2.length);
      });
    });

    group('getDayPlansForGoal', () {
      test('returns day plans sorted by day number', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 5);

        await repository.saveGoal(goal, dayPlans);

        final retrieved = repository.getDayPlansForGoal(goal.id);
        expect(retrieved.length, 5);

        for (int i = 0; i < retrieved.length; i++) {
          expect(retrieved[i].day, i + 1);
        }
      });

      test('returns empty list for non-existent goal', () {
        expect(repository.getDayPlansForGoal('non-existent'), isEmpty);
      });
    });

    group('getAssignedDaysForGoal', () {
      test('returns only days with assignments', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 5);

        // Add a rest day (no task)
        final restDay = StoredDayPlan(
          id: 'rest-day',
          goalId: goal.id,
          day: 6,
          date: DateTime.now().add(const Duration(days: 5)).toIso8601String().substring(0, 10),
          // No task - this is a rest day
        );

        await repository.saveGoal(goal, [...dayPlans, restDay]);

        final assigned = repository.getAssignedDaysForGoal(goal.id);
        expect(assigned.length, 5); // Only the 5 with tasks
      });
    });

    group('completeDayPlan', () {
      test('marks day plan as completed', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);

        await repository.saveGoal(goal, dayPlans);

        await repository.completeDayPlan(dayPlans.first.id);

        final updated = repository.getDayPlansForGoal(goal.id).first;
        expect(updated.status, 'completed');
        expect(updated.completedAt, isNotNull);
        expect(updated.minutesCompleted, 30); // Set to estimated
      });

      test('updates goal stats after completion', () async {
        final goal = HiveTestHelper.createSampleGoal(tasksTotal: 3);
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 3);

        await repository.saveGoal(goal, dayPlans);

        await repository.completeDayPlan(dayPlans[0].id);
        await repository.completeDayPlan(dayPlans[1].id);

        final updatedGoal = repository.getGoal(goal.id)!;
        expect(updatedGoal.tasksCompleted, 2);
      });
    });

    group('skipDayPlan', () {
      test('marks day plan as skipped', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);

        await repository.saveGoal(goal, dayPlans);

        await repository.skipDayPlan(dayPlans.first.id);

        final updated = repository.getDayPlansForGoal(goal.id).first;
        expect(updated.status, 'skipped');
      });
    });

    group('updateProgress', () {
      test('updates minutes completed', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);

        await repository.saveGoal(goal, dayPlans);

        await repository.updateProgress(dayPlans.first.id, 15);

        final updated = repository.getDayPlansForGoal(goal.id).first;
        expect(updated.minutesCompleted, 15);
        expect(updated.status, 'in_progress');
        expect(updated.startedAt, isNotNull);
      });

      test('auto-completes when reaching estimated minutes', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);

        await repository.saveGoal(goal, dayPlans);

        await repository.updateProgress(dayPlans.first.id, 30); // Full 30 minutes

        final updated = repository.getDayPlansForGoal(goal.id).first;
        expect(updated.status, 'completed');
        expect(updated.completedAt, isNotNull);
      });
    });

    group('addUserNotes', () {
      test('adds notes to day plan', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);

        await repository.saveGoal(goal, dayPlans);

        await repository.addUserNotes(dayPlans.first.id, 'Great progress today!');

        final updated = repository.getDayPlansForGoal(goal.id).first;
        expect(updated.userNotes, 'Great progress today!');
      });
    });

    group('getProgressSummary', () {
      test('calculates correct summary', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(
          goalId: goal.id,
          count: 5,
          completedCount: 2,
        );

        await repository.saveGoal(goal, dayPlans);

        final summary = repository.getProgressSummary(goal.id);

        expect(summary.totalDays, 5);
        expect(summary.assignedDays, 5);
        expect(summary.completedDays, 2);
        expect(summary.dayCompletionPercentage, 0.4);
      });
    });

    group('hasGoals', () {
      test('returns false when no goals', () {
        expect(repository.hasGoals(), false);
      });

      test('returns true when goals exist', () async {
        final goal = HiveTestHelper.createSampleGoal();
        await repository.saveGoal(goal, []);

        expect(repository.hasGoals(), true);
      });
    });

    group('goalCount', () {
      test('returns correct count', () async {
        expect(repository.goalCount, 0);

        await repository.saveGoal(HiveTestHelper.createSampleGoal(id: 'g1'), []);
        expect(repository.goalCount, 1);

        await repository.saveGoal(HiveTestHelper.createSampleGoal(id: 'g2'), []);
        expect(repository.goalCount, 2);
      });
    });

    group('clearAll', () {
      test('clears all goals and day plans', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id);

        await repository.saveGoal(goal, dayPlans);
        expect(repository.hasGoals(), true);

        await repository.clearAll();

        expect(repository.hasGoals(), false);
        expect(repository.getDayPlansForGoal(goal.id), isEmpty);
      });
    });
  });

  group('GoalProgressSummary', () {
    test('dayCompletionPercentage handles zero assigned days', () {
      const summary = GoalProgressSummary(
        totalDays: 0,
        assignedDays: 0,
        completedDays: 0,
        inProgressDays: 0,
        skippedDays: 0,
        totalMinutesPlanned: 0,
        totalMinutesCompleted: 0,
      );

      expect(summary.dayCompletionPercentage, 0);
    });

    test('minuteCompletionPercentage handles zero planned minutes', () {
      const summary = GoalProgressSummary(
        totalDays: 5,
        assignedDays: 5,
        completedDays: 2,
        inProgressDays: 1,
        skippedDays: 0,
        totalMinutesPlanned: 0,
        totalMinutesCompleted: 0,
      );

      expect(summary.minuteCompletionPercentage, 0);
    });

    test('remainingDays calculated correctly', () {
      const summary = GoalProgressSummary(
        totalDays: 10,
        assignedDays: 8,
        completedDays: 3,
        inProgressDays: 1,
        skippedDays: 1,
        totalMinutesPlanned: 240,
        totalMinutesCompleted: 90,
      );

      expect(summary.remainingDays, 4); // 8 - 3 - 1
    });
  });
}
