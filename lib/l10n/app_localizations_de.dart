// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Weiter';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get welcome => 'Willkommen';

  @override
  String get welcomeDescription =>
      'Verwandle deine Ziele mit KI in erreichbare tägliche Aufgaben';

  @override
  String get featureSetGoals => 'Setze Ziele in deinen eigenen Worten';

  @override
  String get featureAIPlan => 'KI erstellt deinen Tagesplan';

  @override
  String get featureTrackProgress => 'Verfolge täglich deinen Fortschritt';

  @override
  String get featureRamadanMode => 'Spezieller Ramadan-Modus';

  @override
  String get todaysTasks => 'Heutige Aufgaben';

  @override
  String get myGoals => 'Meine Ziele';

  @override
  String get newGoal => 'Neues Ziel';

  @override
  String get addGoal => 'Ziel hinzufügen';

  @override
  String get whatToAchieve => 'Was möchtest du erreichen?';

  @override
  String get goalHint =>
      'Beispiel: Ich möchte diesen Ramadan den Koran durchlesen...';

  @override
  String get duration => 'Dauer';

  @override
  String get categoryOptional => 'Kategorie (optional)';

  @override
  String get generatePlan => 'Plan erstellen';

  @override
  String get aiWillCreate =>
      'KI erstellt einen personalisierten Tagesplan für dich';

  @override
  String get analyzingGoal => 'Analysiere dein Ziel...';

  @override
  String get creatingPlan => 'Erstelle deinen personalisierten Plan...';

  @override
  String distributingTasks(int days) {
    return 'Verteile Aufgaben über $days Tage...';
  }

  @override
  String get addingRestDays => 'Füge Ruhetage hinzu...';

  @override
  String get finalTouches => 'Letzte Feinheiten...';

  @override
  String creatingDailyTasks(int days) {
    return 'Erstelle $days tägliche Aufgaben';
  }

  @override
  String get yourGoal => 'Dein Ziel:';

  @override
  String get cancel => 'Abbrechen';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed von $total Tagen';
  }

  @override
  String get complete => 'Abgeschlossen';

  @override
  String get currentStreak => 'Aktuelle Serie';

  @override
  String get bestStreak => 'Beste Serie';

  @override
  String get phaseOfMercy => 'Phase der Barmherzigkeit';

  @override
  String get phaseOfForgiveness => 'Phase der Vergebung';

  @override
  String get phaseOfSalvation => 'Phase der Erlösung';

  @override
  String daysRange(int start, int end) {
    return 'Tage $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Qadr-Nächte bald';

  @override
  String get today => 'Heute';

  @override
  String todayDay(int day) {
    return 'Heute - Tag $day';
  }

  @override
  String get upcoming => 'Kommend';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get editGoal => 'Ziel bearbeiten';

  @override
  String get regeneratePlan => 'Plan neu erstellen';

  @override
  String get deleteGoal => 'Ziel löschen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache wählen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get theme => 'Thema';

  @override
  String get selectTheme => 'Thema wählen';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get about => 'Über';

  @override
  String get aboutTaskTrakr => 'Über TaskTrakr';

  @override
  String get privacyPolicy => 'Datenschutz';

  @override
  String get helpSupport => 'Hilfe & Support';

  @override
  String get dataStaysPrivate => 'Deine Daten bleiben privat';

  @override
  String get dataPrivacyDescription =>
      'Alle deine Daten werden lokal auf deinem Gerät gespeichert. Wir sammeln keine persönlichen Informationen.';

  @override
  String get aboutDescription => 'KI-gestützter Ziel- und Gewohnheitsbuilder.';

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
  String get days7 => '7 Tage';

  @override
  String get days14 => '14 Tage';

  @override
  String get days21 => '21 Tage';

  @override
  String get days30 => '30 Tage';

  @override
  String get days60 => '60 Tage';

  @override
  String get days90 => '90 Tage';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryLearning => 'Lernen';

  @override
  String get categoryCreative => 'Kreativ';

  @override
  String get categoryWellness => 'Wohlbefinden';

  @override
  String get categoryFinancial => 'Finanzen';

  @override
  String get categoryRamadan => 'Ramadan';

  @override
  String get categoryOther => 'Sonstiges';

  @override
  String get chooseLanguage => 'Wähle deine Sprache';

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
