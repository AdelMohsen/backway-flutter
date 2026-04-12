import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'app/init_main_functions.dart';
import 'core/app_config/app_config.dart';
import 'core/app_config/flavour.dart';
import 'core/translation/all_translation.dart';
import 'core/utils/utility.dart';
import 'core/utils/widgets/misc/restart_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flavour.appFlavor = FlavorEnum.PRODUCTION;
  AppConfig.BASE_URL = Flavour.appFlavor == FlavorEnum.STAGING
      ? AppConfig.BASE_URL_STAGING
      : AppConfig.BASE_URL_PRODUCTION;

  try {
    await initMainFunction();
  } catch (e) {
    cprint('❌ Error in initMainFunction: $e');
  }

  try {
    await allTranslations.init();

    final savedLang = await allTranslations.getPreferredLanguage();

    if (savedLang.isEmpty) {
      await allTranslations.setNewLanguage('ar');
      cprint('🟢 No language set yet - defaulting to Arabic');
    } else {
      await allTranslations.setNewLanguage(savedLang);
      cprint(
        '🌐 App language loaded from storage: ${allTranslations.currentLanguage}',
      );
    }
  } catch (e) {
    cprint('❌ Error initializing translations: $e');
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(RestartWidget(child: const MyApp()));
}
