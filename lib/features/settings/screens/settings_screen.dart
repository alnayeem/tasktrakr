import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/language.dart';
import '../../../core/theme/colors.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../../services/notification_service.dart';

/// Settings screen
/// Language, theme, about, and privacy settings
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRtl = ref.watch(isRtlProvider);
    final languageCode = ref.watch(languageCodeProvider);
    final currentTheme = ref.watch(themeSettingProvider);
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);
    final preferencesState = ref.watch(preferencesProvider);
    final reminderTime = preferencesState.reminderTime ?? '09:00';
    final l10n = AppLocalizations.of(context)!;

    // Find current language
    final currentLanguage = Language.findByCode(languageCode) ?? Language.defaultLanguage;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              isRtl ? Icons.arrow_forward : Icons.arrow_back,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(l10n.settings),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Language Section
            _buildSectionHeader(context, l10n.language),
            const SizedBox(height: 12),
            _buildLanguageTile(context, ref, l10n, currentLanguage),

            const SizedBox(height: 32),

            // Appearance Section
            _buildSectionHeader(context, l10n.appearance),
            const SizedBox(height: 12),
            _buildThemeTile(context, ref, l10n, currentTheme),

            const SizedBox(height: 32),

            // Notifications Section
            _buildSectionHeader(context, l10n.notifications),
            const SizedBox(height: 12),
            _buildNotificationToggle(context, ref, l10n, notificationsEnabled),
            if (notificationsEnabled) ...[
              const SizedBox(height: 8),
              _buildReminderTimeTile(context, ref, l10n, reminderTime),
            ],

            const SizedBox(height: 32),

            // About Section
            _buildSectionHeader(context, l10n.about),
            const SizedBox(height: 12),
            _buildAboutSection(context, l10n),

            const SizedBox(height: 32),

            // Privacy notice
            _buildPrivacyNotice(context, l10n),

            const SizedBox(height: 24),

            // Version
            Center(
              child: Text(
                l10n.version('1.0.0'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: 0.5),
                    ),
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildLanguageTile(BuildContext context, WidgetRef ref, AppLocalizations l10n, Language currentLanguage) {
    return _SettingsTile(
      icon: Icons.language,
      iconColor: AppColors.primary,
      title: l10n.language,
      trailing: Text(
        currentLanguage.nativeName,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
      onTap: () => _showLanguageSheet(context, ref, l10n),
    );
  }

  Widget _buildThemeTile(BuildContext context, WidgetRef ref, AppLocalizations l10n, String currentTheme) {
    String themeLabel;
    switch (currentTheme) {
      case 'light':
        themeLabel = l10n.light;
        break;
      case 'dark':
        themeLabel = l10n.dark;
        break;
      default:
        themeLabel = l10n.systemDefault;
    }

    return _SettingsTile(
      icon: Icons.palette_outlined,
      iconColor: AppColors.categoryCreative,
      title: l10n.theme,
      trailing: Text(
        themeLabel,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
      onTap: () => _showThemeSheet(context, ref, l10n, currentTheme),
    );
  }

  Widget _buildNotificationToggle(BuildContext context, WidgetRef ref, AppLocalizations l10n, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.notifications_outlined, color: AppColors.warning, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dailyReminder,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  l10n.dailyReminderDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) => _toggleNotifications(context, ref, l10n, value),
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildReminderTimeTile(BuildContext context, WidgetRef ref, AppLocalizations l10n, String timeString) {
    final (hour, minute) = NotificationService.parseTimeString(timeString);
    final timeOfDay = TimeOfDay(hour: hour, minute: minute);
    final formattedTime = timeOfDay.format(context);

    return _SettingsTile(
      icon: Icons.access_time,
      iconColor: AppColors.categoryLearning,
      title: l10n.reminderTime,
      trailing: Text(
        formattedTime,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
      onTap: () => _showTimePicker(context, ref, l10n, timeOfDay),
    );
  }

  Future<void> _toggleNotifications(BuildContext context, WidgetRef ref, AppLocalizations l10n, bool enable) async {
    if (enable) {
      // Request permissions first
      final granted = await NotificationService().requestPermissions();
      if (!granted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.enableNotificationsInSettings),
              action: SnackBarAction(
                label: l10n.ok,
                onPressed: () {},
              ),
            ),
          );
        }
        return;
      }

      // Enable notifications and schedule reminder
      await ref.read(preferencesProvider.notifier).setNotificationsEnabled(true);
      final reminderTime = ref.read(preferencesProvider).reminderTime ?? '09:00';
      final (hour, minute) = NotificationService.parseTimeString(reminderTime);
      await NotificationService().scheduleDailyReminder(
        hour: hour,
        minute: minute,
        title: l10n.reminderNotificationTitle,
        body: l10n.reminderNotificationBody,
      );
    } else {
      // Disable notifications and cancel reminder
      await ref.read(preferencesProvider.notifier).setNotificationsEnabled(false);
      await NotificationService().cancelDailyReminder();
    }
  }

  Future<void> _showTimePicker(BuildContext context, WidgetRef ref, AppLocalizations l10n, TimeOfDay currentTime) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      helpText: l10n.selectTime,
    );

    if (selectedTime != null && context.mounted) {
      final timeString = NotificationService.formatTimeString(selectedTime.hour, selectedTime.minute);
      await ref.read(preferencesProvider.notifier).setReminderTime(timeString);

      // Reschedule notification with new time
      final notificationsEnabled = ref.read(notificationsEnabledProvider);
      if (notificationsEnabled) {
        await NotificationService().scheduleDailyReminder(
          hour: selectedTime.hour,
          minute: selectedTime.minute,
          title: l10n.reminderNotificationTitle,
          body: l10n.reminderNotificationBody,
        );
      }
    }
  }

  Widget _buildAboutSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        _SettingsTile(
          icon: Icons.info_outline,
          iconColor: AppColors.categoryLearning,
          title: l10n.aboutTaskTrakr,
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showAboutDialog(context, l10n),
        ),
        const SizedBox(height: 8),
        _SettingsTile(
          icon: Icons.privacy_tip_outlined,
          iconColor: AppColors.ramadan,
          title: l10n.privacyPolicy,
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showPrivacyPolicy(context),
        ),
        const SizedBox(height: 8),
        _SettingsTile(
          icon: Icons.help_outline,
          iconColor: AppColors.success,
          title: l10n.helpSupport,
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showSupport(context),
        ),
      ],
    );
  }

  Widget _buildPrivacyNotice(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline,
            color: AppColors.success,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dataStaysPrivate,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.dataPrivacyDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSheet(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final currentLanguageCode = ref.read(languageCodeProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (sheetContext, scrollController) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.selectLanguage,
                  style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: Language.supported.length,
                    itemBuilder: (itemContext, index) {
                      final language = Language.supported[index];
                      final isSelected = language.code == currentLanguageCode;
                      return ListTile(
                        leading: Text(language.flag, style: const TextStyle(fontSize: 24)),
                        title: Text(language.nativeName),
                        subtitle: Text(language.englishName),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: AppColors.primary)
                            : null,
                        onTap: () {
                          Navigator.pop(sheetContext);
                          ref.read(languageProvider.notifier).setLanguage(language.code);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showThemeSheet(BuildContext context, WidgetRef ref, AppLocalizations l10n, String currentTheme) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectTheme,
                style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.phone_android),
                title: Text(l10n.systemDefault),
                trailing: currentTheme == 'system'
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  Navigator.pop(sheetContext);
                  ref.read(preferencesProvider.notifier).setTheme('system');
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: Text(l10n.light),
                trailing: currentTheme == 'light'
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  Navigator.pop(sheetContext);
                  ref.read(preferencesProvider.notifier).setTheme('light');
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text(l10n.dark),
                trailing: currentTheme == 'dark'
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  Navigator.pop(sheetContext);
                  ref.read(preferencesProvider.notifier).setTheme('dark');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Text('✨', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(l10n.appName),
          ],
        ),
        content: Text(
          '${l10n.aboutDescription}\n\n${l10n.version('1.0.0')}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    debugPrint('Show privacy policy');
    // TODO: Open privacy policy URL or screen
  }

  void _showSupport(BuildContext context) {
    debugPrint('Show support');
    // TODO: Open support email or help center
  }
}

/// Reusable settings tile widget
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
