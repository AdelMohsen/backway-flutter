import 'package:greenhub/core/shared/cache/shared_helper.dart';
import 'package:rxdart/rxdart.dart';
import '../../../features/user/entity/user_entity.dart';
import '../../services/fcm_notification/fcm_notification_service.dart';
import '../../translation/all_translation.dart';
import '../../utils/utility.dart';

class MainAppBloc {
  final lang = BehaviorSubject<String>();
  final shared = SharedHelper();

  Function(String) get updateLang => lang.sink.add;
  Stream<String> get langStream => lang.stream.asBroadcastStream();

  String? _globalToken;
  UserEntity? _globalUserData;

  String get globalLang => allTranslations.currentLanguage;
  bool get isArabic => globalLang == 'ar';
  bool get isEnglish => globalLang == 'en';
  bool get isFrench => globalLang == 'fr';

  // Setters for global token and user data
  set setGlobalToken(String? token) => _globalToken = token;
  set setGlobalUserData(UserEntity? user) => _globalUserData = user;

  String? get globalToken => _globalToken;
  UserEntity? get globalUserData => _globalUserData;

  void dispose() {
    lang.close();
  }

  Future<void> getShared() async {
    String lang = await allTranslations.getPreferredLanguage();

    // Only set language if one exists and is valid
    // Don't set default for first-time users - let ChoiceScreen handle it
    if (lang.isNotEmpty && ['en', 'ar', 'fr'].contains(lang)) {
      await setLanguage(lang);
      cprint('Preferred Language: $lang');
    } else {
      cprint('No language set yet - first time user');
    }
  }

  Future<void> setLanguage(String newLanguage) async {
    await allTranslations.setPreferredLanguage(
      newLanguage,
    ); // Save the new language
    updateLang(newLanguage);
    await allTranslations.setNewLanguage(newLanguage); // Apply language change

    // Update FCM promotion topic subscription based on new language
    try {
      // await FCMNotificationService.instance.updatePromotionTopicForLanguage();
    } catch (e) {
      cprint('Error updating FCM promotion topic on language change: $e');
    }
  }
}

// Singleton instance of MainAppBloc
MainAppBloc mainAppBloc = MainAppBloc();
