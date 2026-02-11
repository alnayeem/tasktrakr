import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/colors.dart';
import '../../../providers/language_provider.dart';
import '../widgets/duration_selector.dart';
import '../widgets/category_selector.dart';

/// Goal creation screen
/// User inputs goal text, selects duration and optional category
class GoalCreationScreen extends ConsumerStatefulWidget {
  const GoalCreationScreen({super.key});

  @override
  ConsumerState<GoalCreationScreen> createState() => _GoalCreationScreenState();
}

class _GoalCreationScreenState extends ConsumerState<GoalCreationScreen> {
  final _goalController = TextEditingController();
  final _focusNode = FocusNode();

  int? _selectedDuration;
  String? _selectedCategoryId;
  bool _isLoading = false;

  @override
  void dispose() {
    _goalController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canGenerate =>
      _goalController.text.trim().isNotEmpty && _selectedDuration != null;

  bool get _isRamadanMode => _selectedCategoryId == 'ramadan';

  Color get _accentColor =>
      _isRamadanMode ? AppColors.ramadan : AppColors.primary;

  @override
  Widget build(BuildContext context) {
    final isRtl = ref.watch(isRtlProvider);
    final l10n = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: _buildAppBar(l10n, isRtl),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGoalSection(l10n, isRtl),
                const SizedBox(height: 32),
                _buildDurationSection(l10n),
                const SizedBox(height: 32),
                _buildCategorySection(l10n),
                const SizedBox(height: 48),
                _buildGenerateButton(l10n),
                const SizedBox(height: 16),
                _buildHelperText(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(AppLocalizations l10n, bool isRtl) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          isRtl ? Icons.arrow_forward : Icons.arrow_back,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(l10n.newGoal),
    );
  }

  Widget _buildGoalSection(AppLocalizations l10n, bool isRtl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(l10n.whatToAchieve),
        const SizedBox(height: 12),
        _buildGoalInput(l10n, isRtl),
      ],
    );
  }

  Widget _buildDurationSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(l10n.duration),
        const SizedBox(height: 12),
        DurationSelector(
          selectedDays: _selectedDuration,
          onSelected: (days) => setState(() => _selectedDuration = days),
        ),
      ],
    );
  }

  Widget _buildCategorySection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(l10n.categoryOptional),
        const SizedBox(height: 12),
        CategorySelector(
          selectedCategoryId: _selectedCategoryId,
          onSelected: _onCategorySelected,
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildGoalInput(AppLocalizations l10n, bool isRtl) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _goalController,
        focusNode: _focusNode,
        maxLines: 4,
        maxLength: 500,
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: l10n.goalHint,
          hintStyle: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withValues(alpha: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(20),
          counterStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildGenerateButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _canGenerate && !_isLoading ? _onGenerate : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accentColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: _canGenerate ? 4 : 0,
        ),
        child: _isLoading ? _buildLoadingIndicator() : _buildButtonContent(l10n),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.5,
      ),
    );
  }

  Widget _buildButtonContent(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('✨', style: TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          l10n.generatePlan,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHelperText(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          l10n.aiWillCreate,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withValues(alpha: 0.7),
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      // Toggle off if same category selected
      if (_selectedCategoryId == categoryId) {
        _selectedCategoryId = null;
      } else {
        _selectedCategoryId = categoryId;
      }
    });
  }

  Future<void> _onGenerate() async {
    if (!_canGenerate) return;

    final params = AILoadingParams(
      goalText: _goalController.text.trim(),
      durationDays: _selectedDuration!,
      category: _selectedCategoryId,
    );

    context.goToAILoading(params);
  }
}
