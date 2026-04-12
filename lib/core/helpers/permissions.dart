import 'package:permission_handler/permission_handler.dart';

import '../utils/utility.dart';

/// Comprehensive Permission Handler Service for the entire app
/// Handles all permission requests with proper error handling and logging
abstract class PermissionHandler {
  /// Check if a permission is currently granted
  static Future<bool> _checkPermissionIsGranted(Permission permission) async {
    try {
      return await permission.isGranted;
    } catch (e) {
      cprint('❌ Error checking permission granted status: ${e.toString()}');
      return false;
    }
  }

  /// Core permission checking logic with request flow
  static Future<bool> _checkPermission(
    Permission permission, {
    String? permissionName,
    bool openSettingsOnDenied = false,
  }) async {
    try {
      final name = permissionName ?? permission.toString();
      cprint('🔍 Checking permission: $name');

      // Check if already granted
      if (await _checkPermissionIsGranted(permission)) {
        cprint('✅ Permission already granted: $name');
        return true;
      }

      // Check if permanently denied
      if (await permission.isPermanentlyDenied) {
        cprint('⛔ Permission permanently denied: $name');
        if (openSettingsOnDenied) {
          cprint(
            '📱 Opening app settings for user to enable permission manually',
          );
          await openAppSettings();
        }
        return false;
      }

      // Request permission
      cprint('📤 Requesting permission: $name');
      final PermissionStatus status = await permission.request();
      cprint('📥 Permission status received: ${status.name} for $name');

      // Special handling for storage permissions
      if (permission == Permission.manageExternalStorage) {
        if (status.isDenied || status.isRestricted) {
          cprint(
            '🔄 Manage external storage denied, trying regular storage permission',
          );
          return await checkStoragePermission();
        }
      }

      // Check final status
      final isGranted = await _checkPermissionIsGranted(permission);
      if (isGranted) {
        cprint('✅ Permission granted: $name');
      } else {
        cprint('❌ Permission denied: $name');
      }
      return isGranted;
    } catch (e) {
      cprint('❌ Error checking permission: ${e.toString()}');
      return false;
    }
  }

  // ==================== NOTIFICATION PERMISSIONS ====================

  /// Check and request notification permission
  /// This is critical for FCM to work properly
  static Future<bool> checkNotificationPermission() async {
    return await _checkPermission(
      Permission.notification,
      permissionName: 'Notifications',
      openSettingsOnDenied: false,
    );
  }

  /// Request notification permission with option to open settings if denied
  static Future<bool> requestNotificationPermission({
    bool openSettingsOnDenied = false,
  }) async {
    return await _checkPermission(
      Permission.notification,
      permissionName: 'Notifications',
      openSettingsOnDenied: openSettingsOnDenied,
    );
  }

  // ==================== CAMERA & MEDIA PERMISSIONS ====================

  /// Check and request camera permission
  static Future<bool> checkCameraPermission() async {
    return await _checkPermission(Permission.camera, permissionName: 'Camera');
  }

  /// Check and request photo/gallery permission
  /// @Deprecated: DO NOT USE - Android Photo Picker handles permissions internally.
  /// Using this will cause Google Play Photo/Video Policy violation.
  /// The image_picker package uses Photo Picker which doesn't need these permissions.
  @Deprecated(
    'Photo Picker handles permissions internally - do not request photo permissions',
  )
  static Future<bool> checkGalleryPermission() async {
    // Return true to avoid breaking any code that might call this
    // But the actual permission is blocked in AndroidManifest.xml
    return true;
  }

  /// Check and request microphone permission
  static Future<bool> checkMicrophonePermission() async {
    return await _checkPermission(
      Permission.microphone,
      permissionName: 'Microphone',
    );
  }

  // ==================== STORAGE PERMISSIONS ====================

  /// Check and request file/manage external storage permission
  static Future<bool> checkFilePermission() async {
    return await _checkPermission(
      Permission.manageExternalStorage,
      permissionName: 'Manage External Storage',
    );
  }

  /// Check and request storage permission
  static Future<bool> checkStoragePermission() async {
    return await _checkPermission(
      Permission.storage,
      permissionName: 'Storage',
    );
  }

  // ==================== LOCATION PERMISSIONS ====================

  /// Check and request location permission (while using app)
  static Future<bool> checkLocationPermission() async {
    return await _checkPermission(
      Permission.location,
      permissionName: 'Location',
    );
  }

  /// Check and request location permission (always)
  static Future<bool> checkLocationAlwaysPermission() async {
    return await _checkPermission(
      Permission.locationAlways,
      permissionName: 'Location Always',
    );
  }

  // ==================== OTHER PERMISSIONS ====================

  /// Check and request bluetooth permission
  static Future<bool> checkBluetoothPermission() async {
    return await _checkPermission(
      Permission.bluetoothConnect,
      permissionName: 'Bluetooth',
    );
  }

  /// Check and request contacts permission
  static Future<bool> checkContactsPermission() async {
    return await _checkPermission(
      Permission.contacts,
      permissionName: 'Contacts',
    );
  }

  /// Check and request calendar permission
  static Future<bool> checkCalendarPermission() async {
    return await _checkPermission(
      Permission.calendar,
      permissionName: 'Calendar',
    );
  }

  // ==================== UTILITY METHODS ====================

  /// Open app settings for user to manually enable permissions
  static Future<bool> openSettings() async {
    try {
      cprint('📱 Opening app settings');
      return await openAppSettings();
    } catch (e) {
      cprint('❌ Error opening app settings: ${e.toString()}');
      return false;
    }
  }

  /// Check multiple permissions at once
  static Future<Map<Permission, bool>> checkMultiplePermissions(
    List<Permission> permissions,
  ) async {
    final Map<Permission, bool> results = {};
    for (final permission in permissions) {
      results[permission] = await _checkPermission(permission);
    }
    return results;
  }

  /// Request multiple permissions at once
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    try {
      cprint('📤 Requesting multiple permissions: ${permissions.length}');
      return await permissions.request();
    } catch (e) {
      cprint('❌ Error requesting multiple permissions: ${e.toString()}');
      return {};
    }
  }
}
