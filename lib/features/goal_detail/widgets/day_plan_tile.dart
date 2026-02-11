import 'package:flutter/material.dart';
import '../../../data/models/stored_day_plan.dart';
import '../../../core/theme/colors.dart';

/// Individual day plan tile for goal detail screen
class DayPlanTile extends StatelessWidget {
  final StoredDayPlan dayPlan;
  final bool isRamadanMode;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckChanged;

  const DayPlanTile({
    super.key,
    required this.dayPlan,
    this.isRamadanMode = false,
    this.onTap,
    this.onCheckChanged,
  });

  Color get _accentColor =>
      isRamadanMode ? AppColors.ramadan : AppColors.primary;

  bool get _isLocked => dayPlan.isFuture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: _buildDecoration(context),
        child: Opacity(
          opacity: _isLocked ? 0.5 : 1.0,
          child: Row(
            children: [
              _buildDayIndicator(context),
              const SizedBox(width: 16),
              Expanded(child: _buildContent(context)),
              if (!_isLocked) _buildStatusIndicator(context),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getBackgroundColor(context),
      borderRadius: BorderRadius.circular(12),
      border: dayPlan.isToday
          ? Border.all(color: _accentColor, width: 2)
          : null,
    );
  }

  Widget _buildDayIndicator(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _getDayIndicatorColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${dayPlan.day}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _getDayIndicatorTextColor(),
            ),
          ),
          if (dayPlan.isToday)
            Text(
              'Today',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final title = dayPlan.taskShort ?? dayPlan.task ?? 'Rest day';
    final subtitle = dayPlan.notes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                decoration:
                    dayPlan.isCompleted ? TextDecoration.lineThrough : null,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null && subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    if (dayPlan.isCompleted) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 18),
      );
    }

    return GestureDetector(
      onTap: () => onCheckChanged?.call(true),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (dayPlan.isCompleted) {
      return AppColors.success.withValues(alpha: 0.05);
    }
    if (dayPlan.isToday) {
      return Theme.of(context).cardColor;
    }
    return Theme.of(context).scaffoldBackgroundColor;
  }

  Color _getDayIndicatorColor() {
    if (dayPlan.isToday) return _accentColor;
    if (dayPlan.isCompleted) return AppColors.success.withValues(alpha: 0.15);
    return _accentColor.withValues(alpha: 0.1);
  }

  Color _getDayIndicatorTextColor() {
    if (dayPlan.isToday) return Colors.white;
    if (dayPlan.isCompleted) return AppColors.success;
    return _accentColor;
  }
}
