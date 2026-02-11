import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/models/category.dart';

/// Category selector grid for goal creation
class CategorySelector extends StatelessWidget {
  final String? selectedCategoryId;
  final ValueChanged<String> onSelected;

  const CategorySelector({
    super.key,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: Category.all.map((category) {
        return CategoryChip(
          category: category,
          isSelected: selectedCategoryId == category.id,
          label: _getLabel(l10n, category.localizationKey),
          onTap: () => onSelected(category.id),
        );
      }).toList(),
    );
  }

  String _getLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'categoryFitness':
        return l10n.categoryFitness;
      case 'categoryLearning':
        return l10n.categoryLearning;
      case 'categoryCreative':
        return l10n.categoryCreative;
      case 'categoryWellness':
        return l10n.categoryWellness;
      case 'categoryFinancial':
        return l10n.categoryFinancial;
      case 'categoryRamadan':
        return l10n.categoryRamadan;
      case 'categoryOther':
        return l10n.categoryOther;
      default:
        return key;
    }
  }
}

/// Individual category chip widget
class CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: _buildDecoration(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(category.emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? category.color : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: isSelected
          ? category.color.withValues(alpha: 0.15)
          : Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? category.color : Theme.of(context).dividerColor,
        width: isSelected ? 2 : 1,
      ),
    );
  }
}
