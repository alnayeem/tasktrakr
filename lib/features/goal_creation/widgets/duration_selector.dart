import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/models/duration_option.dart';
import '../../../core/theme/colors.dart';

/// Duration selector chips for goal creation
class DurationSelector extends StatelessWidget {
  final int? selectedDays;
  final ValueChanged<int> onSelected;

  const DurationSelector({
    super.key,
    required this.selectedDays,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: DurationOption.all.map((option) {
        return DurationChip(
          option: option,
          isSelected: selectedDays == option.days,
          label: _getLabel(l10n, option.localizationKey),
          onTap: () => onSelected(option.days),
        );
      }).toList(),
    );
  }

  String _getLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'days7':
        return l10n.days7;
      case 'days14':
        return l10n.days14;
      case 'days21':
        return l10n.days21;
      case 'days30':
        return l10n.days30;
      case 'days60':
        return l10n.days60;
      case 'days90':
        return l10n.days90;
      default:
        return key;
    }
  }
}

/// Individual duration chip widget
class DurationChip extends StatelessWidget {
  final DurationOption option;
  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  const DurationChip({
    super.key,
    required this.option,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _buildDecoration(context),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: isSelected ? AppColors.primary : Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? AppColors.primary : Theme.of(context).dividerColor,
        width: 1.5,
      ),
      boxShadow: isSelected
          ? [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
    );
  }
}
