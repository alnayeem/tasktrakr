import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/stored_day_plan.dart';
import '../data/repositories/goal_repository.dart';
import 'repository_providers.dart';

/// State class for day plans
class DayPlansState {
  final List<StoredDayPlan> dayPlans;
  final bool isLoading;
  final String? error;

  const DayPlansState({
    this.dayPlans = const [],
    this.isLoading = false,
    this.error,
  });

  DayPlansState copyWith({
    List<StoredDayPlan>? dayPlans,
    bool? isLoading,
    String? error,
  }) {
    return DayPlansState(
      dayPlans: dayPlans ?? this.dayPlans,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Get completed day plans
  List<StoredDayPlan> get completed =>
      dayPlans.where((p) => p.isCompleted).toList();

  /// Get pending day plans (with assignments)
  List<StoredDayPlan> get pending =>
      dayPlans.where((p) => p.hasAssignment && !p.isCompleted && !p.isFuture).toList();

  /// Get upcoming day plans
  List<StoredDayPlan> get upcoming =>
      dayPlans.where((p) => p.isFuture).toList();

  /// Get today's day plan (if any)
  StoredDayPlan? get today {
    try {
      return dayPlans.firstWhere((p) => p.isToday);
    } catch (_) {
      return null;
    }
  }
}

/// Notifier for managing day plans for a specific goal
class DayPlansNotifier extends StateNotifier<DayPlansState> {
  final GoalRepository _repository;
  final String goalId;

  DayPlansNotifier(this._repository, this.goalId) : super(const DayPlansState()) {
    loadDayPlans();
  }

  /// Load day plans for the goal
  void loadDayPlans() {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final dayPlans = _repository.getDayPlansForGoal(goalId);
      state = state.copyWith(dayPlans: dayPlans, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Complete a day plan
  Future<void> completeDayPlan(String dayPlanId) async {
    try {
      await _repository.completeDayPlan(dayPlanId);
      loadDayPlans(); // Refresh
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Skip a day plan
  Future<void> skipDayPlan(String dayPlanId) async {
    try {
      await _repository.skipDayPlan(dayPlanId);
      loadDayPlans(); // Refresh
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Update progress on a day plan
  Future<void> updateProgress(String dayPlanId, int minutes) async {
    try {
      await _repository.updateProgress(dayPlanId, minutes);
      loadDayPlans(); // Refresh
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Add user notes to a day plan
  Future<void> addNotes(String dayPlanId, String notes) async {
    try {
      await _repository.addUserNotes(dayPlanId, notes);
      loadDayPlans(); // Refresh
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Refresh day plans
  void refresh() => loadDayPlans();
}

/// Provider for day plans of a specific goal
final dayPlansProvider =
    StateNotifierProvider.family<DayPlansNotifier, DayPlansState, String>(
        (ref, goalId) {
  final repository = ref.watch(goalRepositoryProvider);
  return DayPlansNotifier(repository, goalId);
});

/// Provider for today's day plans across all goals
final todayDayPlansProvider = Provider<List<StoredDayPlan>>((ref) {
  final repository = ref.watch(goalRepositoryProvider);
  return repository.getTodaysDayPlans();
});

/// Provider for today's tasks with assignments only
final todayTasksProvider = Provider<List<StoredDayPlan>>((ref) {
  final todayPlans = ref.watch(todayDayPlansProvider);
  return todayPlans.where((p) => p.hasAssignment).toList();
});

/// Provider for pending tasks today (not completed)
final pendingTodayTasksProvider = Provider<List<StoredDayPlan>>((ref) {
  final todayTasks = ref.watch(todayTasksProvider);
  return todayTasks.where((t) => !t.isCompleted).toList();
});

/// Provider for completed tasks today
final completedTodayTasksProvider = Provider<List<StoredDayPlan>>((ref) {
  final todayTasks = ref.watch(todayTasksProvider);
  return todayTasks.where((t) => t.isCompleted).toList();
});

/// Provider for goal progress summary
final goalProgressProvider =
    Provider.family<GoalProgressSummary, String>((ref, goalId) {
  final repository = ref.watch(goalRepositoryProvider);
  return repository.getProgressSummary(goalId);
});
