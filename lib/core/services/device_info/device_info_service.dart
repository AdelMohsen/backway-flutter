import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'deivce_info_entity.dart';

class DeviceInfoService {
  static Future<DeviceInfoEntity> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = 'Unknown';
    String platform = 'Unknown';
    String? brand;
    String? model;
    String? systemVersion;
    int? sdkVersion;

    try {
      if (kIsWeb) {
        platform = 'Web';
        deviceName = 'Web Browser';
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
        brand = androidInfo.brand;
        model = androidInfo.model;
        platform = 'Android';
        sdkVersion = androidInfo.version.sdkInt;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.name;
        model = iosInfo.model;
        platform = 'iOS';
        systemVersion = iosInfo.systemVersion;
      } else if (Platform.isLinux) {
        platform = 'Linux';
      } else if (Platform.isMacOS) {
        platform = 'MacOS';
      } else if (Platform.isWindows) {
        platform = 'Windows';
      }
    } on PlatformException {
      // Handle exception - you might want to return default values or throw
      platform = 'Error getting platform info';
    }

    // Get device language
    final language =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    return DeviceInfoEntity(
      deviceName: deviceName,
      platform: platform,
      language: language,
      brand: brand,
      model: model,
      systemVersion: systemVersion,
      sdkVersion: sdkVersion,
    );
  }
}
