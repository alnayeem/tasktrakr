import 'package:hive/hive.dart';

part 'stored_day_plan.g.dart';

/// Hive model for persisting day plans locally.
/// Each record represents a day in the goal's plan, with an optional task assignment.
@HiveType(typeId: 1)
class StoredDayPlan extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String goalId;

  @HiveField(2)
  final int day; // 1, 2, 3...

  @HiveField(3)
  final String date; // ISO date string (YYYY-MM-DD)

  // Assignment (optional - null means rest day / no task planned)
  @HiveField(4)
  final String? task; // Full task description

  @HiveField(5)
  final String? taskShort; // Shortened task description

  @HiveField(6)
  final int? estimatedMinutes; // null if no assignment

  @HiveField(7)
  final String? notes; // AI-generated notes for the day

  @HiveField(8)
  final String? intensity; // "light", "moderate", "intense"

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

  /// Whether this day has a task assignment
  bool get hasAssignment => task != null;

  /// Whether this is a rest day (no task)
  bool get isRestDay => task == null;

  /// Whether the day plan is completed
  bool get isCompleted => status == 'completed';

  /// Whether user has made any progress
  bool get hasProgress => minutesCompleted > 0 || status == 'in_progress';

  /// Progress percentage (0.0 to 1.0)
  double get progressPercentage {
    if (estimatedMinutes == null || estimatedMinutes == 0) return 0;
    return (minutesCompleted / estimatedMinutes!).clamp(0.0, 1.0);
  }

  /// Check if this day is today
  bool get isToday {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return date == today;
  }

  /// Check if this day is in the past
  bool get isPast {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final planDate = DateTime.parse(date);
    return planDate.isBefore(todayDate);
  }

  /// Check if this day is in the future
  bool get isFuture {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final planDate = DateTime.parse(date);
    return planDate.isAfter(todayDate);
  }

  /// Parsed date
  DateTime get dateTime => DateTime.parse(date);

  /// Create a copy with updated fields
  StoredDayPlan copyWith({
    String? id,
    String? goalId,
    int? day,
    String? date,
    String? task,
    String? taskShort,
    int? estimatedMinutes,
    String? notes,
    String? intensity,
    String? ramadanPhase,
    bool? isLaylaulQadrNight,
    String? status,
    int? minutesCompleted,
    String? startedAt,
    String? completedAt,
    String? userNotes,
  }) {
    return StoredDayPlan(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      day: day ?? this.day,
      date: date ?? this.date,
      task: task ?? this.task,
      taskShort: taskShort ?? this.taskShort,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      notes: notes ?? this.notes,
      intensity: intensity ?? this.intensity,
      ramadanPhase: ramadanPhase ?? this.ramadanPhase,
      isLaylaulQadrNight: isLaylaulQadrNight ?? this.isLaylaulQadrNight,
      status: status ?? this.status,
      minutesCompleted: minutesCompleted ?? this.minutesCompleted,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      userNotes: userNotes ?? this.userNotes,
    );
  }
}
