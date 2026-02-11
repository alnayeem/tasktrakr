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
}
