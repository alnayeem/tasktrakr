import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/language.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/colors.dart';
import '../../../providers/language_provider.dart';
import '../widgets/language_option_card.dart';

/// Language selection screen - First screen users see
/// Allows selection from 12 supported languages
class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  Language? _selectedLanguage;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool get _canContinue => _selectedLanguage != null;

  String get _continueButtonText =>
      _selectedLanguage?.continueText ?? 'Continue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildLogo(),
                const SizedBox(height: 24),
                _buildTitle(),
                const SizedBox(height: 24),
                _buildLanguageList(),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '✨',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Choose your language',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLanguageList() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: Language.supported.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final language = Language.supported[index];
          return LanguageOptionCard(
            language: language,
            isSelected: _selectedLanguage?.code == language.code,
            onTap: () => _onLanguageSelected(language),
          );
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _canContinue ? 1.0 : 0.5,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _canContinue ? _onContinue : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: _canContinue ? 4 : 0,
            ),
            child: Text(
              _continueButtonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLanguageSelected(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _onContinue() {
    if (_selectedLanguage == null) return;

    // Save language to provider - this updates the app's locale
    ref.read(languageProvider.notifier).setLanguageFromModel(_selectedLanguage!);

    // Navigate to welcome screen
    context.goToWelcome();
  }
}
