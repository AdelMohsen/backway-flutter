import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:greenhub/app/app.dart';
import 'package:greenhub/features/auth/login/ui/pages/login_screen.dart';
import 'package:greenhub/features/onboarding/ui/pages/onboarding_screen.dart';
import 'package:greenhub/features/auth/register/ui/pages/register_screen.dart';
import 'package:greenhub/features/auth/resgister_or_login/ui/pages/register_or_login.dart';
import 'package:greenhub/features/choice_account/ui/pages/choice_account.dart';
import 'package:greenhub/features/choose_account/ui/pages/choose_account_screen.dart';

import 'package:greenhub/features/orders/ui/pages/order_screen.dart';
import 'package:greenhub/features/settings/ui/pages/app_settings_screen.dart';
import 'package:greenhub/features/splash/splash_screen.dart';
import 'package:greenhub/features/nav_layout/pages/custom_navbar_layout_screen.dart';
import 'package:greenhub/features/about/ui/pages/about_screen.dart';
import 'package:greenhub/features/contact_us/ui/pages/contact_us_screen.dart';
import 'package:greenhub/features/auth/verifycode/ui/pages/verify_code_screen.dart';
import 'package:greenhub/features/wallet/ui/pages/payment_details/payment_details_screen.dart';
import 'package:greenhub/features/recharge_balance/ui/pages/recharge_balance_screen.dart';
import 'package:greenhub/features/wallet/ui/pages/wallet/wallet_screen.dart';
import 'package:greenhub/features/address/data/models/address_model.dart';
import 'package:greenhub/features/address/ui/pages/address_screen.dart';
import 'package:greenhub/features/edit_address/ui/pages/edit_address_screen.dart';
import 'package:greenhub/features/add_address/ui/pages/add_address_screen.dart';
import 'package:greenhub/features/order_tracking/ui/pages/order_tracking_screen.dart';
import 'package:greenhub/features/order_tracking/logic/order_tracking_cubit.dart';
import 'package:greenhub/features/order_details/ui/pages/order_details.dart';
import 'package:greenhub/features/download_invoice/ui/pages/download_invoice_screen.dart';
import 'package:greenhub/features/messages/ui/pages/messages_screen.dart';
import 'package:greenhub/features/notification/logic/cubit/notification_cubit.dart';
import 'package:greenhub/features/notification/ui/pages/notifications_screen.dart';
import 'package:greenhub/features/negotiation_offers/ui/pages/negotiation_offers.dart';
import 'package:greenhub/features/choose_language/ui/pages/language_screen.dart';
import 'package:greenhub/features/file_complaint/ui/pages/file_complaint_screen.dart';
import 'package:greenhub/features/avalable_vechile/ui/pages/avalable_vechile_screen.dart';

import 'package:greenhub/features/auth/verifycode/data/params/verify_code_route_params.dart';
import 'package:greenhub/features/rate_negotiation/ui/pages/rate_negotiation_screen.dart';
import 'routes.dart';

