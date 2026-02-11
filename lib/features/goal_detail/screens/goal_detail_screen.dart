import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/stored_day_plan.dart';
import '../../../data/models/stored_goal.dart';
import '../../../core/theme/colors.dart';
import '../../../providers/providers.dart';
import '../widgets/day_plan_tile.dart';

/// Goal detail screen
/// Shows full progress, streak, and all day plans for a goal
class GoalDetailScreen extends ConsumerWidget {
  final String goalId;

  const GoalDetailScreen({
    super.key,
    required this.goalId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRtl = ref.watch(isRtlProvider);
    final l10n = AppLocalizations.of(context)!;
    final goal = ref.watch(goalProvider(goalId));
    final dayPlansState = ref.watch(dayPlansProvider(goalId));

    if (goal == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.myGoals)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              const Text('Goal not found'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final dayPlans = dayPlansState.dayPlans;
    final todayPlans = dayPlans.where((p) => p.isToday).toList();
    final upcomingPlans = dayPlans.where((p) => p.isFuture).toList();
    final completedPlans = dayPlans.where((p) => p.isCompleted).toList();

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: _buildAppBar(context, l10n, isRtl, goal, ref),
        body: dayPlansState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProgressHeader(goal: goal, l10n: l10n),
                    const SizedBox(height: 24),
                    _StatsRow(goal: goal, l10n: l10n),
                    const SizedBox(height: 32),
                    if (goal.isRamadanMode) ...[
                      _RamadanPhase(l10n: l10n),
                      const SizedBox(height: 24),
                    ],
                    _TodaySection(
                      todayPlans: todayPlans,
                      goal: goal,
                      l10n: l10n,
                    ),
                    const SizedBox(height: 24),
                    _UpcomingSection(
                      upcomingPlans: upcomingPlans,
                      goal: goal,
                      l10n: l10n,
                    ),
                    const SizedBox(height: 24),
                    _CompletedSection(
                      completedPlans: completedPlans,
                      goal: goal,
                      l10n: l10n,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, AppLocalizations l10n, bool isRtl,
      StoredGoal goal, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: Icon(isRtl ? Icons.arrow_forward : Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(goal.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          Text(goal.titleShort.isNotEmpty ? goal.titleShort : goal.title),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showOptions(context, l10n, ref),
        ),
      ],
    );
  }

  void _showOptions(BuildContext context, AppLocalizations l10n, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(l10n.editGoal),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: Text(l10n.regeneratePlan),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: Text(
                l10n.deleteGoal,
                style: const TextStyle(color: AppColors.error),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDelete(context, l10n, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteGoal),
        content: const Text('Are you sure you want to delete this goal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(goalsProvider.notifier).deleteGoal(goalId);
              Navigator.pop(ctx);
              context.pop();
            },
            child: Text(
              l10n.deleteGoal,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final StoredGoal goal;
  final AppLocalizations l10n;

  const _ProgressHeader({required this.goal, required this.l10n});

  Color get _accentColor =>
      goal.isRamadanMode ? AppColors.ramadan : AppColors.primary;

  int get _progressPercent => (goal.completionPercentage * 100).toInt();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProgressRing(context),
        const SizedBox(height: 16),
        Text(
          l10n.daysOfDays(goal.tasksCompleted, goal.tasksTotal),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildProgressRing(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(
            value: goal.completionPercentage,
            strokeWidth: 10,
            backgroundColor: _accentColor.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
          ),
        ),
        Column(
          children: [
            Text(
              '$_progressPercent%',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _accentColor,
                  ),
            ),
            Text(l10n.complete, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final StoredGoal goal;
  final AppLocalizations l10n;

  const _StatsRow({required this.goal, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(
          icon: '🔥',
          value: '${goal.currentStreak}',
          label: l10n.currentStreak,
          color: AppColors.warning,
        ),
        Container(
          width: 1,
          height: 40,
          color: Theme.of(context).dividerColor,
        ),
        _StatItem(
          icon: '🏆',
          value: '${goal.bestStreak}',
          label: l10n.bestStreak,
          color: AppColors.success,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _RamadanPhase extends StatelessWidget {
  final AppLocalizations l10n;

  const _RamadanPhase({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.ramadan.withValues(alpha: 0.1),
            AppColors.ramadan.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ramadan.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Text('🌙', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.phaseOfForgiveness,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.ramadan,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.daysRange(11, 20),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.ramadanGold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text(
                  l10n.qadrNightsSoon,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ramadan,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodaySection extends ConsumerWidget {
  final List<StoredDayPlan> todayPlans;
  final StoredGoal goal;
  final AppLocalizations l10n;

  const _TodaySection({
    required this.todayPlans,
    required this.goal,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayPlan = todayPlans.isNotEmpty ? todayPlans.first : null;
    if (todayPlan == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, l10n.todayDay(todayPlan.day)),
        const SizedBox(height: 12),
        DayPlanTile(
          dayPlan: todayPlan,
          isRamadanMode: goal.isRamadanMode,
          onCheckChanged: (value) {
            if (value) {
              ref.read(dayPlansProvider(goal.id).notifier).completeDayPlan(todayPlan.id);
              ref.read(goalsProvider.notifier).refresh();
            }
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _UpcomingSection extends StatelessWidget {
  final List<StoredDayPlan> upcomingPlans;
  final StoredGoal goal;
  final AppLocalizations l10n;

  const _UpcomingSection({
    required this.upcomingPlans,
    required this.goal,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    if (upcomingPlans.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, l10n.upcoming),
        const SizedBox(height: 12),
        ...upcomingPlans.map((plan) => DayPlanTile(
              dayPlan: plan,
              isRamadanMode: goal.isRamadanMode,
            )),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _CompletedSection extends StatelessWidget {
  final List<StoredDayPlan> completedPlans;
  final StoredGoal goal;
  final AppLocalizations l10n;

  const _CompletedSection({
    required this.completedPlans,
    required this.goal,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.completed,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${completedPlans.length}/${goal.tasksTotal}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...completedPlans.map((plan) => DayPlanTile(
              dayPlan: plan,
              isRamadanMode: goal.isRamadanMode,
            )),
      ],
    );
  }
}
