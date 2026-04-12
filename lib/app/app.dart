import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../core/app_config/app_config.dart';
import '../core/app_config/flavour.dart';
import '../core/app_config/providers.dart';
import '../core/assets/app_images.dart';
import '../core/navigation/app_router.dart';
import '../core/navigation/custom_navigation.dart';
import '../core/shared/blocs/main_app_bloc.dart';
import '../core/theme/colors/styles.dart';
import '../core/theme/text_styles/text_styles.dart';
import '../core/translation/all_translation.dart';
import '../core/translation/translations.dart';
import '../core/utils/constant/app_strings.dart';
import '../core/utils/extensions/extensions.dart';

/// Global overlay context for in-app notifications
BuildContext? globalOverlayContext;

class MyApp extends StatelessWidget {
  // Global navigator key for deep linking
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ProviderList.providers,
      child: StreamBuilder<String>(
        stream: mainAppBloc.langStream,
        builder: (context, lang) {
          // Wrap the MaterialApp with our notification service initializer
          return GlobalLoaderOverlay(
            overlayWidgetBuilder: (progress) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity),
                  Text(
                    AppStrings.loading.tr,
                    style: AppTextStyles.bodySmMedium.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            child: Builder(
              builder: (context) {
                return MaterialApp.router(
                  routerConfig: appRouter,
                  debugShowCheckedModeBanner:
                      Flavour.appFlavor == FlavorEnum.STAGING,
                  scaffoldMessengerKey: CustomNavigator.scaffoldMessengerState,
                  locale: Locale(allTranslations.currentLanguage),
                  supportedLocales: allTranslations.supportedLocales(),
                  localizationsDelegates: const [
                    TranslationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  title: AppConfig.appName,
                  theme: ThemeData(
                    pageTransitionsTheme: const PageTransitionsTheme(
                      builders: {
                        TargetPlatform.android: ZoomPageTransitionsBuilder(),
                        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                      },
                    ),
                    appBarTheme: const AppBarTheme(
                      surfaceTintColor: AppColors.transparent,
                    ),
                  ),
                  // Builder to provide overlay context for in-app notifications
                  builder: (context, child) {
                    // Store the overlay context globally
                    globalOverlayContext = context;
                    return child ?? const SizedBox.shrink();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
