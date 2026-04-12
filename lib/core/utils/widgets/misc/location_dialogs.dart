import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/app_confirmation_dialog.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/services/location/location_service.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';

class LocationDialogs {
  /// Show a dialog when location services are disabled
  static Future<void> showLocationDisabledDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AppConfirmationDialog(
        title: AppStrings.locationServiceDisabledTitle.tr,
        subtitle: AppStrings.locationServiceDisabledMessage.tr,
        confirmText: AppStrings.enableLocation.tr,
        cancelText: AppStrings.cancel.tr,
        confirmColor: AppColors.primaryGreenHub,
        iconPath: AppSvg.bell, // Reusing bell icon as a general alert icon
        onConfirm: () async {
          await LocationService().openLocationSettings();
        },
      ),
    );
  }

  /// Show a dialog when location permissions are denied
  static Future<void> showPermissionDeniedDialog(BuildContext context, {bool isPermanent = false}) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AppConfirmationDialog(
        title: AppStrings.locationFailed.tr,
        subtitle: isPermanent 
            ? "Location permission is permanently denied. Please enable it in app settings." 
            : "Location permission is required to use this feature.",
        confirmText: AppStrings.settings.tr,
        cancelText: AppStrings.cancel.tr,
        confirmColor: AppColors.primaryGreenHub,
        iconPath: AppSvg.bell,
        onConfirm: () async {
          if (isPermanent) {
            await LocationService().openAppSettings();
          } else {
             // For non-permanent, we could re-request here, but usually it's better to just open settings or instruct the user
             await LocationService().openAppSettings();
          }
        },
      ),
    );
  }
}
