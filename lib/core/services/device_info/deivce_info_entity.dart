import 'package:equatable/equatable.dart';

class DeviceInfoEntity extends Equatable {
  final String deviceName;
  final String platform;
  final String language;
  final String? brand; // Android only
  final String? model; // More detailed than deviceName
  final String? systemVersion; // iOS only
  final int? sdkVersion; // Android only

  const DeviceInfoEntity({
    required this.deviceName,
    required this.platform,
    required this.language,
    this.brand,
    this.model,
    this.systemVersion,
    this.sdkVersion,
  });

  @override
  String toString() {
    return 'DeviceInfo{deviceName: $deviceName, platform: $platform, language: $language, '
        'brand: $brand, model: $model, systemVersion: $systemVersion, sdkVersion: $sdkVersion}';
  }

  @override
  List<Object?> get props =>
      [deviceName, platform, language, brand, model, systemVersion, sdkVersion];
}
