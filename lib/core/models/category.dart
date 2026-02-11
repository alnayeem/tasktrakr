import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// Represents a goal category
class Category {
  final String id;
  final String emoji;
  final String localizationKey;
  final Color color;

  const Category({
    required this.id,
    required this.emoji,
    required this.localizationKey,
    required this.color,
  });

  /// All available categories
  static const List<Category> all = [
    Category(
      id: 'fitness',
      emoji: '🏃',
      localizationKey: 'categoryFitness',
      color: AppColors.categoryFitness,
    ),
    Category(
      id: 'learning',
      emoji: '📚',
      localizationKey: 'categoryLearning',
      color: AppColors.categoryLearning,
    ),
    Category(
      id: 'ramadan',
      emoji: '🌙',
      localizationKey: 'categoryRamadan',
      color: AppColors.categoryRamadan,
    ),
    Category(
      id: 'wellness',
      emoji: '🧘',
      localizationKey: 'categoryWellness',
      color: AppColors.categoryWellness,
    ),
    Category(
      id: 'creative',
      emoji: '🎨',
      localizationKey: 'categoryCreative',
      color: AppColors.categoryCreative,
    ),
    Category(
      id: 'financial',
      emoji: '💰',
      localizationKey: 'categoryFinancial',
      color: AppColors.categoryFinancial,
    ),
    Category(
      id: 'other',
      emoji: '✨',
      localizationKey: 'categoryOther',
      color: AppColors.categoryOther,
    ),
  ];

  /// Find category by ID
  static Category? findById(String id) {
    try {
      return all.firstWhere((cat) => cat.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get the Ramadan category
  static Category get ramadan => all.firstWhere((cat) => cat.id == 'ramadan');
}