/// Global key for navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Router configuration for the app
bool _isFirstLaunch = true;

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/splash',
  debugLogDiagnostics: true,

  redirect: (BuildContext context, GoRouterState state) {
    // During cold start with deep link, always show splash screen first
    if (_isFirstLaunch && state.uri.path != '/splash') {
      _isFirstLaunch = false;
      return '/splash';
    }
    _isFirstLaunch = false;
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      name: Routes.SPLASH,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: Routes.ON_BOARDING_SCREEN,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/choice_account',
      name: Routes.CHOICE_ACCOUNT,
      builder: (context, state) => const ChoiceAccount(),
    ),

    GoRoute(
      path: '/app',
      name: Routes.APP,
      builder: (context, state) => const MyApp(),
    ),

    GoRoute(
      path: '/register',
      name: Routes.REGISTER,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/choose_account',
      name: Routes.CHOOSE_ACCOUNT,
      builder: (context, state) => const ChooseAccountScreen(),
    ),

    GoRoute(
      path: '/register-or-login',
      name: Routes.REGISTER_OR_LOGIN,
      builder: (context, state) => const RegisterOrLogin(),
    ),
    GoRoute(
      path: '/LOGIN',
      name: Routes.LOGIN,
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/nav-layout',
      name: Routes.NAV_LAYOUT,
      builder: (context, state) {
        int? initialIndex;
        if (state.extra is int) {
          initialIndex = state.extra as int;
        } else if (state.extra is String) {
          if (state.extra == Routes.orders) {
            initialIndex = 3; // Orders tab
          }
        }
        return CustomNavbarLayoutScreen(initialIndex: initialIndex);
      },
    ),
    GoRoute(
      path: '/app-settings',
      name: Routes.APP_SETTINGS,
      builder: (context, state) => const AppSettingsScreen(),
    ),
    GoRoute(
      path: '/about',
      name: Routes.ABOUT,
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/contact-us',
      name: Routes.CONTACT_US,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: '/wallet',
      name: Routes.WALLET,
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: '/recharge',
      name: Routes.RECHARGE,
      builder: (context, state) => const RechargeBalanceScreen(),
    ),
    GoRoute(
      path: '/payment',
      name: Routes.PAYMENT,
      builder: (context, state) => const PaymentDetailsScreen(),
    ),
    GoRoute(
      path: '/verify-code',
      name: Routes.VERIFY_CODE,
      builder: (context, state) {
        final params = state.extra as VerifyCodeRouteParams;
        return VerifyCodeScreen(params: params);
      },
    ),
    GoRoute(
      path: '/address',
      name: Routes.ADDRESS,
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: '/edit-address',
      name: Routes.EDIT_ADDRESS,
      builder: (context, state) =>
          EditAddressScreen(address: state.extra as AddressModel),
    ),
    GoRoute(
      path: '/add-address',
      name: Routes.ADD_ADDRESS,
      builder: (context, state) => const AddAddressScreen(),
    ),
    GoRoute(
      path: '/orders',
      name: Routes.orders,
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: '/order-tracking/:orderId',
      name: Routes.ORDER_TRACKING,
      builder: (context, state) {
        final orderIdStr = state.pathParameters['orderId'] ?? '0';
        final orderId = int.tryParse(orderIdStr) ?? 0;
        return BlocProvider(
          create: (context) => OrderTrackingCubit(),
          // `OrderTrackingScreen` already calls `loadOrderTracking` in `build`,
          // or we can call it here instead of inside the screen's build method.
          // Since the screen calls it if orderId is not null, we don't need to call it here to avoid duplicate calls.
          child: OrderTrackingScreen(orderId: orderId),
        );
      },
    ),
    GoRoute(
      path: '/order-details',
      name: Routes.ORDER_DETAILS,
      builder: (context, state) {
        int? orderId;
        if (state.extra is int) {
          orderId = state.extra as int;
        } else if (state.extra is String) {
          orderId = int.tryParse(state.extra as String);
        } else if (state.pathParameters.containsKey('orderId')) {
          orderId = int.tryParse(state.pathParameters['orderId'] ?? '');
        }
        return OrderDetailsScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/download-invoice',
      name: Routes.DOWNLOAD_INVOICE,
      builder: (context, state) {
        int orderId = 0;
        if (state.extra is int) {
          orderId = state.extra as int;
        } else if (state.extra is String) {
          orderId = int.tryParse(state.extra as String) ?? 0;
        }
        return DownloadInvoiceScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/messages',
      name: Routes.MESSAGES,
      builder: (context, state) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/negotiation-offers',
      name: Routes.NEGOTIATION_OFFERS,
      builder: (context, state) {
        int orderId = 0;
        if (state.extra is int) {
          orderId = state.extra as int;
        } else if (state.extra is String) {
          orderId = int.tryParse(state.extra as String) ?? 0;
        }
        return NegotiationOffersScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/language',
      name: Routes.LANGUAGE,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: '/file-complaint',
      name: Routes.FILE_COMPLAINT,
      builder: (context, state) => const FileComplaintScreen(),
    ),
    GoRoute(
      path: '/not-found',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Page not found'))),
    ),
    GoRoute(
      path: '/rate-negotiation',
      name: Routes.RATE_NEGOTIATION,
      builder: (context, state) {
        final orderId = state.extra as int?;
        return RateNegotiationScreen(orderId: orderId ?? 0);
      },
    ),
    GoRoute(
      path: '/notifications',
      name: Routes.NOTIFICATIONS,
      builder: (context, state) => BlocProvider(
        create: (context) => NotificationCubit()..getNotifications(),
        child: const NotificationsScreen(),
      ),
    ),
    GoRoute(
      path: '/avalable_vechile',
      name: Routes.AVALABLE_VECHILE,
      builder: (context, state) => const AvailableVehicleScreen(),
    ),
  ],

  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Error page handling: page not found')),
  ),
);
