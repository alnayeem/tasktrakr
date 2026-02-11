import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/stored_goal.dart';
import '../data/models/stored_day_plan.dart';
import '../data/repositories/goal_repository.dart';
import 'repository_providers.dart';

/// State class for goals list
class GoalsState {
  final List<StoredGoal> goals;
  final bool isLoading;
  final String? error;

  const GoalsState({
    this.goals = const [],
    this.isLoading = false,
    this.error,
  });

  GoalsState copyWith({
    List<StoredGoal>? goals,
    bool? isLoading,
    String? error,
  }) {
    return GoalsState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Check if there are any goals
  bool get hasGoals => goals.isNotEmpty;

  /// Get active goals only
  List<StoredGoal> get activeGoals => goals.where((g) => g.isActive).toList();

  /// Get completed goals only
  List<StoredGoal> get completedGoals => goals.where((g) => g.isCompleted).toList();
}

/// Notifier for managing goals state
class GoalsNotifier extends StateNotifier<GoalsState> {
  final GoalRepository _repository;

  GoalsNotifier(this._repository) : super(const GoalsState()) {
    loadGoals();
  }

  /// Load all goals from repository
  void loadGoals() {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final goals = _repository.getAllGoals();
      state = state.copyWith(goals: goals, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Save a new goal with its day plans
  Future<void> saveGoal(StoredGoal goal, List<StoredDayPlan> dayPlans) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.saveGoal(goal, dayPlans);
      loadGoals(); // Refresh the list
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Delete a goal
  Future<void> deleteGoal(String goalId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.deleteGoal(goalId);
      loadGoals(); // Refresh the list
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh goals (for pull-to-refresh)
  Future<void> refresh() async {
    loadGoals();
  }
}

/// Provider for all goals
final goalsProvider = StateNotifierProvider<GoalsNotifier, GoalsState>((ref) {
  final repository = ref.watch(goalRepositoryProvider);
  return GoalsNotifier(repository);
});

/// Provider for a single goal by ID
final goalProvider = Provider.family<StoredGoal?, String>((ref, goalId) {
  final goalsState = ref.watch(goalsProvider);
  try {
    return goalsState.goals.firstWhere((g) => g.id == goalId);
  } catch (_) {
    return null;
  }
});

/// Provider for active goals only
final activeGoalsProvider = Provider<List<StoredGoal>>((ref) {
  return ref.watch(goalsProvider).activeGoals;
});

/// Provider for completed goals only
final completedGoalsProvider = Provider<List<StoredGoal>>((ref) {
  return ref.watch(goalsProvider).completedGoals;
});

/// Provider to check if user has any goals
final hasGoalsProvider = Provider<bool>((ref) {
  return ref.watch(goalsProvider).hasGoals;
});

/// Provider for goal count
final goalCountProvider = Provider<int>((ref) {
  return ref.watch(goalsProvider).goals.length;
});
