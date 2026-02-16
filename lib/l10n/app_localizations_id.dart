// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Lanjutkan';

  @override
  String get getStarted => 'Mulai';

  @override
  String get welcome => 'Selamat Datang';

  @override
  String get welcomeDescription =>
      'Ubah tujuanmu menjadi tugas harian yang dapat dicapai dengan AI';

  @override
  String get featureSetGoals => 'Tetapkan tujuan dengan kata-katamu sendiri';

  @override
  String get featureAIPlan => 'AI membuat rencana harianmu';

  @override
  String get featureTrackProgress => 'Lacak kemajuan setiap hari';

  @override
  String get featureRamadanMode => 'Mode Ramadan khusus';

  @override
  String get todaysTasks => 'Tugas Hari Ini';

  @override
  String get myGoals => 'Tujuan Saya';

  @override
  String get newGoal => 'Tujuan Baru';

  @override
  String get addGoal => 'Tambah Tujuan';

  @override
  String get whatToAchieve => 'Apa yang ingin kamu capai?';

  @override
  String get goalHint => 'Contoh: Saya ingin khatam Al-Quran Ramadan ini...';

  @override
  String get duration => 'Durasi';

  @override
  String get categoryOptional => 'Kategori (opsional)';

  @override
  String get generatePlan => 'Buat Rencana';

  @override
  String get aiWillCreate =>
      'AI akan membuat rencana harian yang dipersonalisasi untukmu';

  @override
  String get analyzingGoal => 'Menganalisis tujuanmu...';

  @override
  String get creatingPlan => 'Membuat rencana personalisasimu...';

  @override
  String distributingTasks(int days) {
    return 'Mendistribusikan tugas selama $days hari...';
  }

  @override
  String get addingRestDays => 'Menambahkan hari istirahat...';

  @override
  String get finalTouches => 'Sentuhan akhir...';

  @override
  String creatingDailyTasks(int days) {
    return 'Membuat $days tugas harian';
  }

  @override
  String get yourGoal => 'Tujuanmu:';

  @override
  String get cancel => 'Batal';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed dari $total hari';
  }

  @override
  String get complete => 'Selesai';

  @override
  String get currentStreak => 'Streak Saat Ini';

  @override
  String get bestStreak => 'Streak Terbaik';

  @override
  String get phaseOfMercy => 'Fase Rahmat';

  @override
  String get phaseOfForgiveness => 'Fase Ampunan';

  @override
  String get phaseOfSalvation => 'Fase Pembebasan';

  @override
  String daysRange(int start, int end) {
    return 'Hari $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Malam Qadr segera';

  @override
  String get today => 'Hari Ini';

  @override
  String todayDay(int day) {
    return 'Hari Ini - Hari $day';
  }

  @override
  String get upcoming => 'Mendatang';

  @override
  String get completed => 'Selesai';

  @override
  String get editGoal => 'Edit Tujuan';

  @override
  String get regeneratePlan => 'Regenerasi Rencana';

  @override
  String get deleteGoal => 'Hapus Tujuan';

  @override
  String get settings => 'Pengaturan';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get appearance => 'Tampilan';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get systemDefault => 'Default Sistem';

  @override
  String get light => 'Terang';

  @override
  String get dark => 'Gelap';

  @override
  String get about => 'Tentang';

  @override
  String get aboutTaskTrakr => 'Tentang TaskTrakr';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get helpSupport => 'Bantuan & Dukungan';

  @override
  String get dataStaysPrivate => 'Datamu tetap privat';

  @override
  String get dataPrivacyDescription =>
      'Semua datamu disimpan secara lokal di perangkatmu. Kami tidak mengumpulkan informasi pribadi apapun.';

  @override
  String get aboutDescription => 'Pembangun tujuan dan kebiasaan berbasis AI.';

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 hari';

  @override
  String get days14 => '14 hari';

  @override
  String get days21 => '21 hari';

  @override
  String get days30 => '30 hari';

  @override
  String get days60 => '60 hari';

  @override
  String get days90 => '90 hari';

  @override
  String get categoryFitness => 'Kebugaran';

  @override
  String get categoryLearning => 'Pembelajaran';

  @override
  String get categoryCreative => 'Kreatif';

  @override
  String get categoryWellness => 'Kesehatan';

  @override
  String get categoryFinancial => 'Keuangan';

  @override
  String get categoryRamadan => 'Ramadan';

  @override
  String get categoryOther => 'Lainnya';

  @override
  String get chooseLanguage => 'Pilih bahasamu';

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
