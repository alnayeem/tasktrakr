import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Service for managing local notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const int dailyReminderId = 0;
  static const String channelId = 'daily_reminder';
  static const String channelName = 'Daily Reminders';
  static const String channelDescription =
      'Daily reminders to check your tasks and goals';

  bool _isInitialized = false;

  /// Initialize the notification service
  Future<void> init() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz_data.initializeTimeZones();

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    await _createNotificationChannel();

    _isInitialized = true;
    debugPrint('NotificationService initialized');
  }

  /// Create Android notification channel
  Future<void> _createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // The app will open to the main screen when tapped
  }

  /// Request notification permissions
  Future<bool> requestPermissions() async {
    // Request iOS permissions
    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    // Request Android permissions (Android 13+)
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    return true;
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      return await androidPlugin.areNotificationsEnabled() ?? false;
    }
    return true;
  }

  /// Schedule daily reminder notification
  /// [hour] and [minute] specify the time (24-hour format)
  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    // Cancel existing reminder first
    await cancelDailyReminder();

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If the time has passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      dailyReminderId,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'daily_reminder',
    );

    debugPrint('Daily reminder scheduled for $hour:$minute');
  }

  /// Cancel daily reminder
  Future<void> cancelDailyReminder() async {
    await _notifications.cancel(dailyReminderId);
    debugPrint('Daily reminder cancelled');
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
    debugPrint('All notifications cancelled');
  }

  /// Show an immediate notification (for testing)
  Future<void> showTestNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      1, // Use a different ID for test notifications
      title,
      body,
      details,
    );
  }

  /// Parse time string (HH:mm) to hour and minute
  static (int hour, int minute) parseTimeString(String timeString) {
    final parts = timeString.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
    return (hour, minute);
  }

  /// Format hour and minute to time string (HH:mm)
  static String formatTimeString(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
