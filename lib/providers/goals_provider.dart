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
  final String? userId;

  const GoalsState({
    this.goals = const [],
    this.isLoading = false,
    this.error,
    this.userId,
  });

  GoalsState copyWith({
    List<StoredGoal>? goals,
    bool? isLoading,
    String? error,
    String? userId,
    bool clearUserId = false,
  }) {
    return GoalsState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userId: clearUserId ? null : (userId ?? this.userId),
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
  String? _currentUserId;

  GoalsNotifier(this._repository) : super(const GoalsState()) {
    _loadGoals();
  }

  /// Load goals from repository for current user
  void _loadGoals({String? userId}) {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final goals = _repository.getAllGoals(userId: userId);
      _currentUserId = userId;
      state = state.copyWith(goals: goals, isLoading: false, userId: userId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Load goals for a specific user (called on sign-in)
  Future<void> loadForUser(String userId) async {
    // Migrate orphan data to this user on first sign-in
    final migratedCount = await _repository.migrateOrphanDataToUser(userId);
    if (migratedCount > 0) {
      // ignore: avoid_print
      print('GoalsNotifier: Migrated $migratedCount orphan goals to user $userId');
    }
    _loadGoals(userId: userId);
  }

  /// Clear user context (called on sign-out)
  void clearUserContext() {
    _currentUserId = null;
    _loadGoals(userId: null);
  }

  /// Save a new goal with its day plans
  Future<void> saveGoal(StoredGoal goal, List<StoredDayPlan> dayPlans) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Ensure userId is set on goal and day plans
      StoredGoal goalToSave = goal;
      List<StoredDayPlan> plansToSave = dayPlans;

      if (_currentUserId != null && goal.userId == null) {
        goalToSave = goal.copyWith(userId: _currentUserId);
        plansToSave = dayPlans.map((plan) =>
          plan.userId == null ? plan.copyWith(userId: _currentUserId) : plan
        ).toList();
      }

      await _repository.saveGoal(goalToSave, plansToSave);
      _loadGoals(userId: _currentUserId); // Refresh the list
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Delete a goal
  Future<void> deleteGoal(String goalId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.deleteGoal(goalId);
      _loadGoals(userId: _currentUserId); // Refresh the list
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh goals (for pull-to-refresh)
  Future<void> refresh() async {
    _loadGoals(userId: _currentUserId);
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
