import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/data/models/stored_goal.dart';

void main() {
  group('StoredGoal', () {
    late StoredGoal goal;

    setUp(() {
      goal = StoredGoal(
        id: 'goal-1',
        title: 'Read Quran',
        titleShort: 'Quran',
        category: 'ramadan',
        icon: '📖',
        description: 'Complete reading the Quran in Ramadan',
        language: 'en',
        durationDays: 30,
        startDate: '2026-02-28',
        endDate: '2026-03-29',
        difficulty: 'moderate',
        specialMode: 'ramadan',
        tasksCompleted: 10,
        tasksTotal: 30,
        currentStreak: 5,
        bestStreak: 7,
        createdAt: '2026-02-28T00:00:00.000Z',
        updatedAt: '2026-03-10T00:00:00.000Z',
      );
    });

    group('constructor', () {
      test('creates goal with required fields', () {
        expect(goal.id, 'goal-1');
        expect(goal.title, 'Read Quran');
        expect(goal.titleShort, 'Quran');
        expect(goal.category, 'ramadan');
        expect(goal.icon, '📖');
        expect(goal.durationDays, 30);
      });

      test('creates goal with default mutable values', () {
        final newGoal = StoredGoal(
          id: 'goal-2',
          title: 'Exercise',
          titleShort: 'Exercise',
          category: 'fitness',
          icon: '🏃',
          description: 'Daily workout',
          language: 'en',
          durationDays: 14,
          startDate: '2026-03-01',
          endDate: '2026-03-14',
          difficulty: 'easy',
          tasksTotal: 14,
          createdAt: '2026-03-01T00:00:00.000Z',
          updatedAt: '2026-03-01T00:00:00.000Z',
        );

        expect(newGoal.tasksCompleted, 0);
        expect(newGoal.currentStreak, 0);
        expect(newGoal.bestStreak, 0);
        expect(newGoal.specialMode, isNull);
      });
    });

    group('completionPercentage', () {
      test('calculates correct percentage', () {
        expect(goal.completionPercentage, closeTo(0.333, 0.01));
      });

      test('returns 0 when tasksTotal is 0', () {
        final emptyGoal = goal.copyWith(tasksTotal: 0, tasksCompleted: 0);
        expect(emptyGoal.completionPercentage, 0);
      });

      test('returns 1 when all tasks completed', () {
        final completedGoal = goal.copyWith(tasksCompleted: 30);
        expect(completedGoal.completionPercentage, 1.0);
      });
    });

    group('isRamadanMode', () {
      test('returns true when specialMode is ramadan', () {
        expect(goal.isRamadanMode, true);
      });

      test('returns true when category is ramadan', () {
        // Create a goal with ramadan category but no specialMode
        final categoryGoal = StoredGoal(
          id: 'ramadan-cat',
          title: 'Ramadan Goal',
          titleShort: 'Ramadan',
          category: 'ramadan',
          icon: '🌙',
          description: 'Test',
          language: 'en',
          durationDays: 30,
          startDate: '2026-02-28',
          endDate: '2026-03-29',
          difficulty: 'moderate',
          tasksTotal: 30,
          createdAt: '2026-02-28T00:00:00.000Z',
          updatedAt: '2026-02-28T00:00:00.000Z',
        );
        expect(categoryGoal.isRamadanMode, true);
      });

      test('returns false for non-ramadan goals', () {
        // Create a fitness goal without ramadan
        final fitnessGoal = StoredGoal(
          id: 'fitness-goal',
          title: 'Exercise',
          titleShort: 'Exercise',
          category: 'fitness',
          icon: '🏃',
          description: 'Test',
          language: 'en',
          durationDays: 14,
          startDate: '2026-03-01',
          endDate: '2026-03-14',
          difficulty: 'easy',
          tasksTotal: 14,
          createdAt: '2026-03-01T00:00:00.000Z',
          updatedAt: '2026-03-01T00:00:00.000Z',
        );
        expect(fitnessGoal.isRamadanMode, false);
      });
    });

    group('date parsing', () {
      test('startDateTime parses correctly', () {
        expect(goal.startDateTime, DateTime(2026, 2, 28));
      });

      test('endDateTime parses correctly', () {
        expect(goal.endDateTime, DateTime(2026, 3, 29));
      });
    });

    group('isCompleted', () {
      test('returns true when all tasks completed', () {
        final completedGoal = goal.copyWith(tasksCompleted: 30, tasksTotal: 30);
        expect(completedGoal.isCompleted, true);
      });

      test('returns false when tasks remaining', () {
        expect(goal.isCompleted, false);
      });

      test('returns false when tasksTotal is 0', () {
        final emptyGoal = goal.copyWith(tasksTotal: 0, tasksCompleted: 0);
        expect(emptyGoal.isCompleted, false);
      });
    });

    group('copyWith', () {
      test('copies with updated title', () {
        final updated = goal.copyWith(title: 'New Title');
        expect(updated.title, 'New Title');
        expect(updated.id, goal.id); // Other fields unchanged
      });

      test('copies with updated stats', () {
        final updated = goal.copyWith(
          tasksCompleted: 20,
          currentStreak: 10,
        );
        expect(updated.tasksCompleted, 20);
        expect(updated.currentStreak, 10);
        expect(updated.tasksTotal, goal.tasksTotal); // Unchanged
      });

      test('copies all fields when all provided', () {
        final updated = goal.copyWith(
          id: 'new-id',
          title: 'New Title',
          titleShort: 'New',
          category: 'fitness',
          icon: '🏋️',
          description: 'New description',
          language: 'ar',
          durationDays: 14,
          startDate: '2026-04-01',
          endDate: '2026-04-14',
          difficulty: 'easy',
          specialMode: 'fitness_mode',
          tasksCompleted: 5,
          tasksTotal: 14,
          currentStreak: 3,
          bestStreak: 5,
          createdAt: '2026-04-01T00:00:00.000Z',
          updatedAt: '2026-04-05T00:00:00.000Z',
        );

        expect(updated.id, 'new-id');
        expect(updated.title, 'New Title');
        expect(updated.category, 'fitness');
        expect(updated.specialMode, 'fitness_mode');
      });
    });
  });
}
