/// Represents a daily task within a goal
class Task {
  final String id;
  final String goalId;
  final String title;
  final String? description;
  final String goalName;
  final String goalIcon;
  final int streakDays;
  final int estimatedMinutes;
  final bool isCompleted;
  final String? ramadanPhase;
  final DateTime date;

  const Task({
    required this.id,
    required this.goalId,
    required this.title,
    this.description,
    required this.goalName,
    required this.goalIcon,
    this.streakDays = 0,
    this.estimatedMinutes = 0,
    this.isCompleted = false,
    this.ramadanPhase,
    required this.date,
  });

  /// Check if task is in Ramadan mode
  bool get isRamadanMode => ramadanPhase != null;

  /// Create a copy with updated fields
  Task copyWith({
    String? id,
    String? goalId,
    String? title,
    String? description,
    String? goalName,
    String? goalIcon,
    int? streakDays,
    int? estimatedMinutes,
    bool? isCompleted,
    String? ramadanPhase,
    DateTime? date,
  }) {
    return Task(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      description: description ?? this.description,
      goalName: goalName ?? this.goalName,
      goalIcon: goalIcon ?? this.goalIcon,
      streakDays: streakDays ?? this.streakDays,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      ramadanPhase: ramadanPhase ?? this.ramadanPhase,
      date: date ?? this.date,
    );
  }

  /// Sample tasks for development
  static List<Task> get samples => [
    Task(
      id: '1',
      goalId: '1',
      title: 'Read Juz 5 (20 pages)',
      description: 'Surah An-Nisa verses 24-147',
      goalName: 'Read Quran',
      goalIcon: '📖',
      streakDays: 4,
      estimatedMinutes: 35,
      isCompleted: false,
      ramadanPhase: 'mercy',
      date: DateTime.now(),
    ),
    Task(
      id: '2',
      goalId: '2',
      title: 'Run 2K + walk intervals',
      description: 'Warm up 5 min, run 2K, cool down',
      goalName: 'Run 5K',
      goalIcon: '🏃',
      streakDays: 12,
      estimatedMinutes: 25,
      isCompleted: true,
      date: DateTime.now(),
    ),
  ];
}
