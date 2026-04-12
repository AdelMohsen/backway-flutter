import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/shared/cache/shared_helper.dart';
import 'package:greenhub/firebase_options.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../core/services/fcm_notification/fcm_integration_helper.dart';
import '../core/services/observable/bloc_observer.dart';
import '../core/shared/blocs/main_app_bloc.dart';
import '../core/translation/all_translation.dart';
import '../core/utils/utility.dart';

/// Firebase Analytics instance

/// Initialize all components that don't need a BuildContext
Future<void> initMainFunction() async {
  Bloc.observer = BlocObserverService();
  HttpOverrides.global = MyHttpOverrides();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    cprint('[Firebase] Core initialized');
  } catch (e) {
    cprint('[Firebase] Core error: $e');
  }

  // This ensures foreground notifications work regardless of permission state
  try {
    cprint('[FCM] Initializing FCM service...');
    await FCMIntegrationHelper.initializeFCM();

    // Get token for logging
    final fcmToken = FCMIntegrationHelper.getFCMToken();
    cprint(
      '[FCM] Token: ${fcmToken != null ? '${fcmToken.substring(0, 20)}...' : 'NULL'}',
    );
  } catch (e) {
    cprint('[FCM] Error initializing: $e');
  }

  try {
    await SharedHelper.init();
  } catch (e) {
    cprint(e.toString());
  }
  try {
    await allTranslations.init();
  } catch (e) {
    cprint(e.toString());
  }
  try {} catch (e) {
    cprint(e.toString());
  }
  Bloc.observer = BlocObserverService();
  HttpOverrides.global = MyHttpOverrides();
  try {
    mainAppBloc.getShared();
  } catch (e) {
    cprint(e.toString());
  }

  // Initialize timeago Arabic locale
  try {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    cprint('✅ Timeago Arabic locale initialized');
  } catch (e) {
    cprint('❌ Error initializing timeago Arabic locale: ${e.toString()}');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
