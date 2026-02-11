import 'package:flutter/material.dart';
import '../../../data/models/stored_day_plan.dart';
import '../../../data/models/stored_goal.dart';
import '../../../core/theme/colors.dart';

/// Task card widget for displaying daily tasks on dashboard
class TaskCard extends StatefulWidget {
  final StoredDayPlan dayPlan;
  final StoredGoal? goal; // Optional: for displaying goal info
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckChanged;

  const TaskCard({
    super.key,
    required this.dayPlan,
    this.goal,
    this.onTap,
    this.onCheckChanged,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  StoredDayPlan get _dayPlan => widget.dayPlan;
  StoredGoal? get _goal => widget.goal;

  bool get _isRamadanMode =>
      _dayPlan.ramadanPhase != null || (_goal?.isRamadanMode ?? false);

  Color get _accentColor =>
      _isRamadanMode ? AppColors.ramadan : AppColors.primary;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onPressStart(),
      onTapUp: (_) => _onPressEnd(),
      onTapCancel: _onPressCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: _buildCard(context),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: _buildDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox(),
            const SizedBox(width: 12),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: _dayPlan.isCompleted
          ? AppColors.cardTintGreen
          : AppColors.cardTintBlue,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: _dayPlan.isCompleted
            ? AppColors.success.withValues(alpha: 0.3)
            : AppColors.primary.withValues(alpha: 0.1),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: _isPressed ? 0.08 : 0.05),
          blurRadius: _isPressed ? 8 : 12,
          offset: Offset(0, _isPressed ? 2 : 4),
        ),
      ],
    );
  }

  Widget _buildCheckbox() {
    return GestureDetector(
      onTap: () => widget.onCheckChanged?.call(!_dayPlan.isCompleted),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: _dayPlan.isCompleted ? AppColors.success : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _dayPlan.isCompleted
                ? AppColors.success
                : Theme.of(context).dividerColor,
            width: 2,
          ),
        ),
        child: _dayPlan.isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        if (_dayPlan.notes?.isNotEmpty ?? false) ...[
          const SizedBox(height: 4),
          _buildDescription(context),
        ],
        const SizedBox(height: 12),
        _buildBottomRow(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    final title = _dayPlan.taskShort ?? _dayPlan.task ?? 'Rest day';
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            decoration:
                _dayPlan.isCompleted ? TextDecoration.lineThrough : null,
            color: _dayPlan.isCompleted
                ? Theme.of(context).textTheme.bodyMedium?.color
                : null,
          ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      _dayPlan.notes!,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: _dayPlan.isCompleted
                ? Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withValues(alpha: 0.6)
                : null,
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      children: [
        if (_goal != null) ...[
          _buildGoalPill(),
          const SizedBox(width: 8),
        ],
        if (_dayPlan.estimatedMinutes != null) _buildDuration(context),
        const Spacer(),
        if (_goal != null && _goal!.currentStreak > 0) _buildStreakBadge(),
        if (_isRamadanMode) _buildRamadanPhaseBadge(),
      ],
    );
  }

  Widget _buildGoalPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_goal!.icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            _goal!.titleShort.isNotEmpty ? _goal!.titleShort : _goal!.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDuration(BuildContext context) {
    return Text(
      '${_dayPlan.estimatedMinutes} min',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
    );
  }

  Widget _buildStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            '${_goal!.currentStreak}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRamadanPhaseBadge() {
    final (emoji, text) = _getRamadanPhaseInfo();

    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.ramadan.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          if (text.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.ramadan,
              ),
            ),
          ],
        ],
      ),
    );
  }

  (String, String) _getRamadanPhaseInfo() {
    switch (_dayPlan.ramadanPhase) {
      case 'mercy':
        return ('💚', 'Mercy');
      case 'forgiveness':
        return ('💛', 'Forgiveness');
      case 'salvation':
        return ('⭐', 'Salvation');
      default:
        return ('🌙', '');
    }
  }

  void _onPressStart() {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onPressEnd() {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onPressCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }
}
