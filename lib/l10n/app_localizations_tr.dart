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
}
