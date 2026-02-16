import 'package:hive/hive.dart';

part 'stored_goal.g.dart';

/// Hive model for persisting goals locally
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
  final String language; // "en", "ar", etc.

  @HiveField(7)
  final int durationDays;

  @HiveField(8)
  final String startDate; // ISO date string

  @HiveField(9)
  final String endDate; // ISO date string

  @HiveField(10)
  final String difficulty; // "easy", "moderate", "challenging"

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
  final String createdAt; // ISO datetime string

  @HiveField(17)
  String updatedAt; // ISO datetime string

  @HiveField(18)
  String? userId; // User ID for multi-user support (null for legacy local data, mutable for migration)

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
    this.userId,
  });

  /// Completion percentage (0.0 to 1.0)
  double get completionPercentage =>
      tasksTotal > 0 ? tasksCompleted / tasksTotal : 0;

  /// Check if this goal is in Ramadan mode
  bool get isRamadanMode => specialMode == 'ramadan' || category == 'ramadan';

  /// Parsed start date
  DateTime get startDateTime => DateTime.parse(startDate);

  /// Parsed end date
  DateTime get endDateTime => DateTime.parse(endDate);

  /// Days remaining until end date
  int get remainingDays {
    final remaining = endDateTime.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Days elapsed since start
  int get elapsedDays {
    final elapsed = DateTime.now().difference(startDateTime).inDays;
    return elapsed > 0 ? elapsed : 0;
  }

  /// Check if goal is completed
  bool get isCompleted => tasksCompleted >= tasksTotal && tasksTotal > 0;

  /// Check if goal is active (started but not completed)
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDateTime) &&
           now.isBefore(endDateTime) &&
           !isCompleted;
  }

  /// Create a copy with updated fields
  StoredGoal copyWith({
    String? id,
    String? title,
    String? titleShort,
    String? category,
    String? icon,
    String? description,
    String? language,
    int? durationDays,
    String? startDate,
    String? endDate,
    String? difficulty,
    String? specialMode,
    int? tasksCompleted,
    int? tasksTotal,
    int? currentStreak,
    int? bestStreak,
    String? createdAt,
    String? updatedAt,
    String? userId,
  }) {
    return StoredGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      titleShort: titleShort ?? this.titleShort,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      language: language ?? this.language,
      durationDays: durationDays ?? this.durationDays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      difficulty: difficulty ?? this.difficulty,
      specialMode: specialMode ?? this.specialMode,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      tasksTotal: tasksTotal ?? this.tasksTotal,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}
