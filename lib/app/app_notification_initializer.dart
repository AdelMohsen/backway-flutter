import 'package:flutter/material.dart';
import '../core/helpers/notification_permission_manager.dart';
import '../core/services/fcm_notification/fcm_integration_helper.dart';
import '../core/utils/utility.dart';

/// Handles notification permission request and FCM initialization at app level
/// Call this from the app widget after BuildContext is available
class AppNotificationInitializer {
  static bool _isInitialized = false;

  /// Request notification permission with dialog and initialize FCM
  /// Should be called once when app starts and BuildContext is available
  /// Returns true if permission was granted, false otherwise
  static Future<bool> initializeNotifications({
    required BuildContext context,
    required bool isArabic,
  }) async {
    // Prevent multiple initializations
    if (_isInitialized) {
      cprint('ℹ️ Notification initialization already completed');
      return await NotificationPermissionManager.wasGranted();
    }

    try {
      cprint('🚀 Starting app-level notification initialization');

      // Check if user was already asked
      final hasBeenAsked = await NotificationPermissionManager.hasBeenAsked();

      if (hasBeenAsked) {
        // User was already asked, check their previous choice
        final wasGranted = await NotificationPermissionManager.wasGranted();
        cprint('User was already asked. Previous choice: $wasGranted');

        if (wasGranted) {
          // Try to initialize FCM if not already initialized
          try {
            //   await FCMIntegrationHelper.initializeFCM();
            cprint('✅ FCM initialized based on previous permission');
          } catch (e) {
            cprint('ℹ️ FCM may already be initialized: ${e.toString()}');
          }
        }

        _isInitialized = true;
        return wasGranted;
      }

      // User hasn't been asked yet, show dialog and request permission
      cprint('📱 User not asked yet, showing permission dialog');

      final permissionGranted =
          await NotificationPermissionManager.requestPermissionWithDialog(
            context: context,
            isArabic: isArabic,
          );

      cprint('Permission result: $permissionGranted');

      // Initialize FCM if permission was granted
      if (permissionGranted) {
        try {
          //    await FCMIntegrationHelper.initializeFCM();
          cprint('✅ FCM initialized successfully after permission grant');
        } catch (e) {
          cprint('❌ Error initializing FCM: ${e.toString()}');
        }
      } else {
        cprint('ℹ️ FCM not initialized - user denied permission');
      }

      _isInitialized = true;
      return permissionGranted;
    } catch (e) {
      cprint('❌ Error in app notification initialization: ${e.toString()}');
      _isInitialized = true;
      return false;
    }
  }

  /// Check if notification initialization is complete
  static bool get isInitialized => _isInitialized;

  /// Reset initialization state (for testing)
  static void reset() {
    _isInitialized = false;
  }
}
