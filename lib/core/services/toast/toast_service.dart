import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_svg/svg.dart';
import '../../assets/app_svg.dart';
import '../../shared/entity/error_entity.dart';
import '../../theme/colors/styles.dart';
import '../../theme/text_styles/text_styles.dart';

class ToastService {
  /// Initialize the toast service - call this in your main widget
  static void initialize(BuildContext context) {
    try {
      InteractiveToast.initializeOverlayState(Overlay.of(context));
    } catch (e) {
      debugPrint('ToastService Initialize Error: $e');
    }
  }

  static void showSuccess(String message, BuildContext context) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.bodySmMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        trailing: const Icon(Icons.check_circle, color: Colors.white, size: 20),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 400),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: AppColors.primaryGreenHub,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreenHub.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showError(String message, BuildContext context) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.bodySmMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 600),
          displayDuration: Duration(seconds: 4),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          progressBarHeight: 4,
        ),
        toastStyle: ToastStyle(
          backgroundColor: const Color(0xFFE53E3E),
          borderRadius: BorderRadius.circular(16),
          progressBarColor: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53E3E).withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showWarning(String message, BuildContext context) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.bodySmMedium.copyWith(color: Colors.white),
        ),
        trailing: const Icon(Icons.warning, color: Colors.white, size: 20),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 400),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showInfo(String message, BuildContext context) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.bodySmMedium.copyWith(color: Colors.white),
        ),
        trailing: const Icon(Icons.info, color: Colors.white, size: 20),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 400),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: AppColors.kPrimary,
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimary.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  /// Glassy toast with blur effect
  static void showGlassy(String message, BuildContext context) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.bodySmMedium.copyWith(color: Colors.white),
        ),
        trailing: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 500),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          progressBarHeight: 3,
        ),
        toastStyle: const ToastStyle(
          glassBlur: 8,
          backgroundColorOpacity: 0.2,
          backgroundColor: AppColors.kPrimary,
          progressBarColor: Colors.white,
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  /// Shows a glassy error toast with blur effect
  static void showGlassyError(String message, BuildContext context) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.bodySmMedium.copyWith(color: Colors.white),
        ),
        trailing: const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 20,
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 500),
          displayDuration: Duration(seconds: 4),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          progressBarHeight: 3,
        ),
        toastStyle: const ToastStyle(
          glassBlur: 8,
          backgroundColorOpacity: 0.3,
          backgroundColor: Colors.red,
          progressBarColor: Colors.white,
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showCustom({
    required String message,
    required BuildContext context,
    required ToastStatusType toastStatusType,
    ErrorEntity? errorEntity,
    Color backgroundColor = Colors.white,
    Duration displayDuration = const Duration(seconds: 3),
  }) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Row(
          children: [
            Container(color: AppColors.gradientBurble, height: 80, width: 8),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 16,
                bottom: 16,
                end: 12,
                start: 16,
              ),
              // child: SvgPicture.asset(icon, height: 48, width: 48),
            ),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySmMedium.copyWith(
                  color: const Color.fromRGBO(46, 46, 46, 1),
                  fontSize: 13,
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        toastSetting: SlidingToastSetting(
          animationDuration: const Duration(milliseconds: 400),
          displayDuration: displayDuration,
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          padding: EdgeInsets.zero,
        ),
        toastStyle: ToastStyle(
          backgroundColor: AppColors.kPrimary,
          padding: EdgeInsets.zero,
          progressBarColor: AppColors.kPrimary,
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  /// Close all active toasts
  static void closeAll() {
    try {
      InteractiveToast.closeAllToast();
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }
}

enum ToastStatusType { success, error, warning, info, alarm }
