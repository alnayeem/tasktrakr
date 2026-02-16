// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Davom etish';

  @override
  String get getStarted => 'Boshlash';

  @override
  String get welcome => 'Xush kelibsiz';

  @override
  String get welcomeDescription =>
      'AI yordamida maqsadlaringizni kundalik erishish mumkin bo\'lgan vazifalarga aylantiring';

  @override
  String get featureSetGoals =>
      'Maqsadlaringizni o\'z so\'zlaringiz bilan belgilang';

  @override
  String get featureAIPlan => 'AI kundalik rejangizni tuzadi';

  @override
  String get featureTrackProgress => 'Har kuni rivojlanishingizni kuzating';

  @override
  String get featureRamadanMode => 'Maxsus Ramazon rejimi';

  @override
  String get todaysTasks => 'Bugungi vazifalar';

  @override
  String get myGoals => 'Maqsadlarim';

  @override
  String get newGoal => 'Yangi maqsad';

  @override
  String get addGoal => 'Maqsad qo\'shish';

  @override
  String get whatToAchieve => 'Nimaga erishmoqchisiz?';

  @override
  String get goalHint =>
      'Misol: Ushbu Ramazonda Qur\'onni xatm qilmoqchiman...';

  @override
  String get duration => 'Davomiyligi';

  @override
  String get categoryOptional => 'Kategoriya (ixtiyoriy)';

  @override
  String get generatePlan => 'Reja tuzish';

  @override
  String get aiWillCreate => 'AI siz uchun shaxsiy kundalik reja tuzadi';

  @override
  String get analyzingGoal => 'Maqsadingiz tahlil qilinmoqda...';

  @override
  String get creatingPlan => 'Shaxsiy rejangiz tuzilmoqda...';

  @override
  String distributingTasks(int days) {
    return 'Vazifalar $days kunga taqsimlanmoqda...';
  }

  @override
  String get addingRestDays => 'Dam olish kunlari qo\'shilmoqda...';

  @override
  String get finalTouches => 'Yakuniy tegishlar...';

  @override
  String creatingDailyTasks(int days) {
    return '$days kunlik vazifa tuzilmoqda';
  }

  @override
  String get yourGoal => 'Maqsadingiz:';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String daysOfDays(int completed, int total) {
    return '$total kundan $completed kun';
  }

  @override
  String get complete => 'Tugallandi';

  @override
  String get currentStreak => 'Joriy ketma-ketlik';

  @override
  String get bestStreak => 'Eng yaxshi ketma-ketlik';

  @override
  String get phaseOfMercy => 'Rahmat bosqichi';

  @override
  String get phaseOfForgiveness => 'Mag\'firat bosqichi';

  @override
  String get phaseOfSalvation => 'Najot bosqichi';

  @override
  String daysRange(int start, int end) {
    return 'Kunlar $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Qadr kechalari yaqin';

  @override
  String get today => 'Bugun';

  @override
  String todayDay(int day) {
    return 'Bugun - $day-kun';
  }

  @override
  String get upcoming => 'Kelayotgan';

  @override
  String get completed => 'Tugallangan';

  @override
  String get editGoal => 'Maqsadni tahrirlash';

  @override
  String get regeneratePlan => 'Rejani qayta tuzish';

  @override
  String get deleteGoal => 'Maqsadni o\'chirish';

  @override
  String get settings => 'Sozlamalar';

  @override
  String get language => 'Til';

  @override
  String get selectLanguage => 'Tilni tanlang';

  @override
  String get appearance => 'Ko\'rinish';

  @override
  String get theme => 'Mavzu';

  @override
  String get selectTheme => 'Mavzuni tanlang';

  @override
  String get systemDefault => 'Tizim standarti';

  @override
  String get light => 'Yorug\'';

  @override
  String get dark => 'Qorong\'u';

  @override
  String get about => 'Haqida';

  @override
  String get aboutTaskTrakr => 'TaskTrakr haqida';

  @override
  String get privacyPolicy => 'Maxfiylik siyosati';

  @override
  String get helpSupport => 'Yordam va qo\'llab-quvvatlash';

  @override
  String get dataStaysPrivate => 'Ma\'lumotlaringiz maxfiy qoladi';

  @override
  String get dataPrivacyDescription =>
      'Barcha ma\'lumotlaringiz qurilmangizda mahalliy saqlanadi. Biz hech qanday shaxsiy ma\'lumot to\'plamaymiz.';

  @override
  String get aboutDescription => 'AI yordamida maqsad va odat yaratuvchisi.';

  @override
  String version(String version) {
    return 'Versiya $version';
  }

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 kun';

  @override
  String get days14 => '14 kun';

  @override
  String get days21 => '21 kun';

  @override
  String get days30 => '30 kun';

  @override
  String get days60 => '60 kun';

  @override
  String get days90 => '90 kun';

  @override
  String get categoryFitness => 'Fitnes';

  @override
  String get categoryLearning => 'O\'rganish';

  @override
  String get categoryCreative => 'Ijodiy';

  @override
  String get categoryWellness => 'Salomatlik';

  @override
  String get categoryFinancial => 'Moliyaviy';

  @override
  String get categoryRamadan => 'Ramazon';

  @override
  String get categoryOther => 'Boshqa';

  @override
  String get chooseLanguage => 'Tilingizni tanlang';

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
