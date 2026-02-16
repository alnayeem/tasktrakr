// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'শুরু করুন';

  @override
  String get getStarted => 'শুরু করুন';

  @override
  String get welcome => 'স্বাগতম';

  @override
  String get welcomeDescription =>
      'AI এর সাহায্যে আপনার লক্ষ্যগুলোকে দৈনিক অর্জনযোগ্য কাজে রূপান্তর করুন';

  @override
  String get featureSetGoals => 'নিজের কথায় লক্ষ্য নির্ধারণ করুন';

  @override
  String get featureAIPlan => 'AI আপনার দৈনিক পরিকল্পনা তৈরি করে';

  @override
  String get featureTrackProgress => 'প্রতিদিন অগ্রগতি ট্র্যাক করুন';

  @override
  String get featureRamadanMode => 'বিশেষ রমজান মোড';

  @override
  String get todaysTasks => 'আজকের কাজ';

  @override
  String get myGoals => 'আমার লক্ষ্য';

  @override
  String get newGoal => 'নতুন লক্ষ্য';

  @override
  String get addGoal => 'লক্ষ্য যোগ করুন';

  @override
  String get whatToAchieve => 'আপনি কী অর্জন করতে চান?';

  @override
  String get goalHint => 'উদাহরণ: এই রমজানে কুরআন খতম করতে চাই...';

  @override
  String get duration => 'সময়কাল';

  @override
  String get categoryOptional => 'ক্যাটাগরি (ঐচ্ছিক)';

  @override
  String get generatePlan => 'পরিকল্পনা তৈরি করুন';

  @override
  String get aiWillCreate =>
      'AI আপনার জন্য একটি ব্যক্তিগত দৈনিক পরিকল্পনা তৈরি করবে';

  @override
  String get analyzingGoal => 'আপনার লক্ষ্য বিশ্লেষণ করা হচ্ছে...';

  @override
  String get creatingPlan => 'আপনার ব্যক্তিগত পরিকল্পনা তৈরি হচ্ছে...';

  @override
  String distributingTasks(int days) {
    return '$days দিনে কাজ বিতরণ করা হচ্ছে...';
  }

  @override
  String get addingRestDays => 'বিশ্রামের দিন যোগ করা হচ্ছে...';

  @override
  String get finalTouches => 'চূড়ান্ত স্পর্শ...';

  @override
  String creatingDailyTasks(int days) {
    return '$daysটি দৈনিক কাজ তৈরি হচ্ছে';
  }

  @override
  String get yourGoal => 'আপনার লক্ষ্য:';

  @override
  String get cancel => 'বাতিল';

  @override
  String daysOfDays(int completed, int total) {
    return '$total দিনের মধ্যে $completed দিন';
  }

  @override
  String get complete => 'সম্পূর্ণ';

  @override
  String get currentStreak => 'বর্তমান ধারা';

  @override
  String get bestStreak => 'সেরা ধারা';

  @override
  String get phaseOfMercy => 'রহমতের পর্ব';

  @override
  String get phaseOfForgiveness => 'ক্ষমার পর্ব';

  @override
  String get phaseOfSalvation => 'মুক্তির পর্ব';

  @override
  String daysRange(int start, int end) {
    return 'দিন $start-$end';
  }

  @override
  String get qadrNightsSoon => 'লাইলাতুল কদর আসছে';

  @override
  String get today => 'আজ';

  @override
  String todayDay(int day) {
    return 'আজ - দিন $day';
  }

  @override
  String get upcoming => 'আসন্ন';

  @override
  String get completed => 'সম্পন্ন';

  @override
  String get editGoal => 'লক্ষ্য সম্পাদনা';

  @override
  String get regeneratePlan => 'পরিকল্পনা পুনরায় তৈরি';

  @override
  String get deleteGoal => 'লক্ষ্য মুছুন';

  @override
  String get settings => 'সেটিংস';

  @override
  String get language => 'ভাষা';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get appearance => 'চেহারা';

  @override
  String get theme => 'থিম';

  @override
  String get selectTheme => 'থিম নির্বাচন করুন';

  @override
  String get systemDefault => 'সিস্টেম ডিফল্ট';

  @override
  String get light => 'লাইট';

  @override
  String get dark => 'ডার্ক';

  @override
  String get about => 'সম্পর্কে';

  @override
  String get aboutTaskTrakr => 'TaskTrakr সম্পর্কে';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get helpSupport => 'সাহায্য ও সহায়তা';

  @override
  String get dataStaysPrivate => 'আপনার ডেটা ব্যক্তিগত থাকে';

  @override
  String get dataPrivacyDescription =>
      'আপনার সমস্ত ডেটা আপনার ডিভাইসে স্থানীয়ভাবে সংরক্ষিত। আমরা কোনো ব্যক্তিগত তথ্য সংগ্রহ করি না।';

  @override
  String get aboutDescription => 'AI-চালিত লক্ষ্য ও অভ্যাস নির্মাতা।';

  @override
  String version(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '৭ দিন';

  @override
  String get days14 => '১৪ দিন';

  @override
  String get days21 => '২১ দিন';

  @override
  String get days30 => '৩০ দিন';

  @override
  String get days60 => '৬০ দিন';

  @override
  String get days90 => '৯০ দিন';

  @override
  String get categoryFitness => 'ফিটনেস';

  @override
  String get categoryLearning => 'শিক্ষা';

  @override
  String get categoryCreative => 'সৃজনশীল';

  @override
  String get categoryWellness => 'সুস্থতা';

  @override
  String get categoryFinancial => 'আর্থিক';

  @override
  String get categoryRamadan => 'রমজান';

  @override
  String get categoryOther => 'অন্যান্য';

  @override
  String get chooseLanguage => 'আপনার ভাষা নির্বাচন করুন';

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
