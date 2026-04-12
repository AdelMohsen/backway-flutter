import 'package:flutter/material.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../../utils/utility.dart';
import 'local_notification_service.dart';
import 'models/notification_model.dart';
import 'notification_types.dart';

class FCMNotificationHandler {
  /// Handle notification based on type and action
  static void handleNotification(
    NotificationModel notification, {
    bool showInApp = true,
    bool shouldNavigate = false,
  }) {
    cprint('[FCM Handler] ===== HANDLING NOTIFICATION =====');
    cprint(
      '[FCM Handler] showInApp: $showInApp, shouldNavigate: $shouldNavigate',
    );
    cprint('[FCM Handler] notification: $notification');

    // Show in-app notification if app is in foreground and requested
    if (showInApp) {
      cprint('[FCM Handler] Showing in-app notification...');
      _showInAppNotification(notification);
    }

    // Handle navigation based on notification type only if explicitly requested
    if (shouldNavigate) {
      _handleNavigation(notification);
    }

    // Handle custom actions
    _handleCustomActions(notification);
  }

  /// Show notification using flutter_local_notifications
  static Future<void> _showInAppNotification(
    NotificationModel notification,
  ) async {
    cprint('[FCM Handler] _showInAppNotification called');

    try {
      await LocalNotificationService.instance.showNotification(
        id: notification.id ?? DateTime.now().millisecondsSinceEpoch,
        title: notification.title ?? 'Notification',
        body: notification.body ?? '',
        payload: notification.type,
      );
      cprint('[FCM Handler] ✅ Local notification shown');
    } catch (e) {
      cprint('[FCM Handler] ❌ Error showing local notification: $e');
    }
  }

  /// Handle navigation based on notification type
  static void _handleNavigation(NotificationModel notification) {
    final type = notification.type?.toLowerCase();
    final action = notification.action?.toLowerCase();

    switch (type) {
      case NotificationTypes.booking:
        _handleBookingNotification(notification);
        break;
      case NotificationTypes.service:
        _handleServiceNotification(notification);
        break;
      case NotificationTypes.package:
        _handlePackageNotification(notification);
        break;
      case NotificationTypes.order:
        _handleOrderNotification(notification);
        break;
      case NotificationTypes.payment:
        _handlePaymentNotification(notification);
        break;
      case NotificationTypes.general:
        _handleGeneralNotification(notification);
        break;
      case NotificationTypes.promotion:
        _handlePromotionNotification(notification);
        break;
      case NotificationTypes.favourite:
        _handleFavouriteNotification(notification);
        break;
      case NotificationTypes.cart:
        _handleCartNotification(notification);
        break;
      case NotificationTypes.provider:
        _handleProviderNotification(notification);
        break;
      default:
        _handleDefaultNotification(notification);
        break;
    }
  }

  /// Handle booking-related notifications
  static void _handleBookingNotification(NotificationModel notification) {
    final bookingId =
        notification.getDataValue('booking_id') ??
        notification.getDataValue('bookingId');

    if (bookingId != null) {
      // Navigate to booking details or orders history
      //  CustomNavigator.push(Routes.MY_ORDERS_HISTORY_SCREEN);
    } else {
      // Navigate to general orders screen
      // CustomNavigator.push(Routes.MY_ORDERS_HISTORY_SCREEN);
    }
  }

  /// Handle service-related notifications
  static void _handleServiceNotification(NotificationModel notification) {
    final serviceId =
        notification.getDataValue('service_id') ??
        notification.getDataValue('serviceId');

    if (serviceId != null) {
      // Navigate to service details
      // CustomNavigator.push(
      //   Routes.SERVICE_DETAILS_SCREEN,
      //   extra: {'productId': int.tryParse(serviceId) ?? 0},
      // );
    } else {
      // Navigate to home screen
      //    CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
    }
  }

  /// Handle package-related notifications
  static void _handlePackageNotification(NotificationModel notification) {
    final packageId =
        notification.getDataValue('package_id') ??
        notification.getDataValue('packageId');

    if (packageId != null) {
      // Navigate to package details
      // CustomNavigator.push(
      //   Routes.PRODUCT_DETAILS_SCREEN,
      //   extra: {'productId': int.tryParse(packageId) ?? 0},
      // );
    } else {
      // Navigate to home screen
      // CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
    }
  }

  /// Handle order-related notifications
  static void _handleOrderNotification(NotificationModel notification) {
    final orderId =
        notification.getDataValue('order_id') ??
        notification.getDataValue('orderId');

    if (orderId != null) {
      // Navigate to specific order details or orders history
      // CustomNavigator.push(Routes.MY_ORDERS_HISTORY_SCREEN);
    } else {
      // Navigate to general orders screen
      // CustomNavigator.push(Routes.MY_ORDERS_HISTORY_SCREEN);
    }
  }

