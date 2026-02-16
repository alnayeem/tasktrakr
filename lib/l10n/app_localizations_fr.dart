// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Continuer';

  @override
  String get getStarted => 'Commencer';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get welcomeDescription =>
      'Transformez vos objectifs en tâches quotidiennes réalisables avec l\'IA';

  @override
  String get featureSetGoals =>
      'Définissez vos objectifs avec vos propres mots';

  @override
  String get featureAIPlan => 'L\'IA crée votre plan quotidien';

  @override
  String get featureTrackProgress => 'Suivez vos progrès chaque jour';

  @override
  String get featureRamadanMode => 'Mode Ramadan spécial';

  @override
  String get todaysTasks => 'Tâches du Jour';

  @override
  String get myGoals => 'Mes Objectifs';

  @override
  String get newGoal => 'Nouvel Objectif';

  @override
  String get addGoal => 'Ajouter un Objectif';

  @override
  String get whatToAchieve => 'Que voulez-vous accomplir?';

  @override
  String get goalHint =>
      'Exemple: Je veux terminer la lecture du Coran ce Ramadan...';

  @override
  String get duration => 'Durée';

  @override
  String get categoryOptional => 'Catégorie (optionnel)';

  @override
  String get generatePlan => 'Générer le Plan';

  @override
  String get aiWillCreate =>
      'L\'IA créera un plan quotidien personnalisé pour vous';

  @override
  String get analyzingGoal => 'Analyse de votre objectif...';

  @override
  String get creatingPlan => 'Création de votre plan personnalisé...';

  @override
  String distributingTasks(int days) {
    return 'Distribution des tâches sur $days jours...';
  }

  @override
  String get addingRestDays => 'Ajout des jours de repos...';

  @override
  String get finalTouches => 'Touches finales...';

  @override
  String creatingDailyTasks(int days) {
    return 'Création de $days tâches quotidiennes';
  }

  @override
  String get yourGoal => 'Votre objectif:';

  @override
  String get cancel => 'Annuler';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed sur $total jours';
  }

  @override
  String get complete => 'Terminé';

  @override
  String get currentStreak => 'Série Actuelle';

  @override
  String get bestStreak => 'Meilleure Série';

  @override
  String get phaseOfMercy => 'Phase de Miséricorde';

  @override
  String get phaseOfForgiveness => 'Phase de Pardon';

  @override
  String get phaseOfSalvation => 'Phase de Salut';

  @override
  String daysRange(int start, int end) {
    return 'Jours $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Nuits de Qadr bientôt';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String todayDay(int day) {
    return 'Aujourd\'hui - Jour $day';
  }

  @override
  String get upcoming => 'À venir';

  @override
  String get completed => 'Terminé';

  @override
  String get editGoal => 'Modifier l\'Objectif';

  @override
  String get regeneratePlan => 'Régénérer le Plan';

  @override
  String get deleteGoal => 'Supprimer l\'Objectif';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get selectTheme => 'Sélectionner le Thème';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get about => 'À propos';

  @override
  String get aboutTaskTrakr => 'À propos de TaskTrakr';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get helpSupport => 'Aide et Support';

  @override
  String get dataStaysPrivate => 'Vos données restent privées';

  @override
  String get dataPrivacyDescription =>
      'Toutes vos données sont stockées localement sur votre appareil. Nous ne collectons aucune information personnelle.';

  @override
  String get aboutDescription =>
      'Constructeur d\'objectifs et d\'habitudes alimenté par l\'IA.';

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
  String get days7 => '7 jours';

  @override
  String get days14 => '14 jours';

  @override
  String get days21 => '21 jours';

  @override
  String get days30 => '30 jours';

  @override
  String get days60 => '60 jours';

  @override
  String get days90 => '90 jours';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryLearning => 'Apprentissage';

  @override
  String get categoryCreative => 'Créatif';

  @override
  String get categoryWellness => 'Bien-être';

  @override
  String get categoryFinancial => 'Finance';

  @override
  String get categoryRamadan => 'Ramadan';

  @override
  String get categoryOther => 'Autre';

  @override
  String get chooseLanguage => 'Choisissez votre langue';

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
