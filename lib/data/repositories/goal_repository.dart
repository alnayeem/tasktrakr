import 'package:hive/hive.dart';
import '../models/stored_goal.dart';
import '../models/stored_day_plan.dart';

/// Repository for managing goals and their day plans in Hive
class GoalRepository {
  static const String goalsBoxName = 'goals';
  static const String dayPlansBoxName = 'dayPlans';

  Box<StoredGoal> get _goalsBox => Hive.box<StoredGoal>(goalsBoxName);
  Box<StoredDayPlan> get _dayPlansBox => Hive.box<StoredDayPlan>(dayPlansBoxName);

  // ============ Goal CRUD ============

  /// Save a new goal with its day plans
  Future<void> saveGoal(StoredGoal goal, List<StoredDayPlan> dayPlans) async {
    await _goalsBox.put(goal.id, goal);
    for (final plan in dayPlans) {
      await _dayPlansBox.put(plan.id, plan);
    }
  }

  /// Get all goals for a specific user (or all if userId is null)
  List<StoredGoal> getAllGoals({String? userId}) {
    var goals = _goalsBox.values.toList();
    if (userId != null) {
      goals = goals.where((g) => g.userId == userId).toList();
    }
    return goals..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get a single goal by ID
  StoredGoal? getGoal(String goalId) {
    return _goalsBox.get(goalId);
  }

  /// Get active goals for a specific user (started, not completed, not expired)
  List<StoredGoal> getActiveGoals({String? userId}) {
    var goals = _goalsBox.values.where((goal) => goal.isActive);
    if (userId != null) {
      goals = goals.where((g) => g.userId == userId);
    }
    return goals.toList();
  }

  /// Delete a goal and all its day plans
  Future<void> deleteGoal(String goalId) async {
    await _goalsBox.delete(goalId);

    final plansToDelete = _dayPlansBox.values
        .where((p) => p.goalId == goalId)
        .map((p) => p.id)
        .toList();

    for (final id in plansToDelete) {
      await _dayPlansBox.delete(id);
    }
  }

  // ============ Day Plan Operations ============

  /// Get all day plans for a goal, sorted by day number
  List<StoredDayPlan> getDayPlansForGoal(String goalId) {
    return _dayPlansBox.values
        .where((p) => p.goalId == goalId)
        .toList()
      ..sort((a, b) => a.day.compareTo(b.day));
  }

  /// Get only days with task assignments for a goal
  List<StoredDayPlan> getAssignedDaysForGoal(String goalId) {
    return getDayPlansForGoal(goalId).where((p) => p.hasAssignment).toList();
  }

  /// Get today's day plans across all goals for a specific user
  List<StoredDayPlan> getTodaysDayPlans({String? userId}) {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    var plans = _dayPlansBox.values.where((p) => p.date == today);
    if (userId != null) {
      plans = plans.where((p) => p.userId == userId);
    }
    return plans.toList();
  }

  /// Get today's day plan for a specific goal
  StoredDayPlan? getTodaysDayPlanForGoal(String goalId) {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    try {
      return _dayPlansBox.values
          .firstWhere((p) => p.goalId == goalId && p.date == today);
    } catch (_) {
      return null;
    }
  }

  // ============ Progress Tracking ============

  /// Update progress on a day plan (partial completion)
  Future<void> updateProgress(String dayPlanId, int minutesCompleted) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null && plan.hasAssignment) {
      // Mark as started if first progress
      if (plan.startedAt == null) {
        plan.startedAt = DateTime.now().toIso8601String();
      }

      plan.minutesCompleted = minutesCompleted;

      // Auto-complete if reached estimated time
      if (plan.estimatedMinutes != null &&
          minutesCompleted >= plan.estimatedMinutes!) {
        plan.status = 'completed';
        plan.completedAt = DateTime.now().toIso8601String();
      } else if (minutesCompleted > 0) {
        plan.status = 'in_progress';
      }

      await plan.save();
      await _updateGoalStats(plan.goalId);
    }
  }

  /// Mark a day plan as complete
  Future<void> completeDayPlan(String dayPlanId) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null) {
      plan.status = 'completed';
      plan.completedAt = DateTime.now().toIso8601String();

      // If has assignment, set minutes to estimated
      if (plan.hasAssignment && plan.estimatedMinutes != null) {
        plan.minutesCompleted = plan.estimatedMinutes!;
      }

      await plan.save();
      await _updateGoalStats(plan.goalId);
    }
  }

  /// Skip a day plan
  Future<void> skipDayPlan(String dayPlanId) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null) {
      plan.status = 'skipped';
      await plan.save();
      await _updateGoalStats(plan.goalId);
    }
  }

  /// Add user notes to a day plan
  Future<void> addUserNotes(String dayPlanId, String notes) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null) {
      plan.userNotes = notes;
      await plan.save();
    }
  }

  // ============ Stats & Streaks ============

  /// Update goal statistics based on day plans
  Future<void> _updateGoalStats(String goalId) async {
    final goal = _goalsBox.get(goalId);
    if (goal != null) {
      final dayPlans = getDayPlansForGoal(goalId);
      final assignedDays = dayPlans.where((p) => p.hasAssignment).toList();

      goal.tasksTotal = assignedDays.length;
      goal.tasksCompleted = assignedDays.where((p) => p.isCompleted).length;
      goal.updatedAt = DateTime.now().toIso8601String();

      // Update streak
      goal.currentStreak = _calculateCurrentStreak(dayPlans);
      if (goal.currentStreak > goal.bestStreak) {
        goal.bestStreak = goal.currentStreak;
      }

      await goal.save();
    }
  }

  /// Calculate current streak for a goal
  int _calculateCurrentStreak(List<StoredDayPlan> dayPlans) {
    if (dayPlans.isEmpty) return 0;

    int streak = 0;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // Sort by date descending (most recent first)
    final sortedPlans = List<StoredDayPlan>.from(dayPlans)
      ..sort((a, b) => b.date.compareTo(a.date));

    for (final plan in sortedPlans) {
      final planDate = DateTime.parse(plan.date);

      // Skip future days
      if (planDate.isAfter(todayDate)) continue;

      // Streak continues if: completed or rest day
      if (plan.isCompleted || plan.isRestDay) {
        streak++;
      } else if (plan.status == 'skipped') {
        // Skipped days don't break streak but don't add to it
        continue;
      } else {
        // Pending/in_progress past days break the streak
        if (planDate.isBefore(todayDate)) {
          break;
        }
        // Today's pending/in_progress doesn't break streak yet
      }
    }

    return streak;
  }

  /// Get progress summary for a goal
  GoalProgressSummary getProgressSummary(String goalId) {
    final dayPlans = getDayPlansForGoal(goalId);
    final assignedDays = dayPlans.where((p) => p.hasAssignment).toList();

    int totalMinutesPlanned = 0;
    int totalMinutesCompleted = 0;

    for (final plan in assignedDays) {
      totalMinutesPlanned += plan.estimatedMinutes ?? 0;
      totalMinutesCompleted += plan.minutesCompleted;
    }

    return GoalProgressSummary(
      totalDays: dayPlans.length,
      assignedDays: assignedDays.length,
      completedDays: assignedDays.where((p) => p.isCompleted).length,
      inProgressDays: assignedDays.where((p) => p.status == 'in_progress').length,
      skippedDays: dayPlans.where((p) => p.status == 'skipped').length,
      totalMinutesPlanned: totalMinutesPlanned,
      totalMinutesCompleted: totalMinutesCompleted,
    );
  }

  // ============ Utility ============

  /// Check if any goals exist for a user
  bool hasGoals({String? userId}) {
    if (userId == null) return _goalsBox.isNotEmpty;
    return _goalsBox.values.any((g) => g.userId == userId);
  }

  /// Get total count of goals for a user
  int goalCount({String? userId}) {
    if (userId == null) return _goalsBox.length;
    return _goalsBox.values.where((g) => g.userId == userId).length;
  }

  /// Check if there are orphan goals without a userId (for migration)
  bool hasOrphanGoals() {
    return _goalsBox.values.any((g) => g.userId == null);
  }

  /// Migrate orphan goals/plans (without userId) to a specific user
  Future<int> migrateOrphanDataToUser(String userId) async {
    int migratedCount = 0;

    // Migrate goals without userId
    for (final goal in _goalsBox.values) {
      if (goal.userId == null) {
        goal.userId = userId;
        await goal.save();
        migratedCount++;
      }
    }

    // Migrate day plans without userId
    for (final plan in _dayPlansBox.values) {
      if (plan.userId == null) {
        plan.userId = userId;
        await plan.save();
      }
    }

    return migratedCount;
  }

  /// Clear all data (for testing or reset)
  Future<void> clearAll() async {
    await _goalsBox.clear();
    await _dayPlansBox.clear();
  }
}

/// Summary of goal progress
class GoalProgressSummary {
  final int totalDays;
  final int assignedDays;
  final int completedDays;
  final int inProgressDays;
  final int skippedDays;
  final int totalMinutesPlanned;
  final int totalMinutesCompleted;

  const GoalProgressSummary({
    required this.totalDays,
    required this.assignedDays,
    required this.completedDays,
    required this.inProgressDays,
    required this.skippedDays,
    required this.totalMinutesPlanned,
    required this.totalMinutesCompleted,
  });

  /// Percentage of assigned days completed (0.0 to 1.0)
  double get dayCompletionPercentage =>
      assignedDays > 0 ? completedDays / assignedDays : 0;

  /// Percentage of planned minutes completed (0.0 to 1.0)
  double get minuteCompletionPercentage =>
      totalMinutesPlanned > 0 ? totalMinutesCompleted / totalMinutesPlanned : 0;

  /// Days remaining (not completed, not skipped)
  int get remainingDays => assignedDays - completedDays - skippedDays;
}
