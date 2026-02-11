import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/repositories/goal_repository.dart';
import 'package:tasktrakr/providers/day_plans_provider.dart';
import 'package:tasktrakr/providers/repository_providers.dart';
import '../helpers/hive_test_helper.dart';

void main() {
  group('DayPlansProvider', () {
    late ProviderContainer container;
    late GoalRepository repository;

    setUpAll(() async {
      await HiveTestHelper.setUp();
    });

    tearDownAll(() async {
      await HiveTestHelper.tearDown();
    });

    setUp(() async {
      await HiveTestHelper.clearBoxes();
      container = ProviderContainer();
      repository = container.read(goalRepositoryProvider);
    });

    tearDown(() {
      container.dispose();
    });

    group('DayPlansState', () {
      test('initial state has empty day plans', () {
        const state = DayPlansState();
        expect(state.dayPlans, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });

      test('completed returns only completed plans', () {
        final plans = HiveTestHelper.createSampleDayPlans(
          goalId: 'goal-1',
          count: 5,
          completedCount: 2,
        );
        final state = DayPlansState(dayPlans: plans);

        expect(state.completed.length, 2);
        expect(state.completed.every((p) => p.isCompleted), true);
      });

      test('today returns today\'s plan', () {
        final plans = HiveTestHelper.createSampleDayPlans(
          goalId: 'goal-1',
          count: 5,
        );
        final state = DayPlansState(dayPlans: plans);

        // The third plan should be today (index 2, because plans start 2 days ago)
        final today = state.today;
        expect(today, isNotNull);
        expect(today!.isToday, true);
      });

      test('today returns null when no today plan', () {
        // All plans in the past
        final plans = HiveTestHelper.createSampleDayPlans(
          goalId: 'goal-1',
          count: 2, // Only 2 days, both in past
        );
        // Modify dates to be all in the past
        const state = DayPlansState(dayPlans: []);

        expect(state.today, isNull);
      });

      test('copyWith updates fields', () {
        const original = DayPlansState(isLoading: true);
        final updated = original.copyWith(isLoading: false, error: 'Test');

        expect(updated.isLoading, false);
        expect(updated.error, 'Test');
      });
    });

    group('DayPlansNotifier', () {
      test('loadDayPlans populates state from repository', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 5);
        await repository.saveGoal(goal, dayPlans);

        // Create notifier for the goal
        final state = container.read(dayPlansProvider(goal.id));

        expect(state.dayPlans.length, 5);
      });

      test('completeDayPlan updates status', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);
        await repository.saveGoal(goal, dayPlans);

        final notifier = container.read(dayPlansProvider(goal.id).notifier);
        await notifier.completeDayPlan(dayPlans.first.id);

        final state = container.read(dayPlansProvider(goal.id));
        expect(state.dayPlans.first.isCompleted, true);
      });

      test('skipDayPlan updates status', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);
        await repository.saveGoal(goal, dayPlans);

        final notifier = container.read(dayPlansProvider(goal.id).notifier);
        await notifier.skipDayPlan(dayPlans.first.id);

        final state = container.read(dayPlansProvider(goal.id));
        expect(state.dayPlans.first.status, 'skipped');
      });

      test('updateProgress updates minutes', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);
        await repository.saveGoal(goal, dayPlans);

        final notifier = container.read(dayPlansProvider(goal.id).notifier);
        await notifier.updateProgress(dayPlans.first.id, 15);

        final state = container.read(dayPlansProvider(goal.id));
        expect(state.dayPlans.first.minutesCompleted, 15);
        expect(state.dayPlans.first.status, 'in_progress');
      });

      test('addNotes adds user notes', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 1);
        await repository.saveGoal(goal, dayPlans);

        final notifier = container.read(dayPlansProvider(goal.id).notifier);
        await notifier.addNotes(dayPlans.first.id, 'My notes');

        final state = container.read(dayPlansProvider(goal.id));
        expect(state.dayPlans.first.userNotes, 'My notes');
      });

      test('refresh reloads from repository', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 3);
        await repository.saveGoal(goal, dayPlans);

        // Get initial state
        container.read(dayPlansProvider(goal.id));

        // Add more plans directly to repository
        await repository.completeDayPlan(dayPlans.first.id);

        // Refresh
        container.read(dayPlansProvider(goal.id).notifier).refresh();

        final state = container.read(dayPlansProvider(goal.id));
        expect(state.dayPlans.first.isCompleted, true);
      });
    });

    group('todayDayPlansProvider', () {
      test('returns today\'s plans across all goals', () async {
        final goal1 = HiveTestHelper.createSampleGoal(id: 'goal-1');
        final goal2 = HiveTestHelper.createSampleGoal(id: 'goal-2');
        final plans1 = HiveTestHelper.createSampleDayPlans(goalId: 'goal-1', count: 5);
        final plans2 = HiveTestHelper.createSampleDayPlans(goalId: 'goal-2', count: 5);

        await repository.saveGoal(goal1, plans1);
        await repository.saveGoal(goal2, plans2);

        final todayPlans = container.read(todayDayPlansProvider);

        // Should have 2 today plans (one from each goal)
        expect(todayPlans.length, 2);
        expect(todayPlans.every((p) => p.isToday), true);
      });
    });

    group('todayTasksProvider', () {
      test('returns only plans with assignments', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final plans = HiveTestHelper.createSampleDayPlans(goalId: goal.id, count: 5);
        await repository.saveGoal(goal, plans);

        final todayTasks = container.read(todayTasksProvider);

        // All our sample plans have tasks
        expect(todayTasks.every((p) => p.hasAssignment), true);
      });
    });

    group('goalProgressProvider', () {
      test('returns progress summary for goal', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final plans = HiveTestHelper.createSampleDayPlans(
          goalId: goal.id,
          count: 5,
          completedCount: 2,
        );
        await repository.saveGoal(goal, plans);

        final progress = container.read(goalProgressProvider(goal.id));

        expect(progress.totalDays, 5);
        expect(progress.completedDays, 2);
        expect(progress.dayCompletionPercentage, 0.4);
      });
    });
  });
}
