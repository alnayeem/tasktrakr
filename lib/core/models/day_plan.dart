/// Represents a daily plan within a goal
class DayPlan {
  final int dayNumber;
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool isToday;
  final bool isLocked;

  const DayPlan({
    required this.dayNumber,
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.isToday = false,
    this.isLocked = false,
  });

  /// Create a copy with updated fields
  DayPlan copyWith({
    int? dayNumber,
    String? title,
    String? subtitle,
    bool? isCompleted,
    bool? isToday,
    bool? isLocked,
  }) {
    return DayPlan(
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
      isToday: isToday ?? this.isToday,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  /// Sample day plans for development
  static List<DayPlan> get samples => [
    const DayPlan(
      dayNumber: 1,
      title: 'Read Juz 1',
      subtitle: 'Al-Fatiha & Al-Baqarah 1-141',
      isCompleted: true,
    ),
    const DayPlan(
      dayNumber: 2,
      title: 'Read Juz 2',
      subtitle: 'Al-Baqarah 142-252',
      isCompleted: true,
    ),
    const DayPlan(
      dayNumber: 3,
      title: 'Read Juz 3',
      subtitle: 'Al-Baqarah 253 - Al-Imran 92',
      isCompleted: true,
    ),
    const DayPlan(
      dayNumber: 4,
      title: 'Read Juz 4',
      subtitle: 'Al-Imran 93 - An-Nisa 23',
      isCompleted: true,
    ),
    const DayPlan(
      dayNumber: 5,
      title: 'Read Juz 5',
      subtitle: 'An-Nisa 24-147',
      isToday: true,
    ),
    const DayPlan(
      dayNumber: 6,
      title: 'Read Juz 6',
      subtitle: 'An-Nisa 148 - Al-Maidah 81',
      isLocked: true,
    ),
    const DayPlan(
      dayNumber: 7,
      title: 'Read Juz 7',
      subtitle: 'Al-Maidah 82 - Al-Anam 110',
      isLocked: true,
    ),
  ];
}
