import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/goal_repository.dart';
import '../data/repositories/preferences_repository.dart';

/// Provider for GoalRepository instance
/// Use this to access goal and day plan CRUD operations
final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepository();
});

/// Provider for PreferencesRepository instance
/// Use this to access user preferences
final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepository();
});
