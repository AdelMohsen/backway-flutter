import 'package:hive_flutter/hive_flutter.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../../translation/all_translation.dart';
import '../../utils/enums/enums.dart';
import 'secure_storage.dart';

class CachingKey extends Enum<String> {
  const CachingKey(super.val);
  static const CachingKey USER = CachingKey('USER');
  static const CachingKey TOKEN = CachingKey('REAL_TOKEN');
  static const CachingKey LANG = CachingKey('LANG');
  static const CachingKey IS_LOGIN = CachingKey('IS_LOGIN');
  static const CachingKey IS_ON_BOARDING_SHOWN = CachingKey(
    'IS_ON_BOARDING_SHOWN',
  );
  static const CachingKey NOTIFICATION_PERMISSION_ASKED = CachingKey(
    'NOTIFICATION_PERMISSION_ASKED',
  );
  static const CachingKey NOTIFICATION_PERMISSION_GRANTED = CachingKey(
    'NOTIFICATION_PERMISSION_GRANTED',
  );
}

class SharedHelper {
  static SharedHelper? sharedHelper;
  static Box? box;

  static Future<void> init() async {
    if (box == null) {
      await Hive.initFlutter();
      box = await Hive.openBox('testBox');
      sharedHelper = SharedHelper();
    }
  }

  Future<void> clear() async {
    await box?.clear();
  }

  //-----------------------------OTHERS OPERATIONS-------------------------------\\

  Future<void> changeLanguage(String lang) async {
    await allTranslations.setNewLanguage(lang, true);
    await allTranslations.setPreferredLanguage(lang);
    await SecureStorageService().write(key: CachingKey.LANG.value, value: lang);
  }

  Future<void> logout() async {
    await clear();
    final currentLang = await allTranslations.getPreferredLanguage();
    await SecureStorageService().write(
      key: CachingKey.IS_LOGIN.value,
      value: 'false',
    );
    await changeLanguage(currentLang);
    CustomNavigator.push(Routes.SPLASH, replace: true);
  }

  Future<void> writeData(CachingKey key, dynamic value) async {
    await SecureStorageService().write(key: key.value, value: value);
  }

  Future<bool> readBoolean(CachingKey key) async =>
      box?.get(key.value) ?? false;

  Future<double> readDouble(CachingKey key) async => box?.get(key.value) ?? 0.0;

  Future<int> readInteger(CachingKey key) async => box?.get(key.value) ?? 0;

  Future<String> readString(CachingKey key) async => box?.get(key.value) ?? '';
  Future<void> removeData(CachingKey key) async {
    await box?.delete(key.value);
  }
}
