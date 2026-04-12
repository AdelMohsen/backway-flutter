import 'dart:convert';

import '../../../features/user/entity/user_entity.dart';
import '../../../features/user/model/user_model.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../utils/utility.dart';
import 'secure_storage.dart';
import 'shared_helper.dart';

class CacheMethods {
  static Future<void> saveToken(
    String token, {
    bool needToCacheToken = true,
  }) async {
    if (needToCacheToken) {
      try {
        await SecureStorageService.instance.write(
          key: CachingKey.TOKEN.value,
          value: token,
        );
        await getToken();
      } catch (e) {
        cprint('Error saving token: $e');
      }
    } else {
      mainAppBloc.setGlobalToken = token;
    }
  }

  static Future<void> saveUser(UserEntity user) async {
    try {
      await SecureStorageService.instance.write(
        key: CachingKey.USER.value,
        value: jsonEncode(user.toJson()),
      );
      await getUser();
    } catch (e) {
      cprint('Error saving user: $e');
    }
  }

  static Future<UserEntity?> getUser() async {
    try {
      final userJson = await SecureStorageService.instance.read(
        key: CachingKey.USER.value,
      );
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        final token = await getToken();
        // Wrap userData in 'data' key to match API response structure
        mainAppBloc.setGlobalUserData = UserModel.fromJson({
          'data': userData,
        }, token: token!);
        return mainAppBloc.globalUserData;
      }
      return null;
    } catch (e) {
      cprint('Error getting user: $e');
      return null;
    }
  }

  static Future<String?> getToken() async {
    try {
      mainAppBloc.setGlobalToken = await SecureStorageService.instance.read(
        key: CachingKey.TOKEN.value,
      );
      cprint('token: ${mainAppBloc.globalToken}');
      return mainAppBloc.globalToken;
    } catch (e) {
      cprint('Error getting token: $e');
      return null;
    }
  }

  static Future<void> saveOnBoarding() async {
    try {
      await SecureStorageService.instance.write(
        key: CachingKey.IS_ON_BOARDING_SHOWN.value,
        value: 'true',
      );
    } catch (e) {
      cprint('Error saving onboarding status: $e');
    }
  }

  static Future<bool> getOnBoarding() async {
    try {
      final result = await SecureStorageService.instance.read(
        key: CachingKey.IS_ON_BOARDING_SHOWN.value,
      );
      return result == 'true';
    } catch (e) {
      cprint('Error getting onboarding status: $e');
      return false;
    }
  }

  static Future<void> clearCachedLogin() async {
    try {
      await SecureStorageService.instance.delete(key: CachingKey.TOKEN.value);
      await SecureStorageService.instance.delete(key: CachingKey.USER.value);
      mainAppBloc.setGlobalToken = null;
      mainAppBloc.setGlobalUserData = null;
    } catch (e) {
      cprint('Error saving user clearCachedLogin: $e');
    }
  }
}
