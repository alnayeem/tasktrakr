// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Continue';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcomeDescription =>
      'Turn your goals into achievable daily tasks with AI';

  @override
  String get featureSetGoals => 'Set goals in your own words';

  @override
  String get featureAIPlan => 'AI creates your daily plan';

  @override
  String get featureTrackProgress => 'Track progress every day';

  @override
  String get featureRamadanMode => 'Special Ramadan mode';

  @override
  String get todaysTasks => 'Today\'s Tasks';

  @override
  String get myGoals => 'My Goals';

  @override
  String get newGoal => 'New Goal';

  @override
  String get addGoal => 'Add Goal';

  @override
  String get whatToAchieve => 'What do you want to achieve?';

  @override
  String get goalHint =>
      'Example: I want to complete reading the Quran this Ramadan...';

  @override
  String get duration => 'Duration';

  @override
  String get categoryOptional => 'Category (optional)';

  @override
  String get generatePlan => 'Generate Plan';

  @override
  String get aiWillCreate => 'AI will create a personalized daily plan for you';

  @override
  String get analyzingGoal => 'Analyzing your goal...';

  @override
  String get creatingPlan => 'Creating your personalized plan...';

  @override
  String distributingTasks(int days) {
    return 'Distributing tasks across $days days...';
  }

  @override
  String get addingRestDays => 'Adding rest days...';

  @override
  String get finalTouches => 'Final touches...';

  @override
  String creatingDailyTasks(int days) {
    return 'Creating $days daily tasks';
  }

  @override
  String get yourGoal => 'Your goal:';

  @override
  String get cancel => 'Cancel';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed of $total days';
  }

  @override
  String get complete => 'Complete';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get bestStreak => 'Best Streak';

  @override
  String get phaseOfMercy => 'Phase of Mercy';

  @override
  String get phaseOfForgiveness => 'Phase of Forgiveness';

  @override
  String get phaseOfSalvation => 'Phase of Salvation';

  @override
  String daysRange(int start, int end) {
    return 'Days $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Qadr nights soon';

  @override
  String get today => 'Today';

  @override
  String todayDay(int day) {
    return 'Today - Day $day';
  }

  @override
  String get upcoming => 'Upcoming';

  @override
  String get completed => 'Completed';

  @override
  String get editGoal => 'Edit Goal';

  @override
  String get regeneratePlan => 'Regenerate Plan';

  @override
  String get deleteGoal => 'Delete Goal';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get systemDefault => 'System Default';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get about => 'About';

  @override
  String get aboutTaskTrakr => 'About TaskTrakr';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get dataStaysPrivate => 'Your data stays private';

  @override
  String get dataPrivacyDescription =>
      'All your data is stored locally on your device. We don\'t collect any personal information.';

  @override
  String get aboutDescription => 'AI-powered goal and habit builder.';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 days';

  @override
  String get days14 => '14 days';

  @override
  String get days21 => '21 days';

  @override
  String get days30 => '30 days';

  @override
  String get days60 => '60 days';

  @override
  String get days90 => '90 days';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryLearning => 'Learning';

  @override
  String get categoryCreative => 'Creative';

  @override
  String get categoryWellness => 'Wellness';

  @override
  String get categoryFinancial => 'Financial';

  @override
  String get categoryRamadan => 'Ramadan';

  @override
  String get categoryOther => 'Other';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get noTasksToday => 'No tasks for today';

  @override
  String get addGoalToGetStarted => 'Add a goal to get started';

  @override
  String get notifications => 'Notifications';

  @override
  String get dailyReminder => 'Daily Reminder';

  @override
  String get dailyReminderDescription => 'Get reminded to check your tasks';

  @override
  String get reminderTime => 'Reminder Time';

  @override
  String get selectTime => 'Select Time';

  @override
  String get notificationPermissionRequired =>
      'Notification permission is required';

  @override
  String get enableNotificationsInSettings =>
      'Please enable notifications in your device settings';

  @override
  String get reminderNotificationTitle => 'Time to check your goals!';

  @override
  String get reminderNotificationBody =>
      'Don\'t forget to complete today\'s tasks';
}
