import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/ai_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../services/ai/models/goal_context.dart';
import '../../../services/device_service.dart';

/// AI Loading screen - Shown while generating the plan
/// Displays animated loading indicator with encouraging messages
class AILoadingScreen extends ConsumerStatefulWidget {
  final String goalText;
  final int durationDays;
  final String? category;

  const AILoadingScreen({
    super.key,
    required this.goalText,
    required this.durationDays,
    this.category,
  });

  @override
  ConsumerState<AILoadingScreen> createState() => _AILoadingScreenState();
}

class _AILoadingScreenState extends ConsumerState<AILoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  bool _hasStartedGeneration = false;

  // Rotating progress messages
  Timer? _messageTimer;
  Timer? _timeoutTimer;
  int _currentMessageIndex = 0;

  // Claude-like progress messages
  static const List<String> _progressMessages = [
    'Analyzing your goal...',
    'Understanding your intentions...',
    'Creating a personalized plan...',
    'Breaking down into daily tasks...',
    'Optimizing your schedule...',
    'Adding motivational elements...',
    'Fine-tuning the details...',
    'Almost there...',
  ];

  static const Duration _messageInterval = Duration(seconds: 3);
  static const Duration _timeout = Duration(seconds: 60);

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startMessageRotation();
    _startTimeoutTimer();
    // Start generation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGeneration();
    });
  }

  void _startMessageRotation() {
    _messageTimer = Timer.periodic(_messageInterval, (timer) {
      if (mounted) {
        setState(() {
          _currentMessageIndex = (_currentMessageIndex + 1) % _progressMessages.length;
        });
      }
    });
  }

  void _startTimeoutTimer() {
    _timeoutTimer = Timer(_timeout, () {
      if (mounted && ref.read(goalGenerationProvider).isLoading) {
        // Timeout reached while still loading
        ref.read(goalGenerationProvider.notifier).reset();
        final l10n = AppLocalizations.of(context);
        _showErrorDialog(
          l10n!,
          'Request timed out. The AI is taking too long to respond. Please try again.',
        );
      }
    });
  }

  void _initAnimations() {
    // Pulse animation for the center icon
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // Rotation for outer ring
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );
    _rotateController.repeat();
  }

  Future<void> _startGeneration() async {
    if (_hasStartedGeneration) return;
    _hasStartedGeneration = true;

    final languageCode = ref.read(languageCodeProvider);
    final startDate = DateTime.now();

    // Build GoalContext
    final goalContext = GoalContext(
      rawInput: widget.goalText,
      language: languageCode,
      category: widget.category ?? 'general',
      durationDays: widget.durationDays,
      startDate: _formatDate(startDate),
      specialMode: widget.category == 'ramadan' ? 'ramadan' : null,
      ramadan: widget.category == 'ramadan'
          ? RamadanContext.ramadan2026()
          : null,
    );

    // Get device ID for rate limiting
    final deviceId = DeviceService.getDeviceId();

    // Start generation
    await ref.read(goalGenerationProvider.notifier).generateGoal(
          context: goalContext,
          deviceId: deviceId,
        );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    _timeoutTimer?.cancel();
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = ref.watch(isRtlProvider);
    final l10n = AppLocalizations.of(context)!;
    final generationState = ref.watch(goalGenerationProvider);

    final isRamadan = widget.category == 'ramadan';
    final accentColor = isRamadan ? AppColors.ramadan : AppColors.primary;

    // Listen for completion or error
    ref.listen<GoalGenerationState>(goalGenerationProvider, (previous, next) {
      if (next.isComplete && next.generatedGoal != null) {
        // Cancel timers on success
        _messageTimer?.cancel();
        _timeoutTimer?.cancel();
        // Reset the provider state first
        ref.read(goalGenerationProvider.notifier).reset();
        // Navigate to dashboard, then push goal detail so back button works
        context.goToDashboard();
        // Use a small delay to ensure dashboard is loaded before pushing
        Future.microtask(() {
          if (context.mounted) {
            context.pushGoalDetail(next.generatedGoal!.id);
          }
        });
      } else if (next.hasError && !next.isLoading) {
        // Cancel timers on error
        _messageTimer?.cancel();
        _timeoutTimer?.cancel();
        // Show error and go back
        _showErrorDialog(l10n, next.error!);
      }
    });

    // Use rotating message if provider message is empty or generic
    final displayMessage = generationState.statusMessage.isNotEmpty &&
            generationState.statusMessage != 'Connecting to AI...' &&
            generationState.statusMessage != 'Generating your personalized plan...'
        ? generationState.statusMessage
        : _progressMessages[_currentMessageIndex];

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Animated loading indicator
                _buildLoadingIndicator(accentColor),

                const SizedBox(height: 48),

                // Main message with smooth transitions
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: Text(
                    displayMessage,
                    key: ValueKey(displayMessage),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // Progress bar
                _buildProgressBar(context, l10n, accentColor, generationState.progress),

                const SizedBox(height: 24),

                // Goal summary
                _buildGoalSummary(context, l10n),

                const Spacer(flex: 3),

                // Cancel button
                TextButton(
                  onPressed: _onCancel,
                  child: Text(
                    l10n.cancel,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCancel() {
    _messageTimer?.cancel();
    _timeoutTimer?.cancel();
    ref.read(goalGenerationProvider.notifier).reset();
    context.pop();
  }

  void _showErrorDialog(AppLocalizations l10n, String error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.error),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(goalGenerationProvider.notifier).reset();
              context.pop();
            },
            child: Text(l10n.ok),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _hasStartedGeneration = false;
              _startGeneration();
            },
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator(Color accentColor) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating ring
          AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.2),
                      width: 3,
                    ),
                    gradient: SweepGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.0),
                        accentColor.withValues(alpha: 0.5),
                        accentColor,
                        accentColor.withValues(alpha: 0.5),
                        accentColor.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Inner pulsing circle
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.category == 'ramadan' ? '🌙' : '✨',
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, AppLocalizations l10n, Color accentColor, double progress) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress > 0 ? progress : null, // Indeterminate if 0
            backgroundColor: accentColor.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.creatingDailyTasks(widget.durationDays),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildGoalSummary(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.yourGoal,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.goalText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
