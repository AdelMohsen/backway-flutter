import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../features/user/logic/user_cubit.dart';
import '../app_core.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';
import '../services/toast/toast_service.dart';
import '../shared/blocs/main_app_bloc.dart';
import '../shared/cache/cache_methods.dart';
import 'constant/app_strings.dart';
import 'extensions/extensions.dart';

void cprint(dynamic data, {String? errorIn, String? event, String? label}) {
  if (kDebugMode) {
    if (errorIn != null) {
      developer.log(
        '****************************** error ******************************',
      );
      developer.log(
        '[${label ?? "Error"}]',
        time: DateTime.now(),
        error: data.toString(),
        name: errorIn,
      );
      developer.log(
        '****************************** error ******************************',
      );
    } else if (data != null) {
      developer.log(
        data.toString(),
        time: DateTime.now(),
        name: label ?? 'Log',
      );
    }
    if (event != null) {
      Utility.logEvent(event, parameter: {});
    }
  }
}

bool checkFromArray(dynamic myArray) {
  if (myArray != null && myArray is List && myArray.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

bool checkFromMap(dynamic myMap) {
  if (myMap != null &&
      (myMap is Map || myMap is Map<String, dynamic>) &&
      myMap.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

class Utility {
  static void logEvent(String event, {Map<String, dynamic>? parameter}) {
    kReleaseMode ? developer.log('message') : cprint('[EVENT]: $event');
  }

  static void debugLog(String log, {dynamic param = ''}) {
    final String time = DateFormat('mm:ss:mmm').format(DateTime.now());
    cprint('[$time][Log]: $log, $param');
  }

  static void formatDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds.remainder(60);
    final String formattedDuration = '$minutes:$seconds';
    cprint('========> Formatted Duration $formattedDuration');
  }

  static bool isUserLoggedIn() {
    return mainAppBloc.globalToken != null &&
        mainAppBloc.globalToken!.isNotEmpty;
  }

  static Future<void> logout({BuildContext? context}) async {
    await CacheMethods.clearCachedLogin();
    if (context != null) {
      context.read<UserCubit>().clearUser();
      CustomNavigator.push(Routes.REGISTER_OR_LOGIN, clean: true);
    } else {
      if (CustomNavigator.context.mounted) {
        CustomNavigator.context.read<UserCubit>().clearUser();
      }
      CustomNavigator.push(Routes.REGISTER_OR_LOGIN, clean: true);
    }
  }

  static Color hexToColor(String hexString) {
    hexString = hexString.replaceAll('#', '');

    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }

    int hexColor = int.parse(hexString, radix: 16);

    return Color(hexColor);
  }

  static List<Color> generateGradientColors(Color baseColor, {int steps = 5}) {
    List<Color> gradientColors = [];

    final Color lighterColor = Color.lerp(baseColor, Colors.white, 0.6)!;
    final Color darkerColor = Color.lerp(baseColor, Colors.black, 0.3)!;

    for (int i = 0; i < steps; i++) {
      double factor = i / (steps - 1);
      final Color gradientColor = Color.lerp(
        darkerColor,
        lighterColor,
        factor,
      )!;
      gradientColors.add(gradientColor);
    }

    return gradientColors.reversed.toList();
  }

  static String getOrdinalSuffix(int number) {
    if (number < 1) return ''; // Ensure the number is valid
    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
  // static Future<void> shareApp({required String details}) async {
  //   await Share.share(
  //     '${AppConfig.BASE_URL_SHARE}$details',
  //     sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 0),
  //   );
  // }

  //   static Future<void> shareApp(String shareLink) async {
  //     await Share.share('Check out this app: $shareLink');
  //   }

  //   static Future<void> copyClipboard(String text) async {
  //     final data = await Clipboard.setData(ClipboardData(text: text));
  //     showSuccessSnackBar('Copied to clipboard'.tr);
  //   }

  //   static Future<dynamic> zoomInImage(String url) {
  //     return CustomNavigator.push(Routes.ZOOM_IN_IMAGE, extra: url);
  //   }

  //   static Future<dynamic> zoomInVideo(String url) {
  //  //   return CustomNavigator.push(Routes.ZOOM_IN_VIDEO, extra: url);
  //   }
}
