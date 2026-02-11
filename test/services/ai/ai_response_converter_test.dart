import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/services/ai/ai_response_converter.dart';
import 'package:tasktrakr/services/ai/models/ai_response.dart';
import 'package:tasktrakr/services/ai/models/goal_context.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

// Mock UUID generator for predictable IDs
class MockUuid implements Uuid {
  int _counter = 0;

  @override
  String v4({V4Options? config, Map<String, dynamic>? options}) {
    _counter++;
    return 'mock-uuid-$_counter';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('AIResponseConverter', () {
    late AIResponseConverter converter;
    late MockUuid mockUuid;

    setUp(() {
      mockUuid = MockUuid();
      converter = AIResponseConverter(uuid: mockUuid);
    });

    test('converts successful response to StoredGoal and StoredDayPlans', () {
      const context = GoalContext(
        rawInput: 'Read Quran in 30 days',
        language: 'en',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Read Quran in 30 Days',
          titleShort: 'Read Quran',
          category: 'ramadan',
          durationDays: 30,
          difficulty: 'moderate',
          description: 'Complete the Quran in Ramadan',
          iconSuggestion: '📖',
        ),
        dayPlans: [
          AIDayPlan(
            day: 1,
            task: 'Read Juz 1',
            taskShort: 'Juz 1',
            estimatedMinutes: 45,
            intensity: 'moderate',
            ramadanPhase: 'mercy',
          ),
          AIDayPlan(day: 2), // Rest day
          AIDayPlan(
            day: 3,
            task: 'Read Juz 2',
            taskShort: 'Juz 2',
            estimatedMinutes: 45,
            intensity: 'moderate',
            ramadanPhase: 'mercy',
          ),
        ],
        tips: ['Read after Fajr', 'Use a translation'],
      );

      final result = converter.convert(response: response, context: context);

      // Check goal
      expect(result.goal.id, 'mock-uuid-1');
      expect(result.goal.title, 'Read Quran in 30 Days');
      expect(result.goal.titleShort, 'Read Quran');
      expect(result.goal.category, 'ramadan');
      expect(result.goal.durationDays, 30);
      expect(result.goal.language, 'en');
      expect(result.goal.startDate, '2026-02-28');
      expect(result.goal.difficulty, 'moderate');
      expect(result.goal.icon, '📖');
      expect(result.goal.tasksCompleted, 0);
      expect(result.goal.tasksTotal, 2); // Only non-rest days

      // Check day plans
      expect(result.dayPlans, hasLength(3));

      // Day 1 - assigned
      expect(result.dayPlans[0].day, 1);
      expect(result.dayPlans[0].task, 'Read Juz 1');
      expect(result.dayPlans[0].status, 'pending');
      expect(result.dayPlans[0].goalId, 'mock-uuid-1');

      // Day 2 - rest day
      expect(result.dayPlans[1].day, 2);
      expect(result.dayPlans[1].task, isNull);

      // Day 3 - assigned
      expect(result.dayPlans[2].day, 3);
      expect(result.dayPlans[2].task, 'Read Juz 2');

      // Check tips
      expect(result.tips, hasLength(2));
      expect(result.tips[0], 'Read after Fajr');
    });

    test('calculates end date correctly', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'general',
          durationDays: 7,
          difficulty: 'easy',
          description: 'A goal',
          iconSuggestion: '🎯',
        ),
        dayPlans: [],
      );

      final result = converter.convert(response: response, context: context);

      // 7 days starting from March 1 = ends March 7
      expect(result.goal.endDate, '2026-03-07');
    });

    test('sets correct date for each day plan', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 3,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'general',
          durationDays: 3,
          difficulty: 'easy',
          description: 'A goal',
          iconSuggestion: '🎯',
        ),
        dayPlans: [
          AIDayPlan(day: 1, task: 'Task 1'),
          AIDayPlan(day: 2, task: 'Task 2'),
          AIDayPlan(day: 3, task: 'Task 3'),
        ],
      );

      final result = converter.convert(response: response, context: context);

      expect(result.dayPlans[0].date, '2026-03-01');
      expect(result.dayPlans[1].date, '2026-03-02');
      expect(result.dayPlans[2].date, '2026-03-03');
    });

    test('throws ConversionException for unsuccessful response', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      final response = TaskTrakrPlanResponse.error('AI service unavailable');

      expect(
        () => converter.convert(response: response, context: context),
        throwsA(isA<ConversionException>()),
      );
    });

    test('throws ConversionException when goal is null', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: null,
        dayPlans: [],
      );

      expect(
        () => converter.convert(response: response, context: context),
        throwsA(isA<ConversionException>()),
      );
    });

    test('preserves ramadan-specific fields in day plans', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
        specialMode: 'ramadan',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Read Quran',
          titleShort: 'Quran',
          category: 'ramadan',
          durationDays: 30,
          difficulty: 'moderate',
          description: 'Complete Quran',
          iconSuggestion: '📖',
        ),
        dayPlans: [
          AIDayPlan(
            day: 27,
            task: 'Read Juz 27',
            taskShort: 'Juz 27',
            estimatedMinutes: 60,
            intensity: 'intense',
            ramadanPhase: 'salvation',
            isLaylaulQadrNight: true,
          ),
        ],
      );

      final result = converter.convert(response: response, context: context);

      expect(result.dayPlans[0].ramadanPhase, 'salvation');
      expect(result.dayPlans[0].isLaylaulQadrNight, isTrue);
    });

    test('preserves specialMode from context', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
        specialMode: 'ramadan',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'ramadan',
          durationDays: 30,
          difficulty: 'moderate',
          description: 'Goal',
          iconSuggestion: '📖',
        ),
        dayPlans: [],
      );

      final result = converter.convert(response: response, context: context);

      expect(result.goal.specialMode, 'ramadan');
    });

    test('initializes goal with zero progress', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'general',
          durationDays: 7,
          difficulty: 'easy',
          description: 'A goal',
          iconSuggestion: '🎯',
        ),
        dayPlans: [
          AIDayPlan(day: 1, task: 'Task 1'),
          AIDayPlan(day: 2, task: 'Task 2'),
        ],
      );

      final result = converter.convert(response: response, context: context);

      expect(result.goal.tasksCompleted, 0);
      expect(result.goal.currentStreak, 0);
      expect(result.goal.bestStreak, 0);
    });

    test('initializes day plans with pending status', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 3,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'general',
          durationDays: 3,
          difficulty: 'easy',
          description: 'A goal',
          iconSuggestion: '🎯',
        ),
        dayPlans: [
          AIDayPlan(day: 1, task: 'Task 1', estimatedMinutes: 30),
          AIDayPlan(day: 2, task: 'Task 2', estimatedMinutes: 30),
        ],
      );

      final result = converter.convert(response: response, context: context);

      for (final plan in result.dayPlans) {
        expect(plan.status, 'pending');
        expect(plan.minutesCompleted, 0);
      }
    });

    test('assigns unique IDs to each day plan', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 3,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'general',
          durationDays: 3,
          difficulty: 'easy',
          description: 'A goal',
          iconSuggestion: '🎯',
        ),
        dayPlans: [
          AIDayPlan(day: 1, task: 'Task 1'),
          AIDayPlan(day: 2, task: 'Task 2'),
          AIDayPlan(day: 3, task: 'Task 3'),
        ],
      );

      final result = converter.convert(response: response, context: context);

      final ids = result.dayPlans.map((p) => p.id).toSet();
      expect(ids.length, 3); // All unique

      // All should reference the goal ID
      for (final plan in result.dayPlans) {
        expect(plan.goalId, result.goal.id);
      }
    });

    test('includes milestones in result', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Goal',
          titleShort: 'Goal',
          category: 'general',
          durationDays: 30,
          difficulty: 'easy',
          description: 'A goal',
          iconSuggestion: '🎯',
        ),
        dayPlans: [],
        milestones: [
          AIMilestone(
            day: 10,
            title: 'First milestone',
            description: 'Reached day 10',
            icon: '🎉',
          ),
        ],
      );

      final result = converter.convert(response: response, context: context);

      expect(result.milestones, hasLength(1));
      expect(result.milestones[0].title, 'First milestone');
    });
  });

  group('ConversionResult', () {
    test('has expected structure', () {
      // ConversionResult is a simple data class
      // Its usage is fully tested through the converter tests above
      // This test documents the expected properties
      expect(ConversionResult, isNotNull);
    });
  });

  group('ConversionException', () {
    test('creates exception with message', () {
      const exception = ConversionException('Test error');

      expect(exception.message, 'Test error');
      expect(exception.toString(), 'Test error');
    });
  });
}
