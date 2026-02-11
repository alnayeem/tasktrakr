import 'package:flutter/material.dart';
import '../../../data/models/stored_goal.dart';
import '../../../core/theme/colors.dart';

/// Compact goal card for the "My Goals" grid section
class GoalCard extends StatelessWidget {
  final StoredGoal goal;
  final VoidCallback? onTap;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
  });

  Color get _accentColor =>
      goal.isRamadanMode ? AppColors.ramadan : AppColors.primary;

  int get _progressPercent => (goal.completionPercentage * 100).toInt();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _buildDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(),
            const SizedBox(height: 12),
            _buildTitle(context),
            const Spacer(),
            _buildProgressSection(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(goal.icon, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      goal.titleShort.isNotEmpty ? goal.titleShort : goal.title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProgressHeader(),
        const SizedBox(height: 6),
        _buildProgressBar(),
      ],
    );
  }

  Widget _buildProgressHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$_progressPercent%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _accentColor,
          ),
        ),
        if (goal.isCompleted)
          const Text(
            '✓',
            style: TextStyle(fontSize: 12, color: AppColors.success),
          ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: goal.completionPercentage,
        backgroundColor: _accentColor.withValues(alpha: 0.15),
        valueColor: AlwaysStoppedAnimation<Color>(
          goal.isCompleted ? AppColors.success : _accentColor,
        ),
        minHeight: 6,
      ),
    );
  }
}

/// Add goal button that looks like a GoalCard
class AddGoalCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const AddGoalCard({
    super.key,
    this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _buildDecoration(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAddIcon(),
            const SizedBox(height: 8),
            _buildLabel(context),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: AppColors.primary.withValues(alpha: 0.3),
        width: 2,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    );
  }

  Widget _buildAddIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
