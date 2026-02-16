import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ms'),
    Locale('tr'),
    Locale('ur'),
    Locale('uz')
  ];

  /// The app name
  ///
  /// In en, this message translates to:
  /// **'TaskTrakr'**
  String get appName;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Get started button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Welcome greeting
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Welcome screen description
  ///
  /// In en, this message translates to:
  /// **'Turn your goals into achievable daily tasks with AI'**
  String get welcomeDescription;

  /// Feature: set goals
  ///
  /// In en, this message translates to:
  /// **'Set goals in your own words'**
  String get featureSetGoals;

  /// Feature: AI planning
  ///
  /// In en, this message translates to:
  /// **'AI creates your daily plan'**
  String get featureAIPlan;

  /// Feature: track progress
  ///
  /// In en, this message translates to:
  /// **'Track progress every day'**
  String get featureTrackProgress;

  /// Feature: Ramadan mode
  ///
  /// In en, this message translates to:
  /// **'Special Ramadan mode'**
  String get featureRamadanMode;

  /// Today's tasks section header
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get todaysTasks;

  /// My goals section header
  ///
  /// In en, this message translates to:
  /// **'My Goals'**
  String get myGoals;

  /// New goal button/title
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get newGoal;

  /// Add goal button
  ///
  /// In en, this message translates to:
  /// **'Add Goal'**
  String get addGoal;

  /// Goal input prompt
  ///
  /// In en, this message translates to:
  /// **'What do you want to achieve?'**
  String get whatToAchieve;

  /// Goal input hint
  ///
  /// In en, this message translates to:
  /// **'Example: I want to complete reading the Quran this Ramadan...'**
  String get goalHint;

  /// Duration section label
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// Category section label
  ///
  /// In en, this message translates to:
  /// **'Category (optional)'**
  String get categoryOptional;

  /// Generate plan button
  ///
  /// In en, this message translates to:
  /// **'Generate Plan'**
  String get generatePlan;

  /// AI helper text
  ///
  /// In en, this message translates to:
  /// **'AI will create a personalized daily plan for you'**
  String get aiWillCreate;

  /// AI loading message 1
  ///
  /// In en, this message translates to:
  /// **'Analyzing your goal...'**
  String get analyzingGoal;

  /// AI loading message 2
  ///
  /// In en, this message translates to:
  /// **'Creating your personalized plan...'**
  String get creatingPlan;

  /// AI loading message 3
  ///
  /// In en, this message translates to:
  /// **'Distributing tasks across {days} days...'**
  String distributingTasks(int days);

  /// AI loading message 4
  ///
  /// In en, this message translates to:
  /// **'Adding rest days...'**
  String get addingRestDays;

  /// AI loading message 5
  ///
  /// In en, this message translates to:
  /// **'Final touches...'**
  String get finalTouches;

  /// Creating tasks subtitle
  ///
  /// In en, this message translates to:
  /// **'Creating {days} daily tasks'**
  String creatingDailyTasks(int days);

  /// Your goal label
  ///
  /// In en, this message translates to:
  /// **'Your goal:'**
  String get yourGoal;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Progress text
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} days'**
  String daysOfDays(int completed, int total);

  /// Complete label
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// Current streak label
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// Best streak label
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get bestStreak;

  /// Ramadan phase 1
  ///
  /// In en, this message translates to:
  /// **'Phase of Mercy'**
  String get phaseOfMercy;

  /// Ramadan phase 2
  ///
  /// In en, this message translates to:
  /// **'Phase of Forgiveness'**
  String get phaseOfForgiveness;

  /// Ramadan phase 3
  ///
  /// In en, this message translates to:
  /// **'Phase of Salvation'**
  String get phaseOfSalvation;

  /// Days range
  ///
  /// In en, this message translates to:
  /// **'Days {start}-{end}'**
  String daysRange(int start, int end);

  /// Laylatul Qadr reminder
  ///
  /// In en, this message translates to:
  /// **'Qadr nights soon'**
  String get qadrNightsSoon;

  /// Today label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Today with day number
  ///
  /// In en, this message translates to:
  /// **'Today - Day {day}'**
  String todayDay(int day);

  /// Upcoming section
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// Completed section
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Edit goal option
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get editGoal;

  /// Regenerate plan option
  ///
  /// In en, this message translates to:
  /// **'Regenerate Plan'**
  String get regeneratePlan;

  /// Delete goal option
  ///
  /// In en, this message translates to:
  /// **'Delete Goal'**
  String get deleteGoal;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Select language dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Appearance section
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Select theme dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// System default theme
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// About section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// About TaskTrakr option
  ///
  /// In en, this message translates to:
  /// **'About TaskTrakr'**
  String get aboutTaskTrakr;

  /// Privacy policy option
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Help and support option
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// Privacy notice title
  ///
  /// In en, this message translates to:
  /// **'Your data stays private'**
  String get dataStaysPrivate;

  /// Privacy notice description
  ///
  /// In en, this message translates to:
  /// **'All your data is stored locally on your device. We don\'t collect any personal information.'**
  String get dataPrivacyDescription;

  /// About dialog description
  ///
  /// In en, this message translates to:
  /// **'AI-powered goal and habit builder.'**
  String get aboutDescription;

  /// Version text
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Error dialog title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// 7 days duration
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get days7;

  /// 14 days duration
  ///
  /// In en, this message translates to:
  /// **'14 days'**
  String get days14;

  /// 21 days duration
  ///
  /// In en, this message translates to:
  /// **'21 days'**
  String get days21;

  /// 30 days duration
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get days30;

  /// 60 days duration
  ///
  /// In en, this message translates to:
  /// **'60 days'**
  String get days60;

  /// 90 days duration
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get days90;

  /// Fitness category
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get categoryFitness;

  /// Learning category
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get categoryLearning;

  /// Creative category
  ///
  /// In en, this message translates to:
  /// **'Creative'**
  String get categoryCreative;

  /// Wellness category
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get categoryWellness;

  /// Financial category
  ///
  /// In en, this message translates to:
  /// **'Financial'**
  String get categoryFinancial;

  /// Ramadan category
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get categoryRamadan;

  /// Other category
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// Language selection title
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// Empty state when no tasks
  ///
  /// In en, this message translates to:
  /// **'No tasks for today'**
  String get noTasksToday;

  /// Empty state helper text
  ///
  /// In en, this message translates to:
  /// **'Add a goal to get started'**
  String get addGoalToGetStarted;

  /// Notifications section header
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Daily reminder toggle
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get dailyReminder;

  /// Daily reminder description
  ///
  /// In en, this message translates to:
  /// **'Get reminded to check your tasks'**
  String get dailyReminderDescription;

  /// Reminder time setting
  ///
  /// In en, this message translates to:
  /// **'Reminder Time'**
  String get reminderTime;

  /// Select time dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// Permission required message
  ///
  /// In en, this message translates to:
  /// **'Notification permission is required'**
  String get notificationPermissionRequired;

  /// Enable notifications instruction
  ///
  /// In en, this message translates to:
  /// **'Please enable notifications in your device settings'**
  String get enableNotificationsInSettings;

  /// Daily reminder notification title
  ///
  /// In en, this message translates to:
  /// **'Time to check your goals!'**
  String get reminderNotificationTitle;

  /// Daily reminder notification body
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to complete today\'s tasks'**
  String get reminderNotificationBody;

  /// Sign in button/title
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign up button/title
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Google sign in button
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInWithGoogle;

  /// Apple sign in button
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get signInWithApple;

  /// Email sign in option
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get signInWithEmail;

  /// Create account button
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Reset password button/title
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Send reset link button
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// Back to login link
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// Sign up prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Sign in prompt text
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Social sign in divider text
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// Email verification title
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyEmail;

  /// Verification email sent message
  ///
  /// In en, this message translates to:
  /// **'We sent a verification email to:'**
  String get verificationEmailSent;

  /// Verification instruction
  ///
  /// In en, this message translates to:
  /// **'Click the link in the email to verify your account.'**
  String get clickLinkToVerify;

  /// Verification check button
  ///
  /// In en, this message translates to:
  /// **'I\'ve Verified My Email'**
  String get iveVerifiedEmail;

  /// Resend verification button
  ///
  /// In en, this message translates to:
  /// **'Resend Verification Email'**
  String get resendVerificationEmail;

  /// Resend success message
  ///
  /// In en, this message translates to:
  /// **'Verification email sent!'**
  String get verificationEmailResent;

  /// Not verified yet message
  ///
  /// In en, this message translates to:
  /// **'Email not verified yet. Please check your inbox.'**
  String get emailNotVerifiedYet;

  /// Wrong email prompt
  ///
  /// In en, this message translates to:
  /// **'Wrong email?'**
  String get wrongEmail;

  /// Email troubleshoot title
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the email?'**
  String get didntReceiveEmail;

  /// Spam folder hint
  ///
  /// In en, this message translates to:
  /// **'Check your spam or junk folder'**
  String get checkSpamFolder;

  /// Correct email hint
  ///
  /// In en, this message translates to:
  /// **'Make sure you entered the correct email'**
  String get correctEmailHint;

  /// Wait and retry hint
  ///
  /// In en, this message translates to:
  /// **'Wait a few minutes and try again'**
  String get waitAndTryAgain;

  /// Password reset success title
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get checkYourEmail;

  /// Password reset link sent message
  ///
  /// In en, this message translates to:
  /// **'If an account exists for {email}, you\'ll receive a password reset link.'**
  String resetLinkSent(String email);

  /// Try different email link
  ///
  /// In en, this message translates to:
  /// **'Try a different email'**
  String get tryDifferentEmail;

  /// Password validation error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Password mismatch error
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Invalid email error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// Terms agreement checkbox
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get agreeToTerms;

  /// Terms agreement error
  ///
  /// In en, this message translates to:
  /// **'You must agree to continue'**
  String get mustAgreeToTerms;

  /// Account section header
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Signed in as label
  ///
  /// In en, this message translates to:
  /// **'Signed in as'**
  String get signedInAs;

  /// Auth provider label
  ///
  /// In en, this message translates to:
  /// **'Signed in with {provider}'**
  String signedInWith(String provider);

  /// Delete account button
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Delete account warning
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all associated data. This action cannot be undone.'**
  String get deleteAccountWarning;

  /// Confirm delete button
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete My Account'**
  String get confirmDelete;

  /// Default auth error
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get authErrorDefault;

  /// Invalid email auth error
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get authErrorInvalidEmail;

  /// Wrong password auth error
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get authErrorWrongPassword;

  /// User not found auth error
  ///
  /// In en, this message translates to:
  /// **'No account found with this email'**
  String get authErrorUserNotFound;

  /// Email in use auth error
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email'**
  String get authErrorEmailInUse;

  /// Weak password auth error
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get authErrorWeakPassword;

  /// Network error
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get authErrorNetworkFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bn',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'ms',
        'tr',
        'ur',
        'uz'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ms':
      return AppLocalizationsMs();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
