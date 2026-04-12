import 'package:firebase_messaging/firebase_messaging.dart';
import '../../utils/utility.dart';
import 'fcm_notification_handler.dart';
import 'models/notification_model.dart';

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    cprint('[FCM] ===== BACKGROUND MESSAGE =====');
    cprint('[FCM] messageId: ${message.messageId ?? 'null'}');
    cprint('[FCM] title: ${message.notification?.title ?? 'null'}');
    cprint('[FCM] body: ${message.notification?.body ?? 'null'}');
    cprint('[FCM] data: ${message.data}');
  } catch (e) {
    cprint('[FCM] Background handler error: $e');
  }
}

/// Simple FCM Service for handling push notifications
class FCMService {
  FCMService._();
  static final FCMService instance = FCMService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  bool _isInitialized = false;
  String? _fcmToken;

  // Getters
  String? get fcmToken => _fcmToken;
  bool get isInitialized => _isInitialized;

  /// Initialize FCM service
  Future<void> initialize() async {
    cprint('[FCM] ========== INITIALIZATION START ==========');
    cprint('[FCM] isInitialized: $_isInitialized');
    cprint('[FCM] current token: $_fcmToken');

    if (_isInitialized) {
      cprint('[FCM] Already initialized, skipping...');
      return;
    }

    try {
      // 1. Request permissions
      cprint('[FCM] Step 1: Requesting permissions...');
      await _requestPermissions();

      // 2. Get FCM token
      cprint('[FCM] Step 2: Getting FCM token...');
      await _getToken();

      // 3. Setup message handlers
      cprint('[FCM] Step 3: Setting up message handlers...');
      _setupMessageHandlers();

      _isInitialized = true;
      cprint('[FCM] ========== INITIALIZATION SUCCESS ==========');
      cprint('[FCM] Final token: $_fcmToken');
    } catch (e, stack) {
      cprint('[FCM] ========== INITIALIZATION FAILED ==========');
      cprint('[FCM] Error: $e');
      cprint('[FCM] Stack: $stack');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    cprint('[FCM] Permission status: ${settings.authorizationStatus}');
  }

  /// Get FCM token
  Future<void> _getToken() async {
    try {
      _fcmToken = await _messaging.getToken();
      cprint(
        '[FCM] Token retrieved: ${_fcmToken != null ? '${_fcmToken!.substring(0, 20)}...' : 'NULL'}',
      );

      // Listen for token refresh
      _messaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        cprint('[FCM] Token refreshed: ${token.substring(0, 20)}...');
      });
    } catch (e) {
      cprint('[FCM] Error getting token: $e');
    }
  }

  /// Setup message handlers
  void _setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    _checkInitialMessage();
    cprint('[FCM] Message handlers configured');
  }

  /// Check for initial message
  Future<void> _checkInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    if (message != null) {
      cprint('[FCM] Initial message found: ${message.messageId}');
      _onMessageOpenedApp(message);
    }
  }

  /// Handle foreground message
  Future<void> _onForegroundMessage(RemoteMessage message) async {
    try {
      cprint('[FCM] ===== FOREGROUND MESSAGE =====');
      cprint('[FCM] messageId: ${message.messageId ?? 'null'}');
      cprint('[FCM] title: ${message.notification?.title ?? 'null'}');
      cprint('[FCM] body: ${message.notification?.body ?? 'null'}');
      cprint('[FCM] data: ${message.data}');

      final notification = NotificationModel.fromRemoteMessage(message);
      cprint('[FCM] NotificationModel created: $notification');

      FCMNotificationHandler.handleNotification(
        notification,
        showInApp: true,
        shouldNavigate: false,
      );
    } catch (e, stack) {
      cprint('[FCM] Foreground handler error: $e');
      cprint('[FCM] Stack: $stack');
    }
  }

  /// Handle message opened app
  void _onMessageOpenedApp(RemoteMessage message) {
    try {
      cprint('[FCM] ===== MESSAGE OPENED APP =====');
      cprint('[FCM] messageId: ${message.messageId ?? 'null'}');
      cprint('[FCM] title: ${message.notification?.title ?? 'null'}');
      cprint('[FCM] body: ${message.notification?.body ?? 'null'}');
      cprint('[FCM] data: ${message.data}');

      final notification = NotificationModel.fromRemoteMessage(message);
      cprint('[FCM] NotificationModel created: $notification');

      Future.delayed(const Duration(milliseconds: 500), () {
        FCMNotificationHandler.handleNotification(
          notification,
          showInApp: false,
          shouldNavigate: true,
        );
      });
    } catch (e, stack) {
      cprint('[FCM] Message opened handler error: $e');
      cprint('[FCM] Stack: $stack');
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      cprint('[FCM] Subscribed: $topic');
    } catch (e) {
      cprint('[FCM] Subscribe error: $e');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      cprint('[FCM] Unsubscribed: $topic');
    } catch (e) {
      cprint('[FCM] Unsubscribe error: $e');
    }
  }

  /// Get token synchronously (returns cached token)
  static String? getToken() {
    final token = instance._fcmToken;
    cprint(
      '[FCM] getToken() called - isInitialized: ${instance._isInitialized}, hasToken: ${token != null}',
    );
    return token;
  }

  /// Get token asynchronously (fetches if not available)
  static Future<String?> getTokenAsync() async {
    cprint('[FCM] getTokenAsync() called');

    // Return cached token if available
    if (instance._fcmToken != null) {
      cprint('[FCM] Returning cached token');
      return instance._fcmToken;
    }

    // Try to get token directly from Firebase
    try {
      cprint('[FCM] No cached token, fetching from Firebase...');
      final token = await instance._messaging.getToken();
      instance._fcmToken = token;
      cprint(
        '[FCM] Fresh token: ${token != null ? '${token.substring(0, 20)}...' : 'NULL'}',
      );
      return token;
    } catch (e) {
      cprint('[FCM] getTokenAsync error: $e');
      return null;
    }
  }
}
