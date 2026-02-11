import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/colors.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/preferences_provider.dart';

/// Welcome screen shown after language selection
/// Introduces the app concept before goal creation
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = ref.watch(isRtlProvider);
    final l10n = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeIn,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      children: [
                        const Spacer(flex: 1),

                        // Illustration
                        _buildIllustration(l10n),

                        const SizedBox(height: 48),

                        // Welcome Text
                        _buildWelcomeText(context, l10n),

                        const SizedBox(height: 16),

                        // Description
                        _buildDescription(context, l10n),

                        const Spacer(flex: 2),

                        // Features list
                        _buildFeaturesList(context, l10n),

                        const Spacer(flex: 1),

                        // Get Started Button
                        _buildGetStartedButton(context, l10n, isRtl),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(AppLocalizations l10n) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.2),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
          ),
          // Inner content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '✨',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.appName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context, AppLocalizations l10n) {
    return Text(
      l10n.welcome,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(BuildContext context, AppLocalizations l10n) {
    return Text(
      l10n.welcomeDescription,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            height: 1.5,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFeaturesList(BuildContext context, AppLocalizations l10n) {
    final features = [
      {'icon': '🎯', 'text': l10n.featureSetGoals},
      {'icon': '🤖', 'text': l10n.featureAIPlan},
      {'icon': '✅', 'text': l10n.featureTrackProgress},
      {'icon': '🌙', 'text': l10n.featureRamadanMode},
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    feature['icon']!,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  feature['text']!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGetStartedButton(BuildContext context, AppLocalizations l10n, bool isRtl) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _onGetStarted,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.getStarted,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isRtl ? Icons.arrow_back : Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _onGetStarted() {
    // Mark onboarding as completed before navigating
    ref.read(preferencesProvider.notifier).completeOnboarding();
    context.goToDashboard();
  }
}
