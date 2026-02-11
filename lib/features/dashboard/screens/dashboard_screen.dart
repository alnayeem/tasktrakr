import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../data/models/stored_goal.dart';
import '../../../data/models/stored_day_plan.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/colors.dart';
import '../../../providers/providers.dart';
import '../widgets/task_card.dart';
import '../widgets/goal_card.dart';

/// Main dashboard screen - Home screen of the app
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRtl = ref.watch(isRtlProvider);
    final l10n = AppLocalizations.of(context)!;
    final goalsState = ref.watch(goalsProvider);
    final todayTasks = ref.watch(todayTasksProvider);

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: _buildAppBar(context, l10n),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(goalsProvider.notifier).refresh();
          },
          child: goalsState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _TasksSection(
                        todayTasks: todayTasks,
                        goals: goalsState.goals,
                      ),
                      const SizedBox(height: 32),
                      _GoalsSection(goals: goalsState.goals),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
        ),
        floatingActionButton: _buildFAB(context, l10n),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('✨', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          Text(
            l10n.appName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.pushSettings(),
        ),
      ],
    );
  }

  Widget _buildFAB(BuildContext context, AppLocalizations l10n) {
    return FloatingActionButton.extended(
      onPressed: () => context.pushGoalCreation(),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: Text(l10n.newGoal),
    );
  }
}

/// Tasks section widget
class _TasksSection extends ConsumerWidget {
  final List<StoredDayPlan> todayTasks;
  final List<StoredGoal> goals;

  const _TasksSection({
    required this.todayTasks,
    required this.goals,
  });

  int get _completedTaskCount => todayTasks.where((t) => t.isCompleted).length;

  StoredGoal? _getGoalForTask(StoredDayPlan task) {
    try {
      return goals.firstWhere((g) => g.id == task.goalId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    if (todayTasks.isEmpty) {
      return _buildEmptyState(context, l10n);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          title: l10n.todaysTasks,
          trailing: '$_completedTaskCount/${todayTasks.length}',
        ),
        const SizedBox(height: 12),
        ...todayTasks.asMap().entries.map((entry) {
          final index = entry.key;
          final task = entry.value;
          final goal = _getGoalForTask(task);

          return Padding(
            padding: EdgeInsets.only(
              bottom: index < todayTasks.length - 1 ? 12 : 0,
            ),
            child: TaskCard(
              dayPlan: task,
              goal: goal,
              onCheckChanged: (value) {
                final repository = ref.read(goalRepositoryProvider);
                if (value) {
                  repository.completeDayPlan(task.id);
                }
                ref.read(goalsProvider.notifier).refresh();
              },
              onTap: () => context.pushGoalDetail(task.goalId),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          const Text('📋', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            l10n.noTasksToday,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.addGoalToGetStarted,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    String? trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        if (trailing != null) _buildTrailingBadge(trailing),
      ],
    );
  }

  Widget _buildTrailingBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.success,
        ),
      ),
    );
  }
}

/// Goals section widget
class _GoalsSection extends StatelessWidget {
  final List<StoredGoal> goals;

  const _GoalsSection({required this.goals});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, title: l10n.myGoals),
        const SizedBox(height: 12),
        _buildGoalsGrid(context, l10n),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildGoalsGrid(BuildContext context, AppLocalizations l10n) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: goals.length + 1, // +1 for Add button
      itemBuilder: (context, index) {
        if (index == goals.length) {
          return AddGoalCard(
            onTap: () => context.pushGoalCreation(),
            label: l10n.addGoal,
          );
        }
        return GoalCard(
          goal: goals[index],
          onTap: () => context.pushGoalDetail(goals[index].id),
        );
      },
    );
  }
}
