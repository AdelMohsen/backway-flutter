import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../utils/utility.dart';

/// Local notification service for displaying notifications
class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  // final FlutterLocalNotificationsPlugin _plugin =
  //     FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  /// Initialize local notifications
  Future<void> initialize() async {
    if (_isInitialized) {
      cprint('[LocalNotif] Already initialized');
      return;
    }

    try {
      cprint('[LocalNotif] Initializing...');

      // // Android settings
      // const androidSettings = AndroidInitializationSettings(
      //   '@mipmap/ic_launcher',
      // );

      // // iOS settings
      // const iosSettings = DarwinInitializationSettings(
      //   requestAlertPermission: false,
      //   requestBadgePermission: false,
      //   requestSoundPermission: false,
      // );

      // // Initialize
      // const initSettings = InitializationSettings(
      //   android: androidSettings,
      //   iOS: iosSettings,
      // );

      // await _plugin.initialize(
      //   initSettings,
      //   onDidReceiveNotificationResponse: _onNotificationTapped,
      // );

      // Create notification channel for Android
      await _createNotificationChannel();

      _isInitialized = true;
      cprint('[LocalNotif] ✅ Initialized successfully');
    } catch (e) {
      cprint('[LocalNotif] ❌ Error: $e');
    }
  }

  /// Create Android notification channel
  Future<void> _createNotificationChannel() async {
    // const channel = AndroidNotificationChannel(
    //   'cm2_notifications',
    //   'CM² Notifications',
    //   description: 'Notifications from CM²',
    //   importance: Importance.high,
    //   playSound: true,
    //   enableVibration: true,
    // );

    // await _plugin
    //     .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin
    //     >()
    //     ?.createNotificationChannel(channel);

    cprint('[LocalNotif] Notification channel created');
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    cprint('[LocalNotif] Notification tapped: ${response.payload}');
    // TODO: Handle navigation based on payload
  }

  /// Show notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) {
      cprint('[LocalNotif] Not initialized, initializing now...');
      await initialize();
    }

    try {
      cprint('[LocalNotif] Showing notification: $title');

      // const androidDetails = AndroidNotificationDetails(
      //   'cm2_notifications',
      //   'CM² Notifications',
      //   channelDescription: 'Notifications from CM²',
      //   importance: Importance.high,
      //   priority: Priority.high,
      //   playSound: true,
      //   enableVibration: true,
      //   icon: '@mipmap/ic_launcher',
      // );

      // const iosDetails = DarwinNotificationDetails(
      //   presentAlert: true,
      //   presentBadge: true,
      //   presentSound: true,
      // );

      // const details = NotificationDetails(
      //   android: androidDetails,
      //   iOS: iosDetails,
      // );

      //   await _plugin.show(id, title, body, details, payload: payload);
      cprint('[LocalNotif] ✅ Notification shown');
    } catch (e) {
      cprint('[LocalNotif] ❌ Error showing notification: $e');
    }
  }
}