  /// Handle payment-related notifications
  static void _handlePaymentNotification(NotificationModel notification) {
    final paymentId =
        notification.getDataValue('payment_id') ??
        notification.getDataValue('paymentId');

    if (paymentId != null) {
      // Navigate to orders history to see payment status
      // CustomNavigator.push(Routes.MY_ORDERS_HISTORY_SCREEN);
    } else {
      // Navigate to payment settings or orders
      // CustomNavigator.push(Routes.MY_ORDERS_HISTORY_SCREEN);
    }
  }

  /// Handle favourite-related notifications
  static void _handleFavouriteNotification(NotificationModel notification) {
    final productId =
        notification.getDataValue('product_id') ??
        notification.getDataValue('productId');

    if (productId != null) {
      // Navigate to specific product details
      final id = int.tryParse(productId) ?? 0;
      final productType =
          notification.getDataValue('product_type') ?? 'service';

      if (productType.toLowerCase() == 'package') {
        // CustomNavigator.push(
        //   Routes.PRODUCT_DETAILS_SCREEN,
        //   extra: {'productId': id},
        // );
      } else {
        // CustomNavigator.push(
        //   Routes    .SERVICE_DETAILS_SCREEN,
        //   extra: {'productId': id},
        // );
      }
    } else {
      // Navigate to favourites screen
      // CustomNavigator.push(Routes.FAVOURITE_SCREEN);
    }
  }

  /// Handle cart-related notifications
  static void _handleCartNotification(NotificationModel notification) {
    final productId =
        notification.getDataValue('product_id') ??
        notification.getDataValue('productId');

    if (productId != null) {
      // Navigate to cart screen
      // CustomNavigator.push(Routes.CART_SCREEN);
    } else {
      // Navigate to cart screen
      // CustomNavigator.push(Routes.CART_SCREEN);
    }
  }

  /// Handle provider-related notifications
  static void _handleProviderNotification(NotificationModel notification) {
    final providerId =
        notification.getDataValue('provider_id') ??
        notification.getDataValue('providerId');

    // Navigate to join as provider screen or home
    //  CustomNavigator.push(Routes.JOIN_AS_PROVIDER_SCREEN);
  }

  /// Handle general notifications
  static void _handleGeneralNotification(NotificationModel notification) {
    final targetScreen =
        notification.getDataValue('target_screen') ??
        notification.getDataValue('targetScreen');

    if (targetScreen != null) {
      // Navigate to specific screen
      _navigateToScreen(targetScreen);
    }
    // Don't navigate anywhere if no target screen is specified
  }

  /// Handle promotion notifications
  static void _handlePromotionNotification(NotificationModel notification) {
    final promotionId =
        notification.getDataValue('promotion_id') ??
        notification.getDataValue('promotionId');

    // Only navigate if there's a specific promotion to show
    // Otherwise just show the notification without navigation
    if (promotionId != null) {
      // TODO: Navigate to specific promotion when route is available
      cprint('Promotion notification with ID: $promotionId');
    }
  }

  /// Handle default notification (fallback)
  static void _handleDefaultNotification(NotificationModel notification) {
    // Default action - just log, don't navigate anywhere
    cprint('Default notification handled: ${notification.title}');
  }

  /// Handle custom actions
  static void _handleCustomActions(NotificationModel notification) {
    final action = notification.action?.toLowerCase();

    switch (action) {
      case 'open_url':
        final url = notification.getDataValue('url');
        if (url != null) {
          _openUrl(url);
        }
        break;
      case 'show_dialog':
        _showCustomDialog(notification);
        break;
      case 'refresh_data':
        _refreshAppData();
        break;
      default:
        // No custom action
        break;
    }
  }

  /// Navigate to specific screen by name
  static void _navigateToScreen(String screenName) {
    switch (screenName.toLowerCase()) {
      case 'home':
        //   CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
        break;
      default:
        cprint('Unknown screen name for navigation: $screenName');
        break;
    }
  }

  /// Open URL in browser
  static void _openUrl(String url) {
    cprint('Opening URL: $url');
  }

  /// Show custom dialog
  static void _showCustomDialog(NotificationModel notification) {
    final context = CustomNavigator.navigatorState.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(notification.title ?? 'Notification'),
          content: Text(notification.body ?? ''),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  /// Refresh app data
  static void _refreshAppData() {
    // TODO: Implement app data refresh logic
    cprint('Refreshing app data...');
  }
}
