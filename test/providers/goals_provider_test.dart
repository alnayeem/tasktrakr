import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/repositories/goal_repository.dart';
import 'package:tasktrakr/providers/goals_provider.dart';
import 'package:tasktrakr/providers/repository_providers.dart';
import '../helpers/hive_test_helper.dart';

void main() {
  group('GoalsProvider', () {
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

    group('GoalsState', () {
      test('initial state has empty goals', () {
        const state = GoalsState();
        expect(state.goals, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });

      test('hasGoals returns true when goals exist', () {
        final state = GoalsState(
          goals: [HiveTestHelper.createSampleGoal()],
        );
        expect(state.hasGoals, true);
      });

      test('hasGoals returns false when empty', () {
        const state = GoalsState();
        expect(state.hasGoals, false);
      });

      test('activeGoals filters correctly', () {
        final now = DateTime.now();
        final activeGoal = HiveTestHelper.createSampleGoal(id: 'active');
        final completedGoal = HiveTestHelper.createSampleGoal(
          id: 'completed',
          tasksCompleted: 30,
          tasksTotal: 30,
        );

        final state = GoalsState(goals: [activeGoal, completedGoal]);

        expect(state.activeGoals.length, 1);
        expect(state.activeGoals.first.id, 'active');
      });

      test('completedGoals filters correctly', () {
        final activeGoal = HiveTestHelper.createSampleGoal(id: 'active');
        final completedGoal = HiveTestHelper.createSampleGoal(
          id: 'completed',
          tasksCompleted: 30,
          tasksTotal: 30,
        );

        final state = GoalsState(goals: [activeGoal, completedGoal]);

        expect(state.completedGoals.length, 1);
        expect(state.completedGoals.first.id, 'completed');
      });

      test('copyWith updates fields', () {
        const original = GoalsState(isLoading: true);
        final updated = original.copyWith(isLoading: false, error: 'Test error');

        expect(updated.isLoading, false);
        expect(updated.error, 'Test error');
      });
    });

    group('GoalsNotifier', () {
      test('loadGoals populates state from repository', () async {
        // Add goals to repository first
        final goal = HiveTestHelper.createSampleGoal();
        await repository.saveGoal(goal, []);

        // Create new container to trigger load
        container.dispose();
        container = ProviderContainer();

        final state = container.read(goalsProvider);
        expect(state.goals.length, 1);
        expect(state.goals.first.id, goal.id);
      });

      test('saveGoal adds goal and refreshes', () async {
        final goal = HiveTestHelper.createSampleGoal();
        final dayPlans = HiveTestHelper.createSampleDayPlans(goalId: goal.id);

        await container.read(goalsProvider.notifier).saveGoal(goal, dayPlans);

        final state = container.read(goalsProvider);
        expect(state.goals.length, 1);
      });

      test('deleteGoal removes goal and refreshes', () async {
        final goal = HiveTestHelper.createSampleGoal();
        await repository.saveGoal(goal, []);

        // Refresh to load the goal
        container.read(goalsProvider.notifier).refresh();

        await container.read(goalsProvider.notifier).deleteGoal(goal.id);

        final state = container.read(goalsProvider);
        expect(state.goals, isEmpty);
      });

      test('refresh reloads goals from repository', () async {
        // Add goal directly to repository
        final goal = HiveTestHelper.createSampleGoal();
        await repository.saveGoal(goal, []);

        // State should not have it yet
        final stateBefore = container.read(goalsProvider);

        // Refresh
        container.read(goalsProvider.notifier).refresh();

        final stateAfter = container.read(goalsProvider);
        expect(stateAfter.goals.length, 1);
      });
    });

    group('goalProvider', () {
      test('returns goal by ID', () async {
        final goal = HiveTestHelper.createSampleGoal(id: 'test-goal');
        await repository.saveGoal(goal, []);

        container.read(goalsProvider.notifier).refresh();

        final retrieved = container.read(goalProvider('test-goal'));
        expect(retrieved, isNotNull);
        expect(retrieved!.id, 'test-goal');
      });

      test('returns null for non-existent ID', () {
        final retrieved = container.read(goalProvider('non-existent'));
        expect(retrieved, isNull);
      });
    });

    group('hasGoalsProvider', () {
      test('returns false when no goals', () {
        expect(container.read(hasGoalsProvider), false);
      });

      test('returns true when goals exist', () async {
        final goal = HiveTestHelper.createSampleGoal();
        await repository.saveGoal(goal, []);
        container.read(goalsProvider.notifier).refresh();

        expect(container.read(hasGoalsProvider), true);
      });
    });

    group('goalCountProvider', () {
      test('returns correct count', () async {
        expect(container.read(goalCountProvider), 0);

        await repository.saveGoal(HiveTestHelper.createSampleGoal(id: 'g1'), []);
        await repository.saveGoal(HiveTestHelper.createSampleGoal(id: 'g2'), []);
        container.read(goalsProvider.notifier).refresh();

        expect(container.read(goalCountProvider), 2);
      });
    });
  });
}
