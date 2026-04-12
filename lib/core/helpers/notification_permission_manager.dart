import 'package:flutter/material.dart';
import 'package:greenhub/core/shared/cache/shared_helper.dart';
import '../utils/utility.dart';
import 'notification_permission_dialog.dart';
import 'permissions.dart';

/// Manages notification permission state and user preferences
class NotificationPermissionManager {
  /// Check if user has been asked for notification permission before
  static Future<bool> hasBeenAsked() async {
    try {
      final asked = SharedHelper.box?.get(
        CachingKey.NOTIFICATION_PERMISSION_ASKED.value,
        defaultValue: false,
      );
      return asked ?? false;
    } catch (e) {
      cprint(
        '❌ Error checking if notification permission was asked: ${e.toString()}',
      );
      return false;
    }
  }

  /// Get user's previous notification permission choice
  static Future<bool> wasGranted() async {
    try {
      final granted = SharedHelper.box?.get(
        CachingKey.NOTIFICATION_PERMISSION_GRANTED.value,
        defaultValue: false,
      );
      return granted ?? false;
    } catch (e) {
      cprint(
        '❌ Error checking notification permission status: ${e.toString()}',
      );
      return false;
    }
  }

  /// Save user's notification permission choice
  static Future<void> savePermissionChoice(bool granted) async {
    try {
      await SharedHelper.box?.put(
        CachingKey.NOTIFICATION_PERMISSION_ASKED.value,
        true,
      );
      await SharedHelper.box?.put(
        CachingKey.NOTIFICATION_PERMISSION_GRANTED.value,
        granted,
      );
      cprint('💾 Saved notification permission choice: $granted');
    } catch (e) {
      cprint('❌ Error saving notification permission choice: ${e.toString()}');
    }
  }

  /// Request notification permission with dialog and system permission
  /// Returns true if permission was granted, false otherwise
  static Future<bool> requestPermissionWithDialog({
    required BuildContext context,
    required bool isArabic,
  }) async {
    try {
      cprint('🔔 Starting notification permission request flow');

      // Check if already asked
      final alreadyAsked = await hasBeenAsked();
      if (alreadyAsked) {
        cprint('ℹ️ User was already asked for notification permission');
        final previousChoice = await wasGranted();
        cprint('Previous choice: $previousChoice');

        // If user previously granted, verify system permission
        if (previousChoice) {
          final systemPermission =
              await PermissionHandler.checkNotificationPermission();
          cprint('System permission status: $systemPermission');
          return systemPermission;
        }

        return previousChoice;
      }

      // Show custom dialog to explain why we need permission
      cprint('📱 Showing notification permission dialog');
      final userChoice = await NotificationPermissionDialog.show(context);

      if (userChoice == null) {
        // Dialog was dismissed (shouldn't happen due to barrierDismissible: false)
        cprint('⚠️ Dialog was dismissed without choice');
        await savePermissionChoice(false);
        return false;
      }

      cprint('User choice from dialog: $userChoice');

      if (!userChoice) {
        // User declined in our dialog
        cprint('❌ User declined notification permission in dialog');
        await savePermissionChoice(false);
        return false;
      }

      // User agreed in dialog, now request system permission
      cprint('✅ User agreed in dialog, requesting system permission');
      final systemPermission =
          await PermissionHandler.requestNotificationPermission(
            openSettingsOnDenied: false,
          );

      cprint('System permission result: $systemPermission');

      // Save the final result
      await savePermissionChoice(systemPermission);

      return systemPermission;
    } catch (e) {
      cprint('❌ Error in notification permission flow: ${e.toString()}');
      await savePermissionChoice(false);
      return false;
    }
  }

  /// Reset permission state (for testing or settings)
  static Future<void> resetPermissionState() async {
    try {
      await SharedHelper.box?.delete(
        CachingKey.NOTIFICATION_PERMISSION_ASKED.value,
      );
      await SharedHelper.box?.delete(
        CachingKey.NOTIFICATION_PERMISSION_GRANTED.value,
      );
      cprint('🔄 Reset notification permission state');
    } catch (e) {
      cprint(
        '❌ Error resetting notification permission state: ${e.toString()}',
      );
    }
  }
}
