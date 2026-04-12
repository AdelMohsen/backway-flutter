import 'package:flutter/material.dart';
import 'package:greenhub/core/utils/utility.dart';
import 'app_router.dart';

/// CustomNavigator provides a backwards-compatible navigation interface that uses go_router internally
abstract class CustomNavigator {
  /// Global key for the app's navigator state
  static final GlobalKey<NavigatorState> navigatorState = navigatorKey;

  /// Current context from the navigator state - will throw an error if accessed too early
  static BuildContext get context {
    if (navigatorState.currentContext == null) {
      cprint(
        'WARNING: Trying to access CustomNavigator.context before it is initialized!',
      );
    }
    return navigatorState.currentContext!;
  }

  /// Safely get context with null check
  static BuildContext? get safeContext {
    try {
      return navigatorState.currentContext;
    } catch (e) {
      cprint('Error accessing navigator context: $e');
      return null;
    }
  }

  /// Check if navigation is currently possible
  static bool get canNavigate {
    return safeContext != null;
  }

  /// Route observer for analytics or other navigation tracking
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  /// Global key for scaffold messenger state
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();

  /// Global key for scaffold state
  static final GlobalKey<ScaffoldState> scaffoldState =
      GlobalKey<ScaffoldState>();

  /// Navigate back from the current screen
  static void pop({dynamic result}) {
    if (appRouter.canPop()) {
      appRouter.pop(result);
    }
  }

  /// Navigate to a new screen
  static Future<Object?> push(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    dynamic extra,
    bool replace = false,
    bool clean = false,
  }) {
    cprint('Route==> $routeName');

    if (clean == true) {
      appRouter.goNamed(
        routeName,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
        extra: extra,
      );
      return Future.value(null);
    }

    if (replace == true) {
      appRouter.replaceNamed(
        routeName,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
        extra: extra,
      );
      return Future.value(null);
    }

    return appRouter.pushNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  // ---------------------------------------------------------------------------
  // ✅ NEW METHODS (IMPORTANT FOR OTP FLOW)
  // ---------------------------------------------------------------------------

  /// Replace current screen (used for Register → OTP)
  static Future<void> pushReplacement(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    dynamic extra,
  }) async {
    cprint('Route (replace) ==> $routeName');

    appRouter.replaceNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// Clear navigation stack and navigate (used after OTP success)
  static Future<void> pushAndRemoveUntil(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    dynamic extra,
  }) async {
    cprint('Route (clean all) ==> $routeName');

    appRouter.goNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// Prevent back navigation (useful for OTP screen)
  static Widget blockBackNavigation({required Widget child}) {
    return WillPopScope(onWillPop: () async => false, child: child);
  }

  /// Backwards compatibility stub
  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('This route is not supported anymore')),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// OTP PARAMS (UNCHANGED)
// ---------------------------------------------------------------------------

class OtpParams {
  final String phone;
  final bool isFromRegistration;
  final bool isUserLogin;
  final bool isForgetPassword;

  OtpParams({
    required this.phone,
    required this.isFromRegistration,
    required this.isUserLogin,
    required this.isForgetPassword,
  });
}
