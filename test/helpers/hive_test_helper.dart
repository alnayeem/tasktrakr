import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tasktrakr/data/models/stored_goal.dart';
import 'package:tasktrakr/data/models/stored_day_plan.dart';
import 'package:tasktrakr/data/models/user_preferences.dart';
import 'package:tasktrakr/data/repositories/goal_repository.dart';
import 'package:tasktrakr/data/repositories/preferences_repository.dart';

/// Helper class for setting up Hive in tests
class HiveTestHelper {
  static Directory? _tempDir;

  /// Initialize Hive for testing with a temporary directory
  static Future<void> setUp() async {
    _tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(_tempDir!.path);

    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(StoredGoalAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(StoredDayPlanAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserPreferencesAdapter());
    }

    // Open boxes
    await Hive.openBox<StoredGoal>(GoalRepository.goalsBoxName);
    await Hive.openBox<StoredDayPlan>(GoalRepository.dayPlansBoxName);
    await Hive.openBox<UserPreferences>(PreferencesRepository.boxName);
  }

  /// Clean up Hive after tests
  static Future<void> tearDown() async {
    await Hive.close();
    if (_tempDir != null && await _tempDir!.exists()) {
      await _tempDir!.delete(recursive: true);
    }
    _tempDir = null;
  }

  /// Clear all boxes between tests
  static Future<void> clearBoxes() async {
    await Hive.box<StoredGoal>(GoalRepository.goalsBoxName).clear();
    await Hive.box<StoredDayPlan>(GoalRepository.dayPlansBoxName).clear();
    await Hive.box<UserPreferences>(PreferencesRepository.boxName).clear();
  }

  /// Create a sample goal for testing
  static StoredGoal createSampleGoal({
    String id = 'goal-1',
    String title = 'Read Quran',
    String category = 'ramadan',
    int durationDays = 30,
    int tasksCompleted = 0,
    int tasksTotal = 30,
  }) {
    final now = DateTime.now();
    final startDate = now.toIso8601String().substring(0, 10);
    final endDate = now.add(Duration(days: durationDays)).toIso8601String().substring(0, 10);

    return StoredGoal(
      id: id,
      title: title,
      titleShort: title.split(' ').first,
      category: category,
      icon: '📖',
      description: 'Test goal description',
      language: 'en',
      durationDays: durationDays,
      startDate: startDate,
      endDate: endDate,
      difficulty: 'moderate',
      specialMode: category == 'ramadan' ? 'ramadan' : null,
      tasksCompleted: tasksCompleted,
      tasksTotal: tasksTotal,
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
  }

  /// Create sample day plans for a goal
  static List<StoredDayPlan> createSampleDayPlans({
    required String goalId,
    int count = 7,
    int completedCount = 0,
  }) {
    final now = DateTime.now();
    final plans = <StoredDayPlan>[];

    for (int i = 0; i < count; i++) {
      final date = now.add(Duration(days: i - 2)); // Start 2 days ago
      final isCompleted = i < completedCount;

      plans.add(StoredDayPlan(
        id: 'plan-$goalId-${i + 1}',
        goalId: goalId,
        day: i + 1,
        date: date.toIso8601String().substring(0, 10),
        task: 'Task for day ${i + 1}',
        taskShort: 'Day ${i + 1}',
        estimatedMinutes: 30,
        notes: 'Notes for day ${i + 1}',
        intensity: 'moderate',
        status: isCompleted ? 'completed' : 'pending',
        minutesCompleted: isCompleted ? 30 : 0,
        completedAt: isCompleted ? date.toIso8601String() : null,
      ));
    }

    return plans;
  }
}
