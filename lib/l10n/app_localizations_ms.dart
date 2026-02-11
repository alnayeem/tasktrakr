// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Teruskan';

  @override
  String get getStarted => 'Mula';

  @override
  String get welcome => 'Selamat Datang';

  @override
  String get welcomeDescription =>
      'Tukar matlamat anda kepada tugasan harian yang boleh dicapai dengan AI';

  @override
  String get featureSetGoals =>
      'Tetapkan matlamat dengan kata-kata anda sendiri';

  @override
  String get featureAIPlan => 'AI mencipta rancangan harian anda';

  @override
  String get featureTrackProgress => 'Jejak kemajuan setiap hari';

  @override
  String get featureRamadanMode => 'Mod Ramadan khas';

  @override
  String get todaysTasks => 'Tugasan Hari Ini';

  @override
  String get myGoals => 'Matlamat Saya';

  @override
  String get newGoal => 'Matlamat Baru';

  @override
  String get addGoal => 'Tambah Matlamat';

  @override
  String get whatToAchieve => 'Apa yang anda mahu capai?';

  @override
  String get goalHint => 'Contoh: Saya mahu khatam Al-Quran Ramadan ini...';

  @override
  String get duration => 'Tempoh';

  @override
  String get categoryOptional => 'Kategori (pilihan)';

  @override
  String get generatePlan => 'Jana Rancangan';

  @override
  String get aiWillCreate =>
      'AI akan mencipta rancangan harian peribadi untuk anda';

  @override
  String get analyzingGoal => 'Menganalisis matlamat anda...';

  @override
  String get creatingPlan => 'Mencipta rancangan peribadi anda...';

  @override
  String distributingTasks(int days) {
    return 'Mengagihkan tugasan selama $days hari...';
  }

  @override
  String get addingRestDays => 'Menambah hari rehat...';

  @override
  String get finalTouches => 'Sentuhan akhir...';

  @override
  String creatingDailyTasks(int days) {
    return 'Mencipta $days tugasan harian';
  }

  @override
  String get yourGoal => 'Matlamat anda:';

  @override
  String get cancel => 'Batal';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed daripada $total hari';
  }

  @override
  String get complete => 'Selesai';

  @override
  String get currentStreak => 'Streak Semasa';

  @override
  String get bestStreak => 'Streak Terbaik';

  @override
  String get phaseOfMercy => 'Fasa Rahmat';

  @override
  String get phaseOfForgiveness => 'Fasa Keampunan';

  @override
  String get phaseOfSalvation => 'Fasa Pembebasan';

  @override
  String daysRange(int start, int end) {
    return 'Hari $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Malam Qadr hampir tiba';

  @override
  String get today => 'Hari Ini';

  @override
  String todayDay(int day) {
    return 'Hari Ini - Hari $day';
  }

  @override
  String get upcoming => 'Akan Datang';

  @override
  String get completed => 'Selesai';

  @override
  String get editGoal => 'Edit Matlamat';

  @override
  String get regeneratePlan => 'Jana Semula Rancangan';

  @override
  String get deleteGoal => 'Padam Matlamat';

  @override
  String get settings => 'Tetapan';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get appearance => 'Penampilan';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get systemDefault => 'Lalai Sistem';

  @override
  String get light => 'Cerah';

  @override
  String get dark => 'Gelap';

  @override
  String get about => 'Tentang';

  @override
  String get aboutTaskTrakr => 'Tentang TaskTrakr';

  @override
  String get privacyPolicy => 'Dasar Privasi';

  @override
  String get helpSupport => 'Bantuan & Sokongan';

  @override
  String get dataStaysPrivate => 'Data anda kekal peribadi';

  @override
  String get dataPrivacyDescription =>
      'Semua data anda disimpan secara tempatan pada peranti anda. Kami tidak mengumpul sebarang maklumat peribadi.';

  @override
  String get aboutDescription => 'Pembina matlamat dan tabiat berkuasa AI.';

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
  String get categoryFitness => 'Kecergasan';

  @override
  String get categoryLearning => 'Pembelajaran';

  @override
  String get categoryCreative => 'Kreatif';

  @override
  String get categoryWellness => 'Kesejahteraan';

  @override
  String get categoryFinancial => 'Kewangan';

  @override
  String get categoryRamadan => 'Ramadan';

  @override
  String get categoryOther => 'Lain-lain';

  @override
  String get chooseLanguage => 'Pilih bahasa anda';

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
