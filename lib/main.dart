import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'data/models/stored_goal.dart';
import 'data/models/stored_day_plan.dart';
import 'data/models/user_preferences.dart';
import 'data/repositories/goal_repository.dart';
import 'data/repositories/preferences_repository.dart';
import 'services/device_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(StoredGoalAdapter());
  Hive.registerAdapter(StoredDayPlanAdapter());
  Hive.registerAdapter(UserPreferencesAdapter());

  // Open boxes
  await Hive.openBox<StoredGoal>(GoalRepository.goalsBoxName);
  await Hive.openBox<StoredDayPlan>(GoalRepository.dayPlansBoxName);
  await Hive.openBox<UserPreferences>(PreferencesRepository.boxName);

  // Initialize device service for rate limiting
  await DeviceService.init();

  // Initialize notification service
  await NotificationService().init();

  runApp(
    const ProviderScope(
      child: TaskTrakrApp(),
    ),
  );
}
