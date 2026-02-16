// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'جاری رکھیں';

  @override
  String get getStarted => 'شروع کریں';

  @override
  String get welcome => 'خوش آمدید';

  @override
  String get welcomeDescription =>
      'AI کی مدد سے اپنے مقاصد کو قابل حصول روزانہ کاموں میں بدلیں';

  @override
  String get featureSetGoals => 'اپنے الفاظ میں مقاصد طے کریں';

  @override
  String get featureAIPlan => 'AI آپ کا روزانہ منصوبہ بناتا ہے';

  @override
  String get featureTrackProgress => 'ہر روز پیشرفت ٹریک کریں';

  @override
  String get featureRamadanMode => 'خصوصی رمضان موڈ';

  @override
  String get todaysTasks => 'آج کے کام';

  @override
  String get myGoals => 'میرے مقاصد';

  @override
  String get newGoal => 'نیا مقصد';

  @override
  String get addGoal => 'مقصد شامل کریں';

  @override
  String get whatToAchieve => 'آپ کیا حاصل کرنا چاہتے ہیں؟';

  @override
  String get goalHint => 'مثال: میں اس رمضان میں قرآن ختم کرنا چاہتا ہوں...';

  @override
  String get duration => 'مدت';

  @override
  String get categoryOptional => 'زمرہ (اختیاری)';

  @override
  String get generatePlan => 'منصوبہ بنائیں';

  @override
  String get aiWillCreate => 'AI آپ کے لیے ایک ذاتی روزانہ منصوبہ بنائے گا';

  @override
  String get analyzingGoal => 'آپ کے مقصد کا تجزیہ...';

  @override
  String get creatingPlan => 'آپ کا ذاتی منصوبہ بن رہا ہے...';

  @override
  String distributingTasks(int days) {
    return '$days دنوں میں کام تقسیم ہو رہے ہیں...';
  }

  @override
  String get addingRestDays => 'آرام کے دن شامل ہو رہے ہیں...';

  @override
  String get finalTouches => 'آخری لمحات...';

  @override
  String creatingDailyTasks(int days) {
    return '$days روزانہ کام بن رہے ہیں';
  }

  @override
  String get yourGoal => 'آپ کا مقصد:';

  @override
  String get cancel => 'منسوخ';

  @override
  String daysOfDays(int completed, int total) {
    return '$total میں سے $completed دن';
  }

  @override
  String get complete => 'مکمل';

  @override
  String get currentStreak => 'موجودہ سلسلہ';

  @override
  String get bestStreak => 'بہترین سلسلہ';

  @override
  String get phaseOfMercy => 'رحمت کا مرحلہ';

  @override
  String get phaseOfForgiveness => 'مغفرت کا مرحلہ';

  @override
  String get phaseOfSalvation => 'نجات کا مرحلہ';

  @override
  String daysRange(int start, int end) {
    return 'دن $start-$end';
  }

  @override
  String get qadrNightsSoon => 'شب قدر قریب ہے';

  @override
  String get today => 'آج';

  @override
  String todayDay(int day) {
    return 'آج - دن $day';
  }

  @override
  String get upcoming => 'آنے والا';

  @override
  String get completed => 'مکمل';

  @override
  String get editGoal => 'مقصد میں ترمیم';

  @override
  String get regeneratePlan => 'منصوبہ دوبارہ بنائیں';

  @override
  String get deleteGoal => 'مقصد حذف کریں';

  @override
  String get settings => 'ترتیبات';

  @override
  String get language => 'زبان';

  @override
  String get selectLanguage => 'زبان منتخب کریں';

  @override
  String get appearance => 'ظاہری شکل';

  @override
  String get theme => 'تھیم';

  @override
  String get selectTheme => 'تھیم منتخب کریں';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get light => 'روشن';

  @override
  String get dark => 'تاریک';

  @override
  String get about => 'کے بارے میں';

  @override
  String get aboutTaskTrakr => 'TaskTrakr کے بارے میں';

  @override
  String get privacyPolicy => 'رازداری کی پالیسی';

  @override
  String get helpSupport => 'مدد اور سپورٹ';

  @override
  String get dataStaysPrivate => 'آپ کا ڈیٹا نجی رہتا ہے';

  @override
  String get dataPrivacyDescription =>
      'آپ کا تمام ڈیٹا آپ کے آلے پر مقامی طور پر محفوظ ہے۔ ہم کوئی ذاتی معلومات جمع نہیں کرتے۔';

  @override
  String get aboutDescription => 'AI سے چلنے والا مقصد اور عادت بنانے والا۔';

  @override
  String version(String version) {
    return 'ورژن $version';
  }

  @override
  String get ok => 'ٹھیک ہے';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 دن';

  @override
  String get days14 => '14 دن';

  @override
  String get days21 => '21 دن';

  @override
  String get days30 => '30 دن';

  @override
  String get days60 => '60 دن';

  @override
  String get days90 => '90 دن';

  @override
  String get categoryFitness => 'فٹنس';

  @override
  String get categoryLearning => 'سیکھنا';

  @override
  String get categoryCreative => 'تخلیقی';

  @override
  String get categoryWellness => 'تندرستی';

  @override
  String get categoryFinancial => 'مالی';

  @override
  String get categoryRamadan => 'رمضان';

  @override
  String get categoryOther => 'دیگر';

  @override
  String get chooseLanguage => 'اپنی زبان منتخب کریں';

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
