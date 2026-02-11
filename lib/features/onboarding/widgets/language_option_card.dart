import 'package:flutter/material.dart';
import '../../../core/models/language.dart';
import '../../../core/theme/colors.dart';

/// A selectable card displaying a language option
class LanguageOptionCard extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildFlag(),
            const SizedBox(width: 12),
            _buildLabel(context),
            _buildCheckmark(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlag() {
    return Text(
      language.flag,
      style: const TextStyle(fontSize: 24),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            language.nativeName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.primary : null,
                ),
            textDirection: language.isRtl ? TextDirection.rtl : TextDirection.ltr,
          ),
          Text(
            language.englishName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckmark() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isSelected ? 1.0 : 0.0,
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
