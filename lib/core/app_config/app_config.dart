import 'package:flutter/material.dart';

class AppConfig {
  // static const LOCALE = 'https://2f04-197-61-38-60.eu.ngrok.io/api/v1/';
  static String appName = 'ShipHub';
  static String BASE_URL = 'https://greenhub.sa-fvs.com/api/v1';
  static String BASE_URL_STAGING = 'https://greenhub.sa-fvs.com/api/v1';
  static String BASE_URL_PRODUCTION = 'https://greenhub.sa-fvs.com/api/v1';

  static const BASE_URL_SHARE = 'https://greenhub.sa-fvs.com/api/details/';

  static const SHA1_DEBUG =
      'D5:FD:7C:36:92:0C:8C:47:22:E8:96:CD:54:D0:D0:ED:DB:3E:52:DA';
  static const SHA1_RELEASE =
      '96:8C:36:33:86:9B:E1:13:10:46:79:0E:F7:BB:5F:BF:0B:FB:45:5C';
  static const SHA1_PROFILE =
      'D5:FD:7C:36:92:0C:8C:47:22:E8:96:CD:54:D0:D0:ED:DB:3E:52:DA';
  static const SHA256_DEBUG =
      'B3:E0:C7:A8:3B:22:06:27:69:01:16:F8:5C:7E:0A:D2:65:DC:B1:32:EB:8F:25:81:23:1F:87:FD:F5:13:A6:FB';
  static const SHA256_RELEASE =
      '59:D3:7A:D9:88:DC:4E:A0:6E:1C:70:56:30:58:69:51:55:0E:1D:44:81:79:14:81:59:77:5C:48:33:6F:3A:E8';

  static const ANDROID_CLIENT_ID = '';
  static const IOS_CLIENT_ID = '';

  static const APP_LINK = '';

  static const PUSHER_APP_ID = '2128028';
  static const PUSHER_API_KEY = '421f0d0824504886ac64';
  static const PUSHER_API_CLUSTER = 'ap2';
  static const PUSHER_AUTH_ENDPOINT = 'https://greenhub.sa-fvs.com/';

  static const int maximunNumberOfQuestions = 36;
  static const ScrollPhysics appPhysics = BouncingScrollPhysics();

  static String APP_DEEP_LINK_JOIN_ROOM(String gameCode) =>
      'barq://app/join-room/$gameCode';

  static const countryCode = '966';
}
