// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get welcome => 'स्वागत है';

  @override
  String get welcomeDescription =>
      'AI की मदद से अपने लक्ष्यों को प्राप्त करने योग्य दैनिक कार्यों में बदलें';

  @override
  String get featureSetGoals => 'अपने शब्दों में लक्ष्य निर्धारित करें';

  @override
  String get featureAIPlan => 'AI आपकी दैनिक योजना बनाता है';

  @override
  String get featureTrackProgress => 'हर दिन प्रगति ट्रैक करें';

  @override
  String get featureRamadanMode => 'विशेष रमजान मोड';

  @override
  String get todaysTasks => 'आज के कार्य';

  @override
  String get myGoals => 'मेरे लक्ष्य';

  @override
  String get newGoal => 'नया लक्ष्य';

  @override
  String get addGoal => 'लक्ष्य जोड़ें';

  @override
  String get whatToAchieve => 'आप क्या हासिल करना चाहते हैं?';

  @override
  String get goalHint => 'उदाहरण: मैं इस रमजान में कुरान पढ़ना चाहता हूं...';

  @override
  String get duration => 'अवधि';

  @override
  String get categoryOptional => 'श्रेणी (वैकल्पिक)';

  @override
  String get generatePlan => 'योजना बनाएं';

  @override
  String get aiWillCreate => 'AI आपके लिए एक व्यक्तिगत दैनिक योजना बनाएगा';

  @override
  String get analyzingGoal => 'आपके लक्ष्य का विश्लेषण...';

  @override
  String get creatingPlan => 'आपकी व्यक्तिगत योजना बना रहे हैं...';

  @override
  String distributingTasks(int days) {
    return '$days दिनों में कार्य वितरित कर रहे हैं...';
  }

  @override
  String get addingRestDays => 'आराम के दिन जोड़ रहे हैं...';

  @override
  String get finalTouches => 'अंतिम स्पर्श...';

  @override
  String creatingDailyTasks(int days) {
    return '$days दैनिक कार्य बना रहे हैं';
  }

  @override
  String get yourGoal => 'आपका लक्ष्य:';

  @override
  String get cancel => 'रद्द करें';

  @override
  String daysOfDays(int completed, int total) {
    return '$total में से $completed दिन';
  }

  @override
  String get complete => 'पूर्ण';

  @override
  String get currentStreak => 'वर्तमान स्ट्रीक';

  @override
  String get bestStreak => 'सर्वश्रेष्ठ स्ट्रीक';

  @override
  String get phaseOfMercy => 'रहमत का चरण';

  @override
  String get phaseOfForgiveness => 'माफी का चरण';

  @override
  String get phaseOfSalvation => 'मुक्ति का चरण';

  @override
  String daysRange(int start, int end) {
    return 'दिन $start-$end';
  }

  @override
  String get qadrNightsSoon => 'कद्र की रातें जल्द';

  @override
  String get today => 'आज';

  @override
  String todayDay(int day) {
    return 'आज - दिन $day';
  }

  @override
  String get upcoming => 'आगामी';

  @override
  String get completed => 'पूर्ण';

  @override
  String get editGoal => 'लक्ष्य संपादित करें';

  @override
  String get regeneratePlan => 'योजना पुनः बनाएं';

  @override
  String get deleteGoal => 'लक्ष्य हटाएं';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get appearance => 'दिखावट';

  @override
  String get theme => 'थीम';

  @override
  String get selectTheme => 'थीम चुनें';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get light => 'लाइट';

  @override
  String get dark => 'डार्क';

  @override
  String get about => 'के बारे में';

  @override
  String get aboutTaskTrakr => 'TaskTrakr के बारे में';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get helpSupport => 'सहायता और समर्थन';

  @override
  String get dataStaysPrivate => 'आपका डेटा निजी रहता है';

  @override
  String get dataPrivacyDescription =>
      'आपका सारा डेटा आपके डिवाइस पर स्थानीय रूप से संग्रहीत है। हम कोई व्यक्तिगत जानकारी एकत्र नहीं करते।';

  @override
  String get aboutDescription => 'AI-संचालित लक्ष्य और आदत निर्माता।';

  @override
  String version(String version) {
    return 'संस्करण $version';
  }

  @override
  String get ok => 'ठीक है';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 दिन';

  @override
  String get days14 => '14 दिन';

  @override
  String get days21 => '21 दिन';

  @override
  String get days30 => '30 दिन';

  @override
  String get days60 => '60 दिन';

  @override
  String get days90 => '90 दिन';

  @override
  String get categoryFitness => 'फिटनेस';

  @override
  String get categoryLearning => 'सीखना';

  @override
  String get categoryCreative => 'क्रिएटिव';

  @override
  String get categoryWellness => 'कल्याण';

  @override
  String get categoryFinancial => 'वित्तीय';

  @override
  String get categoryRamadan => 'रमजान';

  @override
  String get categoryOther => 'अन्य';

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

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
