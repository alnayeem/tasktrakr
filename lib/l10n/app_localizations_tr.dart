// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Devam Et';

  @override
  String get getStarted => 'Başla';

  @override
  String get welcome => 'Hoş Geldiniz';

  @override
  String get welcomeDescription =>
      'Hedeflerinizi yapay zeka ile ulaşılabilir günlük görevlere dönüştürün';

  @override
  String get featureSetGoals =>
      'Hedeflerinizi kendi kelimelerinizle belirleyin';

  @override
  String get featureAIPlan => 'Yapay zeka günlük planınızı oluşturur';

  @override
  String get featureTrackProgress => 'Her gün ilerlemenizi takip edin';

  @override
  String get featureRamadanMode => 'Özel Ramazan modu';

  @override
  String get todaysTasks => 'Bugünün Görevleri';

  @override
  String get myGoals => 'Hedeflerim';

  @override
  String get newGoal => 'Yeni Hedef';

  @override
  String get addGoal => 'Hedef Ekle';

  @override
  String get whatToAchieve => 'Ne başarmak istiyorsunuz?';

  @override
  String get goalHint =>
      'Örnek: Bu Ramazan\'da Kuran\'ı hatmetmek istiyorum...';

  @override
  String get duration => 'Süre';

  @override
  String get categoryOptional => 'Kategori (isteğe bağlı)';

  @override
  String get generatePlan => 'Plan Oluştur';

  @override
  String get aiWillCreate =>
      'Yapay zeka sizin için kişiselleştirilmiş bir günlük plan oluşturacak';

  @override
  String get analyzingGoal => 'Hedefiniz analiz ediliyor...';

  @override
  String get creatingPlan => 'Kişiselleştirilmiş planınız oluşturuluyor...';

  @override
  String distributingTasks(int days) {
    return 'Görevler $days güne dağıtılıyor...';
  }

  @override
  String get addingRestDays => 'Dinlenme günleri ekleniyor...';

  @override
  String get finalTouches => 'Son dokunuşlar...';

  @override
  String creatingDailyTasks(int days) {
    return '$days günlük görev oluşturuluyor';
  }

  @override
  String get yourGoal => 'Hedefiniz:';

  @override
  String get cancel => 'İptal';

  @override
  String daysOfDays(int completed, int total) {
    return '$total günden $completed gün';
  }

  @override
  String get complete => 'Tamamlandı';

  @override
  String get currentStreak => 'Mevcut Seri';

  @override
  String get bestStreak => 'En İyi Seri';

  @override
  String get phaseOfMercy => 'Rahmet Aşaması';

  @override
  String get phaseOfForgiveness => 'Mağfiret Aşaması';

  @override
  String get phaseOfSalvation => 'Kurtuluş Aşaması';

  @override
  String daysRange(int start, int end) {
    return 'Gün $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Kadir geceleri yakında';

  @override
  String get today => 'Bugün';

  @override
  String todayDay(int day) {
    return 'Bugün - Gün $day';
  }

  @override
  String get upcoming => 'Yaklaşan';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get editGoal => 'Hedefi Düzenle';

  @override
  String get regeneratePlan => 'Planı Yeniden Oluştur';

  @override
  String get deleteGoal => 'Hedefi Sil';

  @override
  String get settings => 'Ayarlar';

  @override
  String get language => 'Dil';

  @override
  String get selectLanguage => 'Dil Seçin';

  @override
  String get appearance => 'Görünüm';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Tema Seçin';

  @override
  String get systemDefault => 'Sistem Varsayılanı';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get about => 'Hakkında';

  @override
  String get aboutTaskTrakr => 'TaskTrakr Hakkında';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get helpSupport => 'Yardım ve Destek';

  @override
  String get dataStaysPrivate => 'Verileriniz gizli kalır';

  @override
  String get dataPrivacyDescription =>
      'Tüm verileriniz cihazınızda yerel olarak saklanır. Herhangi bir kişisel bilgi toplamıyoruz.';

  @override
  String get aboutDescription =>
      'Yapay zeka destekli hedef ve alışkanlık oluşturucu.';

  @override
  String version(String version) {
    return 'Sürüm $version';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 gün';

  @override
  String get days14 => '14 gün';

  @override
  String get days21 => '21 gün';

  @override
  String get days30 => '30 gün';

  @override
  String get days60 => '60 gün';

  @override
  String get days90 => '90 gün';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryLearning => 'Öğrenme';

  @override
  String get categoryCreative => 'Yaratıcı';

  @override
  String get categoryWellness => 'Sağlık';

  @override
  String get categoryFinancial => 'Finansal';

  @override
  String get categoryRamadan => 'Ramazan';

  @override
  String get categoryOther => 'Diğer';

  @override
  String get chooseLanguage => 'Dilinizi seçin';

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
