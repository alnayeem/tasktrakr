# TaskTrakr Data Models

> Load after: [00-MVP-PLAN.md](./00-MVP-PLAN.md)

## Overview

All data stored locally using **Hive** (NoSQL). No server database.

```
Hive Boxes:
├── goals       → StoredGoal
├── dayPlans    → StoredDayPlan (renamed from tasks)
├── milestones  → StoredMilestone (post-MVP)
└── preferences → UserPreferences
```

---

## Dart Models (Flutter/Hive)

### StoredGoal

```dart
import 'package:hive/hive.dart';

part 'stored_goal.g.dart';

@HiveType(typeId: 0)
class StoredGoal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String titleShort;

  @HiveField(3)
  final String category; // "fitness", "ramadan", etc.

  @HiveField(4)
  final String icon; // Emoji

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String language; // "en" or "ar"

  @HiveField(7)
  final int durationDays;

  @HiveField(8)
  final String startDate; // ISO date

  @HiveField(9)
  final String endDate;

  @HiveField(10)
  final String difficulty;

  @HiveField(11)
  final String? specialMode; // "ramadan" | null

  // Stats (mutable)
  @HiveField(12)
  int tasksCompleted;

  @HiveField(13)
  int tasksTotal;

  @HiveField(14)
  int currentStreak;

  @HiveField(15)
  int bestStreak;

  @HiveField(16)
  final String createdAt;

  @HiveField(17)
  String updatedAt;

  StoredGoal({
    required this.id,
    required this.title,
    required this.titleShort,
    required this.category,
    required this.icon,
    required this.description,
    required this.language,
    required this.durationDays,
    required this.startDate,
    required this.endDate,
    required this.difficulty,
    this.specialMode,
    this.tasksCompleted = 0,
    required this.tasksTotal,
    this.currentStreak = 0,
    this.bestStreak = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  double get completionPercentage =>
      tasksTotal > 0 ? tasksCompleted / tasksTotal : 0;

  bool get isRamadanMode => specialMode == 'ramadan';
}
```

---

### StoredDayPlan

> **Renamed from `StoredTask`** - Each record represents a day in the goal's plan, with an optional assignment.

```dart
@HiveType(typeId: 1)
class StoredDayPlan extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String goalId;

  @HiveField(2)
  final int day; // 1, 2, 3...

  @HiveField(3)
  final String date; // Calculated ISO date

  // Assignment (optional - null means no planned task for this day)
  @HiveField(4)
  final String? task; // Full description (null = rest day / no assignment)

  @HiveField(5)
  final String? taskShort;

  @HiveField(6)
  final int? estimatedMinutes; // null if no assignment

  @HiveField(7)
  final String? notes;

  @HiveField(8)
  final String? intensity; // "light", "moderate", "intense" (null if no assignment)

  // Ramadan-specific
  @HiveField(9)
  final String? ramadanPhase; // "mercy", "forgiveness", "salvation"

  @HiveField(10)
  final bool isLaylaulQadrNight;

  // Progress tracking (mutable)
  @HiveField(11)
  String status; // "pending", "in_progress", "completed", "skipped"

  @HiveField(12)
  int minutesCompleted; // Partial progress: 0 to estimatedMinutes

  @HiveField(13)
  String? startedAt; // When user first marked progress

  @HiveField(14)
  String? completedAt; // When status changed to "completed"

  @HiveField(15)
  String? userNotes; // Optional notes from user about their progress

  StoredDayPlan({
    required this.id,
    required this.goalId,
    required this.day,
    required this.date,
    this.task,
    this.taskShort,
    this.estimatedMinutes,
    this.notes,
    this.intensity,
    this.ramadanPhase,
    this.isLaylaulQadrNight = false,
    this.status = 'pending',
    this.minutesCompleted = 0,
    this.startedAt,
    this.completedAt,
    this.userNotes,
  });

  // Computed properties
  bool get hasAssignment => task != null;

  bool get isRestDay => task == null;

  bool get isCompleted => status == 'completed';

  bool get hasProgress => minutesCompleted > 0 || status == 'in_progress';

  double get progressPercentage {
    if (estimatedMinutes == null || estimatedMinutes == 0) return 0;
    return (minutesCompleted / estimatedMinutes!).clamp(0.0, 1.0);
  }

  bool get isToday {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return date == today;
  }

  bool get isPast {
    return DateTime.parse(date).isBefore(DateTime.now());
  }

  bool get isFuture {
    final todayDate = DateTime.now();
    final taskDate = DateTime.parse(date);
    return taskDate.isAfter(todayDate);
  }
}
```

---

### UserPreferences

```dart
@HiveType(typeId: 2)
class UserPreferences extends HiveObject {
  @HiveField(0)
  String language; // "en" | "ar"

  @HiveField(1)
  bool notificationsEnabled;

  @HiveField(2)
  String? reminderTime; // "09:00"

  @HiveField(3)
  String theme; // "light" | "dark" | "system"

  @HiveField(4)
  bool hapticsEnabled;

  @HiveField(5)
  bool soundEnabled;

  @HiveField(6)
  bool onboardingCompleted;

  UserPreferences({
    this.language = 'en',
    this.notificationsEnabled = true,
    this.reminderTime,
    this.theme = 'system',
    this.hapticsEnabled = true,
    this.soundEnabled = true,
    this.onboardingCompleted = false,
  });
}
```

---

## Hive Setup

