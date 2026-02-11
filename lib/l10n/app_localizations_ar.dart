// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'التالي';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get welcome => 'مرحباً بك';

  @override
  String get welcomeDescription =>
      'حوّل أهدافك إلى مهام يومية قابلة للتحقيق باستخدام الذكاء الاصطناعي';

  @override
  String get featureSetGoals => 'حدد أهدافك بكلماتك الخاصة';

  @override
  String get featureAIPlan => 'الذكاء الاصطناعي يخطط لك';

  @override
  String get featureTrackProgress => 'تتبع تقدمك يومياً';

  @override
  String get featureRamadanMode => 'وضع رمضان الخاص';

  @override
  String get todaysTasks => 'مهام اليوم';

  @override
  String get myGoals => 'أهدافي';

  @override
  String get newGoal => 'هدف جديد';

  @override
  String get addGoal => 'إضافة هدف';

  @override
  String get whatToAchieve => 'ماذا تريد أن تحقق؟';

  @override
  String get goalHint => 'مثال: أريد أن أختم القرآن في رمضان...';

  @override
  String get duration => 'المدة';

  @override
  String get categoryOptional => 'الفئة (اختياري)';

  @override
  String get generatePlan => 'إنشاء خطة';

  @override
  String get aiWillCreate => 'سيقوم الذكاء الاصطناعي بإنشاء خطة يومية مخصصة لك';

  @override
  String get analyzingGoal => 'نحلل هدفك...';

  @override
  String get creatingPlan => 'ننشئ خطتك المخصصة...';

  @override
  String distributingTasks(int days) {
    return 'نوزع المهام على $days يوم...';
  }

  @override
  String get addingRestDays => 'نضيف أيام الراحة...';

  @override
  String get finalTouches => 'اللمسات الأخيرة...';

  @override
  String creatingDailyTasks(int days) {
    return 'إنشاء $days مهمة يومية';
  }

  @override
  String get yourGoal => 'هدفك:';

  @override
  String get cancel => 'إلغاء';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed من $total يوم';
  }

  @override
  String get complete => 'مكتمل';

  @override
  String get currentStreak => 'السلسلة الحالية';

  @override
  String get bestStreak => 'أفضل سلسلة';

  @override
  String get phaseOfMercy => 'مرحلة الرحمة';

  @override
  String get phaseOfForgiveness => 'مرحلة المغفرة';

  @override
  String get phaseOfSalvation => 'مرحلة العتق من النار';

  @override
  String daysRange(int start, int end) {
    return 'أيام $start-$end';
  }

  @override
  String get qadrNightsSoon => 'ليلة القدر قريبة';

  @override
  String get today => 'اليوم';

  @override
  String todayDay(int day) {
    return 'اليوم - يوم $day';
  }

  @override
  String get upcoming => 'القادم';

  @override
  String get completed => 'المكتمل';

  @override
  String get editGoal => 'تعديل الهدف';

  @override
  String get regeneratePlan => 'إعادة إنشاء الخطة';

  @override
  String get deleteGoal => 'حذف الهدف';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get appearance => 'المظهر';

  @override
  String get theme => 'المظهر';

  @override
  String get selectTheme => 'اختر المظهر';

  @override
  String get systemDefault => 'تلقائي (النظام)';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get about => 'حول التطبيق';

  @override
  String get aboutTaskTrakr => 'عن TaskTrakr';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get dataStaysPrivate => 'بياناتك محفوظة';

  @override
  String get dataPrivacyDescription =>
      'كل بياناتك مخزنة على جهازك فقط. لا نجمع أي معلومات شخصية.';

  @override
  String get aboutDescription =>
      'تطبيق لتحقيق الأهداف والعادات باستخدام الذكاء الاصطناعي.';

  @override
  String version(String version) {
    return 'الإصدار $version';
  }

  @override
  String get ok => 'حسناً';

  @override
  String get error => 'خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get days7 => '7 أيام';

  @override
  String get days14 => '14 يوم';

  @override
  String get days21 => '21 يوم';

  @override
  String get days30 => '30 يوم';

  @override
  String get days60 => '60 يوم';

  @override
  String get days90 => '90 يوم';

  @override
  String get categoryFitness => 'اللياقة';

  @override
  String get categoryLearning => 'التعلم';

  @override
  String get categoryCreative => 'الإبداع';

  @override
  String get categoryWellness => 'الصحة';

  @override
  String get categoryFinancial => 'المالية';

  @override
  String get categoryRamadan => 'رمضان';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get chooseLanguage => 'اختر لغتك';

  @override
  String get noTasksToday => 'لا توجد مهام لهذا اليوم';

  @override
  String get addGoalToGetStarted => 'أضف هدفاً للبدء';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get dailyReminder => 'التذكير اليومي';

  @override
  String get dailyReminderDescription => 'احصل على تذكير للتحقق من مهامك';

  @override
  String get reminderTime => 'وقت التذكير';

  @override
  String get selectTime => 'اختر الوقت';

  @override
  String get notificationPermissionRequired => 'إذن الإشعارات مطلوب';

  @override
  String get enableNotificationsInSettings =>
      'يرجى تفعيل الإشعارات في إعدادات الجهاز';

  @override
  String get reminderNotificationTitle => 'حان وقت مراجعة أهدافك!';

  @override
  String get reminderNotificationBody => 'لا تنسَ إنجاز مهام اليوم';
}
