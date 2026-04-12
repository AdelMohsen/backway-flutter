import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenhub/core/shared/cache/shared_helper.dart';

import '../navigation/custom_navigation.dart';

class MapHelper {
  static MapHelper? instance;
  static SharedHelper? preference;

  MapHelper._initial();
  // static Position? currentLocation;

  factory MapHelper() {
    if (instance == null) {
      instance = MapHelper._initial();
      preference = SharedHelper();
    } else {
      // log('LOCATION IS NOT NULL AND HAS VALUE');
    }
    return instance!;
  }
  static void showCustomDialog({bool isSplash = true}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) => CupertinoAlertDialog(
        title: const Text(
          'Location permission denied, please allow your location permission for WIKI .',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () async {
              CustomNavigator.pop();
              // AppSettings.openLocationSettings(asAnotherTask: true);
              AppSettings.openAppSettings(
                asAnotherTask: true,
                type: AppSettingsType.location,
              );
            },
          ),
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () async {
              CustomNavigator.pop();
              // SplashBloc.instance.add(Click());
            },
          ),
        ],
      ),
    );
  }

  // static getLocation({bool isSplash = true}) async {
  //   double lat = await preference!.readDouble(CachingKey.USER_LAT);
  //   double long = await preference!.readDouble(CachingKey.USER_LONG);
  //   try {
  //     if (currentLocation == null) {
  //       // log('Step 1');
  //       currentLocation = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //     } else {
  //       // log('Step 2');
  //       // log('LOCATION IS NOT NULL AND HAS VALUE is mocked: ${currentLocation!.isMocked}');
  //     }
  //     // print('<<<<<<<<<<<<<<<< Get Current Location  >>>>>>>>>>>>>>>>>');
  //     preference!.writeData(CachingKey.CHECK_LOCATION, true);
  //     preference!.writeData(CachingKey.USER_LAT, currentLocation!.latitude);
  //     preference!.writeData(CachingKey.USER_LONG, currentLocation!.longitude);
  //     String address = await formatLatLng(
  //         latLng:
  //             LatLng(currentLocation!.latitude, currentLocation!.longitude));
  //     preference!.writeData(CachingKey.ADDRESS, address);
  //     bool isLogin = await preference!.readBoolean(CachingKey.IS_LOGIN);
  //     if (isLogin) {
  //       UserBloc.instance.add(Update());
  //     }
  //     // print('<<<<<<<<<<<<<<<< Current Location Data $lat  $long  >>>>>>>>>>>>>>>>>');
  //   } catch (e) {
  //     // print('<<<<<<<<<<<<<<<< Exception For Location ${e.toString()} >>>>>>>>>>>>>>>>>');
  //   }
  // }

  // static Future<Position> getCurrentLocation() async {
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // static Future<String> formatLatLng({required LatLng latLng}) async {
  //   // log('${latLng.latitude}/${latLng.longitude}');
  //   List<Placemark> placeMarks =
  //       await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  //   Placemark place = placeMarks[0];
  //   List<String> address = [];
  //   // print(place.toJson());
  //   try {
  //     if (place.locality != '') {
  //       address.add(place.locality!);
  //     }
  //     address.add(place.subAdministrativeArea!);
  //     address.add(place.administrativeArea!);
  //     return "${place.name} ${address.toSet().join(",")}";
  //   } on FormatException {
  //     address.add(place.name ?? '');
  //     if (place.locality != '') {
  //       address.add(place.locality!);
  //     }

  //     address.add(place.subAdministrativeArea!);
  //     address.add(place.administrativeArea!);
  //     return address.toSet().join(',');
  //   }
  // }
}
