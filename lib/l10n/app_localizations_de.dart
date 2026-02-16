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

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signInWithGoogle => 'Continue with Google';

  @override
  String get signInWithApple => 'Continue with Apple';

  @override
  String get signInWithEmail => 'Sign in with Email';

  @override
  String get createAccount => 'Create Account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get verifyEmail => 'Verify Your Email';

  @override
  String get verificationEmailSent => 'We sent a verification email to:';

  @override
  String get clickLinkToVerify =>
      'Click the link in the email to verify your account.';

  @override
  String get iveVerifiedEmail => 'I\'ve Verified My Email';

  @override
  String get resendVerificationEmail => 'Resend Verification Email';

  @override
  String get verificationEmailResent => 'Verification email sent!';

  @override
  String get emailNotVerifiedYet =>
      'Email not verified yet. Please check your inbox.';

  @override
  String get wrongEmail => 'Wrong email?';

  @override
  String get didntReceiveEmail => 'Didn\'t receive the email?';

  @override
  String get checkSpamFolder => 'Check your spam or junk folder';

  @override
  String get correctEmailHint => 'Make sure you entered the correct email';

  @override
  String get waitAndTryAgain => 'Wait a few minutes and try again';

  @override
  String get checkYourEmail => 'Check Your Email';

  @override
  String resetLinkSent(String email) {
    return 'If an account exists for $email, you\'ll receive a password reset link.';
  }

  @override
  String get tryDifferentEmail => 'Try a different email';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get agreeToTerms =>
      'I agree to the Terms of Service and Privacy Policy';

  @override
  String get mustAgreeToTerms => 'You must agree to continue';

  @override
  String get account => 'Account';

  @override
  String get signedInAs => 'Signed in as';

  @override
  String signedInWith(String provider) {
    return 'Signed in with $provider';
  }

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountWarning =>
      'This will permanently delete your account and all associated data. This action cannot be undone.';

  @override
  String get confirmDelete => 'Yes, Delete My Account';

  @override
  String get authErrorDefault => 'An error occurred. Please try again.';

  @override
  String get authErrorInvalidEmail => 'Invalid email address';

  @override
  String get authErrorWrongPassword => 'Incorrect password';

  @override
  String get authErrorUserNotFound => 'No account found with this email';

  @override
  String get authErrorEmailInUse => 'An account already exists with this email';

  @override
  String get authErrorWeakPassword => 'Password is too weak';

  @override
  String get authErrorNetworkFailed =>
      'Network error. Please check your connection.';
}
