import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:greenhub/core/theme/colors/styles.dart';

/// Custom toast utility class using toastification package with animated appearances
class CustomToast {
  CustomToast._();

  /// Shows a success toast with green color and check icon
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
    Alignment? alignment,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,

      style: ToastificationStyle.flatColored,
      title: title != null ? Text(title) : null,
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      primaryColor: ColorsApp.kPrimary,
      backgroundColor: ColorsApp.kPrimary.withValues(alpha: 0.1),
      foregroundColor: ColorsApp.kPrimary,
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: ColorsApp.kPrimary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryGreenHub.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Shows an error toast with red color and error icon
  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
    Alignment? alignment,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: title != null ? Text(title) : null,
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      primaryColor: ColorsApp.kPrimary,
      backgroundColor: ColorsApp.kPrimary.withValues(alpha: 0.1),
      foregroundColor: ColorsApp.kPrimary,
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: ColorsApp.kPrimary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 16),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.kRed.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Shows a warning toast with orange/yellow color and warning icon
  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
    Alignment? alignment,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      title: title != null ? Text(title) : null,
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      primaryColor: AppColors.kDarkYellow,
      backgroundColor: AppColors.kDarkYellow.withValues(alpha: 0.1),
      foregroundColor: AppColors.kDarkYellow,
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColors.kDarkYellow,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.kDarkYellow.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Shows an info toast with blue color and info icon
  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
    Alignment? alignment,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      title: title != null ? Text(title) : null,
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      primaryColor: const Color(0xFF2196F3),
      backgroundColor: const Color(0xFF2196F3).withValues(alpha: 0.1),
      foregroundColor: const Color(0xFF2196F3),
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color(0xFF2196F3),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.info_outline, color: Colors.white, size: 16),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF2196F3).withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Dismiss all toasts
  static void dismissAll() {
    toastification.dismissAll();
  }
}
