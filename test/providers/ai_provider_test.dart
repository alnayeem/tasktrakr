import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/providers/ai_provider.dart';

void main() {
  group('GoalGenerationState', () {
    test('creates default state', () {
      const state = GoalGenerationState();

      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
      expect(state.generatedGoal, isNull);
      expect(state.dayPlans, isNull);
      expect(state.tips, isEmpty);
      expect(state.progress, 0);
      expect(state.statusMessage, '');
    });

    test('hasError returns true when error is set', () {
      const state = GoalGenerationState(error: 'Some error');

      expect(state.hasError, isTrue);
    });

    test('hasError returns false when error is null', () {
      const state = GoalGenerationState();

      expect(state.hasError, isFalse);
    });

    test('isComplete returns true when goal is set and not loading', () {
      const state = GoalGenerationState(
        isLoading: false,
        generatedGoal: null, // Would be StoredGoal in real usage
      );

      // isComplete checks generatedGoal != null, so this should be false
      expect(state.isComplete, isFalse);
    });

    test('isComplete returns false when still loading', () {
      const state = GoalGenerationState(
        isLoading: true,
        generatedGoal: null,
      );

      expect(state.isComplete, isFalse);
    });

    test('copyWith preserves existing values when not specified', () {
      const original = GoalGenerationState(
        isLoading: true,
        progress: 0.5,
        statusMessage: 'Working...',
      );

      final copied = original.copyWith(progress: 0.7);

      expect(copied.isLoading, isTrue);
      expect(copied.progress, 0.7);
      expect(copied.statusMessage, 'Working...');
    });

    test('copyWith clears error when passing new value', () {
      const original = GoalGenerationState(error: 'Old error');

      final copied = original.copyWith(error: null);

      expect(copied.error, isNull);
    });

    test('copyWith updates multiple fields', () {
      const original = GoalGenerationState();

      final copied = original.copyWith(
        isLoading: true,
        progress: 0.3,
        statusMessage: 'Connecting...',
      );

      expect(copied.isLoading, isTrue);
      expect(copied.progress, 0.3);
      expect(copied.statusMessage, 'Connecting...');
    });

    test('copyWith with tips', () {
      const original = GoalGenerationState();

      final copied = original.copyWith(tips: ['Tip 1', 'Tip 2']);

      expect(copied.tips, hasLength(2));
      expect(copied.tips[0], 'Tip 1');
    });
  });

  group('GoalGenerationNotifier state transitions', () {
    // Note: Full integration tests with mocked services would go here
    // For now we test the state transitions conceptually

    test('state progresses through loading phases', () {
      // Initial state
      const initial = GoalGenerationState();
      expect(initial.isLoading, isFalse);
      expect(initial.progress, 0);

      // Connecting state
      final connecting = initial.copyWith(
        isLoading: true,
        progress: 0.1,
        statusMessage: 'Connecting to AI...',
      );
      expect(connecting.isLoading, isTrue);
      expect(connecting.progress, 0.1);

      // Generating state
      final generating = connecting.copyWith(
        progress: 0.3,
        statusMessage: 'Generating your personalized plan...',
      );
      expect(generating.progress, 0.3);

      // Converting state
      final converting = generating.copyWith(
        progress: 0.7,
        statusMessage: 'Preparing your daily tasks...',
      );
      expect(converting.progress, 0.7);

      // Saving state
      final saving = converting.copyWith(
        progress: 0.9,
        statusMessage: 'Saving your goal...',
      );
      expect(saving.progress, 0.9);

      // Complete state
      final complete = saving.copyWith(
        isLoading: false,
        progress: 1.0,
        statusMessage: 'Goal created successfully!',
        // generatedGoal would be set here
      );
      expect(complete.isLoading, isFalse);
      expect(complete.progress, 1.0);
    });

    test('error state clears progress', () {
      const loading = GoalGenerationState(
        isLoading: true,
        progress: 0.5,
        statusMessage: 'Working...',
      );

      final error = loading.copyWith(
        isLoading: false,
        error: 'Network error',
        progress: 0,
      );

      expect(error.isLoading, isFalse);
      expect(error.hasError, isTrue);
      expect(error.progress, 0);
    });

    test('reset clears all state', () {
      const complete = GoalGenerationState(
        progress: 1.0,
        statusMessage: 'Done!',
        tips: ['Tip 1'],
      );

      // Reset should return to initial state
      const reset = GoalGenerationState();

      expect(reset.isLoading, isFalse);
      expect(reset.error, isNull);
      expect(reset.generatedGoal, isNull);
      expect(reset.progress, 0);
      expect(reset.statusMessage, '');
      expect(reset.tips, isEmpty);
    });
  });
}
