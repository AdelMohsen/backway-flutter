import 'package:firebase_messaging/firebase_messaging.dart';
import '../../utils/utility.dart';
import 'fcm_service.dart';
import 'local_notification_service.dart';

/// Simple helper class for FCM integration
class FCMIntegrationHelper {
  /// Initialize FCM notifications
  static Future<void> initializeFCM() async {
    try {
      cprint('[FCM Helper] Starting FCM initialization...');

      // Initialize local notifications first
      await LocalNotificationService.instance.initialize();

      // Set background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Initialize FCM service
      await FCMService.instance.initialize();

      cprint('[FCM Helper] FCM integration completed');
    } catch (e) {
      cprint('[FCM Helper] Error: $e');
    }
  }

  /// Get FCM token synchronously (cached)
  static String? getFCMToken() {
    return FCMService.getToken();
  }

  /// Get FCM token asynchronously (fetches if needed)
  static Future<String?> getFCMTokenAsync() async {
    return FCMService.getTokenAsync();
  }

  /// Check if FCM is initialized
  static bool isInitialized() {
    return FCMService.instance.isInitialized;
  }
}
