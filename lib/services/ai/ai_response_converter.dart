import 'package:uuid/uuid.dart';

import '../../data/models/stored_goal.dart';
import '../../data/models/stored_day_plan.dart';
import 'models/goal_context.dart';
import 'models/ai_response.dart';

/// Converts AI responses to Hive-storable models
class AIResponseConverter {
  final Uuid _uuid;

  AIResponseConverter({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  /// Convert AI response to StoredGoal and StoredDayPlan list
  ConversionResult convert({
    required TaskTrakrPlanResponse response,
    required GoalContext context,
  }) {
    if (!response.success || response.goal == null) {
      throw ConversionException(
        response.errorMessage ?? 'Invalid AI response',
      );
    }

    final goalId = _uuid.v4();
    final now = DateTime.now().toUtc().toIso8601String();
    final aiGoal = response.goal!;

    // Calculate end date
    final startDate = DateTime.parse(context.startDate);
    final endDate = startDate.add(Duration(days: context.durationDays - 1));

    // Count assigned days (non-rest days)
    final assignedDays =
        response.dayPlans.where((p) => p.hasAssignment).length;

    // Create StoredGoal
    final goal = StoredGoal(
      id: goalId,
      title: aiGoal.title,
      titleShort: aiGoal.titleShort,
      category: aiGoal.category,
      icon: aiGoal.iconSuggestion,
      description: aiGoal.description,
      language: context.language,
      durationDays: context.durationDays,
      startDate: context.startDate,
      endDate: _formatDate(endDate),
      difficulty: aiGoal.difficulty,
      specialMode: context.specialMode,
      tasksCompleted: 0,
      tasksTotal: assignedDays,
      currentStreak: 0,
      bestStreak: 0,
      createdAt: now,
      updatedAt: now,
    );

    // Create StoredDayPlan list
    final dayPlans = <StoredDayPlan>[];
    for (final aiPlan in response.dayPlans) {
      final planDate = startDate.add(Duration(days: aiPlan.day - 1));

      final dayPlan = StoredDayPlan(
        id: _uuid.v4(),
        goalId: goalId,
        day: aiPlan.day,
        date: _formatDate(planDate),
        task: aiPlan.task,
        taskShort: aiPlan.taskShort,
        estimatedMinutes: aiPlan.estimatedMinutes,
        notes: aiPlan.notes,
        intensity: aiPlan.intensity,
        ramadanPhase: aiPlan.ramadanPhase,
        isLaylaulQadrNight: aiPlan.isLaylaulQadrNight ?? false,
        status: 'pending',
        minutesCompleted: 0,
      );

      dayPlans.add(dayPlan);
    }

    return ConversionResult(
      goal: goal,
      dayPlans: dayPlans,
      milestones: response.milestones,
      tips: response.tips,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

/// Result of converting AI response to storable models
class ConversionResult {
  final StoredGoal goal;
  final List<StoredDayPlan> dayPlans;
  final List<AIMilestone> milestones;
  final List<String> tips;

  const ConversionResult({
    required this.goal,
    required this.dayPlans,
    this.milestones = const [],
    this.tips = const [],
  });
}

/// Exception thrown when conversion fails
class ConversionException implements Exception {
  final String message;
  const ConversionException(this.message);

  @override
  String toString() => message;
}
