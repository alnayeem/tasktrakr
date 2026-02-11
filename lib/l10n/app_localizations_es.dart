// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'TaskTrakr';

  @override
  String get continueButton => 'Continuar';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get welcomeDescription =>
      'Convierte tus metas en tareas diarias alcanzables con IA';

  @override
  String get featureSetGoals => 'Establece metas con tus propias palabras';

  @override
  String get featureAIPlan => 'La IA crea tu plan diario';

  @override
  String get featureTrackProgress => 'Sigue tu progreso cada día';

  @override
  String get featureRamadanMode => 'Modo Ramadán especial';

  @override
  String get todaysTasks => 'Tareas de Hoy';

  @override
  String get myGoals => 'Mis Metas';

  @override
  String get newGoal => 'Nueva Meta';

  @override
  String get addGoal => 'Agregar Meta';

  @override
  String get whatToAchieve => '¿Qué quieres lograr?';

  @override
  String get goalHint =>
      'Ejemplo: Quiero terminar de leer el Corán este Ramadán...';

  @override
  String get duration => 'Duración';

  @override
  String get categoryOptional => 'Categoría (opcional)';

  @override
  String get generatePlan => 'Generar Plan';

  @override
  String get aiWillCreate =>
      'La IA creará un plan diario personalizado para ti';

  @override
  String get analyzingGoal => 'Analizando tu meta...';

  @override
  String get creatingPlan => 'Creando tu plan personalizado...';

  @override
  String distributingTasks(int days) {
    return 'Distribuyendo tareas en $days días...';
  }

  @override
  String get addingRestDays => 'Agregando días de descanso...';

  @override
  String get finalTouches => 'Toques finales...';

  @override
  String creatingDailyTasks(int days) {
    return 'Creando $days tareas diarias';
  }

  @override
  String get yourGoal => 'Tu meta:';

  @override
  String get cancel => 'Cancelar';

  @override
  String daysOfDays(int completed, int total) {
    return '$completed de $total días';
  }

  @override
  String get complete => 'Completo';

  @override
  String get currentStreak => 'Racha Actual';

  @override
  String get bestStreak => 'Mejor Racha';

  @override
  String get phaseOfMercy => 'Fase de Misericordia';

  @override
  String get phaseOfForgiveness => 'Fase de Perdón';

  @override
  String get phaseOfSalvation => 'Fase de Salvación';

  @override
  String daysRange(int start, int end) {
    return 'Días $start-$end';
  }

  @override
  String get qadrNightsSoon => 'Noches de Qadr pronto';

  @override
  String get today => 'Hoy';

  @override
  String todayDay(int day) {
    return 'Hoy - Día $day';
  }

  @override
  String get upcoming => 'Próximo';

  @override
  String get completed => 'Completado';

  @override
  String get editGoal => 'Editar Meta';

  @override
  String get regeneratePlan => 'Regenerar Plan';

  @override
  String get deleteGoal => 'Eliminar Meta';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Seleccionar Tema';

  @override
  String get systemDefault => 'Predeterminado del Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get about => 'Acerca de';

  @override
  String get aboutTaskTrakr => 'Acerca de TaskTrakr';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get helpSupport => 'Ayuda y Soporte';

  @override
  String get dataStaysPrivate => 'Tus datos permanecen privados';

  @override
  String get dataPrivacyDescription =>
      'Todos tus datos se almacenan localmente en tu dispositivo. No recopilamos ninguna información personal.';

  @override
  String get aboutDescription =>
      'Constructor de metas y hábitos impulsado por IA.';

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get days7 => '7 días';

  @override
  String get days14 => '14 días';

  @override
  String get days21 => '21 días';

  @override
  String get days30 => '30 días';

  @override
  String get days60 => '60 días';

  @override
  String get days90 => '90 días';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryLearning => 'Aprendizaje';

  @override
  String get categoryCreative => 'Creativo';

  @override
  String get categoryWellness => 'Bienestar';

  @override
  String get categoryFinancial => 'Finanzas';

  @override
  String get categoryRamadan => 'Ramadán';

  @override
  String get categoryOther => 'Otro';

  @override
  String get chooseLanguage => 'Elige tu idioma';

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
