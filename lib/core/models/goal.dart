import 'category.dart';

/// Represents a user's goal
class Goal {
  final String id;
  final String title;
  final String icon;
  final String? categoryId;
  final int durationDays;
  final double progress;
  final DateTime createdAt;
  final DateTime? completedAt;

  const Goal({
    required this.id,
    required this.title,
    required this.icon,
    this.categoryId,
    required this.durationDays,
    this.progress = 0.0,
    required this.createdAt,
    this.completedAt,
  });

  /// Check if goal is in Ramadan mode
  bool get isRamadanMode => categoryId == 'ramadan';

  /// Get the category object
  Category? get category =>
      categoryId != null ? Category.findById(categoryId!) : null;

  /// Check if goal is completed
  bool get isCompleted => progress >= 1.0 || completedAt != null;

  /// Calculate remaining days
  int get remainingDays {
    final endDate = createdAt.add(Duration(days: durationDays));
    final remaining = endDate.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Create a copy with updated fields
  Goal copyWith({
    String? id,
    String? title,
    String? icon,
    String? categoryId,
    int? durationDays,
    double? progress,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      categoryId: categoryId ?? this.categoryId,
      durationDays: durationDays ?? this.durationDays,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Sample goals for development
  static List<Goal> get samples => [
    Goal(
      id: '1',
      title: 'Read Quran',
      icon: '📖',
      categoryId: 'ramadan',
      durationDays: 30,
      progress: 0.60,
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
    ),
    Goal(
      id: '2',
      title: 'Run 5K',
      icon: '🏃',
      categoryId: 'fitness',
      durationDays: 30,
      progress: 0.80,
      createdAt: DateTime.now().subtract(const Duration(days: 24)),
    ),
  ];
}
