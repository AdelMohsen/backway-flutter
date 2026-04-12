import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'navigation/custom_navigation.dart';

import 'shared/entity/error_entity.dart';
import 'shared/widgets/custom_images.dart';
import 'theme/colors/styles.dart';
import 'utils/utility.dart';
import 'app_notification.dart';

class AppCore {
  static AppCore? _instance;

  AppCore._initial();

  factory AppCore() {
    _instance ??= AppCore._initial();
    return _instance!;
  }

  static bool scrollListener(
    ScrollController controller,
    int maxPage,
    int currentPage,
  ) {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (maxScroll == currentScroll && maxScroll != 0.0) {
      cprint('>>>>>>>>>>>>>>> get into equal scroll');
      cprint('$maxScroll   $currentScroll');
      if (currentPage < maxPage) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static void showSnackBar({required AppNotification notification}) {
    Timer(const Duration(milliseconds: 200), () {
      CustomNavigator.scaffoldMessengerState.currentState!.showSnackBar(
        SnackBar(
          behavior: notification.isFloating
              ? SnackBarBehavior.floating
              : SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(notification.radius),
            side: BorderSide(width: 1, color: notification.borderColor),
          ),
          margin: notification.isFloating ? const EdgeInsets.all(24) : null,
          content: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (notification.iconName != null)
                    customImageIconSVG(
                      imageName: notification.iconName,
                      color: Colors.white,
                    ),
                  if (notification.iconName != null) const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      notification.message,
                      // style: AppTextStyles.w600.copyWith(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: notification.backgroundColor,
        ),
      );
    });
  }
}

void showErrorSnackBar(message, {ErrorEntity? error}) {
  AppCore.showSnackBar(
    notification: AppNotification(
      message: message.toString(),
      backgroundColor: AppColors.kRed,
      borderColor: AppColors.kRed,
      iconName: 'circluer_delete_icon',
      isFloating: true,
    ),
  );
}

void showSuccessSnackBar(message) {
  AppCore.showSnackBar(
    notification: AppNotification(
      message: message.toString(),
      backgroundColor: AppColors.gradientBlue,
      borderColor: AppColors.gradientBlue,
      isFloating: true,
    ),
  );
}

void showToast(String? message, [ToastGravity? gravity]) {
  Fluttertoast.showToast(
    backgroundColor: AppColors.kBlack.withOpacity(0.8),
    textColor: Colors.white,
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 2,
    gravity: gravity ?? ToastGravity.TOP,
  );
}

void showErrorToast(String? message, [ToastGravity? gravity]) {
  Fluttertoast.showToast(
    backgroundColor: Colors.red,
    textColor: Colors.white,
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 3,
    gravity: gravity ?? ToastGravity.TOP,
  );
}

void showSuccessToast(String? message, [ToastGravity? gravity]) {
  if (message != null && message.isNotEmpty) {
    Fluttertoast.showToast(
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      gravity: gravity ?? ToastGravity.TOP,
    );
  }
}