```dart
// main.dart
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(StoredGoalAdapter());
  Hive.registerAdapter(StoredDayPlanAdapter());
  Hive.registerAdapter(UserPreferencesAdapter());

  // Open boxes
  await Hive.openBox<StoredGoal>('goals');
  await Hive.openBox<StoredDayPlan>('dayPlans');
  await Hive.openBox<UserPreferences>('preferences');

  runApp(const TaskTrakrApp());
}
```

---

## Repository Pattern

```dart
class GoalRepository {
  final Box<StoredGoal> _goalsBox = Hive.box('goals');
  final Box<StoredDayPlan> _dayPlansBox = Hive.box('dayPlans');

  // Create goal with day plans
  Future<void> saveGoal(StoredGoal goal, List<StoredDayPlan> dayPlans) async {
    await _goalsBox.put(goal.id, goal);
    for (final plan in dayPlans) {
      await _dayPlansBox.put(plan.id, plan);
    }
  }

  // Get all goals
  List<StoredGoal> getAllGoals() {
    return _goalsBox.values.toList();
  }

  // Get day plans for goal
  List<StoredDayPlan> getDayPlansForGoal(String goalId) {
    return _dayPlansBox.values
        .where((p) => p.goalId == goalId)
        .toList()
      ..sort((a, b) => a.day.compareTo(b.day));
  }

  // Get today's day plans (across all goals)
  List<StoredDayPlan> getTodaysDayPlans() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return _dayPlansBox.values.where((p) => p.date == today).toList();
  }

  // Get days with assignments only
  List<StoredDayPlan> getAssignedDaysForGoal(String goalId) {
    return getDayPlansForGoal(goalId).where((p) => p.hasAssignment).toList();
  }

  // Update progress on a day plan
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

  // Mark day as complete (regardless of minutes)
  Future<void> completeDayPlan(String dayPlanId) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null) {
      plan.status = 'completed';
      plan.completedAt = DateTime.now().toIso8601String();

      // If has assignment, set minutes to estimated (user finished early or completed)
      if (plan.hasAssignment && plan.estimatedMinutes != null) {
        plan.minutesCompleted = plan.estimatedMinutes!;
      }

      await plan.save();
      await _updateGoalStats(plan.goalId);
    }
  }

  // Skip a day
  Future<void> skipDayPlan(String dayPlanId) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null) {
      plan.status = 'skipped';
      await plan.save();
      await _updateGoalStats(plan.goalId);
    }
  }

  // Add user notes to a day
  Future<void> addUserNotes(String dayPlanId, String notes) async {
    final plan = _dayPlansBox.get(dayPlanId);
    if (plan != null) {
      plan.userNotes = notes;
      await plan.save();
    }
  }

  Future<void> _updateGoalStats(String goalId) async {
    final goal = _goalsBox.get(goalId);
    if (goal != null) {
      final dayPlans = getDayPlansForGoal(goalId);
      final assignedDays = dayPlans.where((p) => p.hasAssignment).toList();

      goal.tasksTotal = assignedDays.length;
      goal.tasksCompleted = assignedDays.where((p) => p.isCompleted).length;
      goal.updatedAt = DateTime.now().toIso8601String();

      // Update streak
      goal.currentStreak = _calculateStreak(dayPlans);
      if (goal.currentStreak > goal.bestStreak) {
        goal.bestStreak = goal.currentStreak;
      }

      await goal.save();
    }
  }

  int _calculateStreak(List<StoredDayPlan> dayPlans) {
    int streak = 0;
    final today = DateTime.now();

    for (int i = dayPlans.length - 1; i >= 0; i--) {
      final plan = dayPlans[i];
      final planDate = DateTime.parse(plan.date);

      if (planDate.isAfter(today)) continue;

      // Streak continues if: completed, rest day (no assignment), or skipped
      if (plan.isCompleted || plan.isRestDay) {
        streak++;
      } else if (plan.status == 'skipped') {
        // Skipped days don't break streak but don't add to it
        continue;
      } else {
        break;
      }
    }

    return streak;
  }

  // Delete goal and its day plans
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

  // Get progress summary for a goal
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
}

class GoalProgressSummary {
  final int totalDays;
  final int assignedDays;
  final int completedDays;
  final int inProgressDays;
  final int skippedDays;
  final int totalMinutesPlanned;
  final int totalMinutesCompleted;

  GoalProgressSummary({
    required this.totalDays,
    required this.assignedDays,
    required this.completedDays,
    required this.inProgressDays,
    required this.skippedDays,
    required this.totalMinutesPlanned,
    required this.totalMinutesCompleted,
  });

  double get dayCompletionPercentage =>
      assignedDays > 0 ? completedDays / assignedDays : 0;

  double get minuteCompletionPercentage =>
      totalMinutesPlanned > 0 ? totalMinutesCompleted / totalMinutesPlanned : 0;
}
```

---

## Type Definitions

```dart
enum CategoryType {
  fitness,
  learning,
  creative,
  wellness,
  financial,
  ramadan,
  other,
}

enum Difficulty {
  easy,
  moderate,
  challenging,
}

enum TaskIntensity {
  light,
  moderate,
  intense,
}

enum DayPlanStatus {
  pending,     // Not started
  in_progress, // User has logged some progress
  completed,   // Fully done
  skipped,     // User chose to skip this day
}

enum RamadanPhase {
  mercy,      // Days 1-10
  forgiveness, // Days 11-20
  salvation,  // Days 21-30
}
```

---

## Data Flow

```
AI Response (JSON)
       ↓
  Parse & Validate
       ↓
  Transform to Dart models
       ↓
  Generate UUIDs
       ↓
  Calculate dates from startDate
       ↓
  Save to Hive boxes
       ↓
  UI reads from Hive (reactive)
```
