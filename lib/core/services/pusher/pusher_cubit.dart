import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../app_config/api_names.dart';
import '../../app_config/app_config.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../shared/cache/cache_methods.dart';
import '../../utils/utility.dart';
import '../network/network.dart';
import 'pusher_state.dart';

class PusherCubit extends Cubit<PusherState> {
  PusherCubit() : super(PusherInitial());

  PusherChannelsFlutter? _pusher;
  final Map<String, List<void Function(String eventName, dynamic data)>>
  _eventListeners = {};

  bool get isConnected => state is PusherConnected || state is PusherSubscribed;

  /// Initialize and connect to Pusher
  Future<void> connect() async {
    if (_pusher != null) return;

    try {
      if (isClosed) return;
      emit(PusherConnecting());
      _pusher = PusherChannelsFlutter.getInstance();

      // Make sure we start clean
      try {
        await _pusher!.disconnect();
      } catch (_) {}

      cprint('================ PUSHER INIT (MANUAL AUTH) =================');
      cprint('[PusherCubit] Key: ${AppConfig.PUSHER_API_KEY}');
      cprint('[PusherCubit] Cluster: ${AppConfig.PUSHER_API_CLUSTER}');
      final token = await CacheMethods.getToken();
      await _pusher!.init(
        apiKey: AppConfig.PUSHER_API_KEY,
        cluster: AppConfig.PUSHER_API_CLUSTER,
        onConnectionStateChange: _onConnectionStateChange,
        onError: _onError,
        onEvent: _onGlobalEvent,

        onAuthorizer: _handleAuthorizer,
        // authEndpoint: AppConfig.PUSHER_AUTH_ENDPOINT,
        // authParams: {{'Authorization': 'Bearer $token'}},
      );

      await _pusher!.connect();
      cprint('[PusherCubit] connect() called successfully');
    } catch (e) {
      if (isClosed) return;
      cprint('[PusherCubit] ❌ Connection error: $e');
      emit(PusherError('Base connection failed: $e'));
    }
  }

  // Track subscribed channels to prevent "Already subscribed" exceptions
  final Set<String> _subscribedChannels = {};

  /// Subscribe to a private channel
  Future<void> subscribeToChannel(String channelName) async {
    if (_pusher == null) {
      cprint('[PusherCubit] Cannot subscribe: not connected');
      return;
    }

    if (_subscribedChannels.contains(channelName)) {
      cprint(
        '[PusherCubit] Already subscribed or subscribing to: $channelName',
      );
      return;
    }

    _subscribedChannels.add(channelName);

    try {
      cprint('[Pusher] subscribeToChannel: "$channelName"');
      await _pusher!.subscribe(
        channelName: channelName,
        onSubscriptionSucceeded: (data) {
          if (isClosed) return;
          cprint('[PusherCubit] ✅ Subscription Succeeded: $channelName');
          emit(PusherSubscribed(channelName));
        },
        onSubscriptionError: (message, error) {
          if (isClosed) return;
          _subscribedChannels.remove(
            channelName,
          ); // Failed, so we can try again later if needed
          cprint('[PusherCubit] ❌ Subscription ERROR for $channelName');
          cprint(
            '[PusherCubit] ❌ Auth Endpoint might be wrong or returning 403!',
          );
          cprint('[PusherCubit] ❌ Message: $message, Error: $error');
          emit(
            PusherSubscriptionError(
              'Subscription Auth Failed for $channelName',
            ),
          );
        },
        onEvent: _onChannelEvent,
      );
    } catch (e) {
      if (isClosed) return;

      // Detailed check for Android/Native re-subscription errors
      final errorStr = e.toString();
      final isAlreadySubscribed =
          errorStr.contains('Already subscribed') ||
          (e is PlatformException &&
              e.message?.contains('Already subscribed') == true);

      if (isAlreadySubscribed) {
        cprint('[PusherCubit] Already subscribed (Recovered): $channelName');
        emit(PusherSubscribed(channelName));
        return;
      }

      _subscribedChannels.remove(channelName);
      cprint('[PusherCubit] Subscribe method error: $e');
      emit(PusherSubscriptionError('Subscribe method threw: $e'));
    }
  }

  /// Unsubscribe from a channel
  Future<void> unsubscribeFromChannel(String channelName) async {
    if (_pusher == null) return;
    try {
      await _pusher!.unsubscribe(channelName: channelName);
      _eventListeners.remove(channelName);
      cprint('[PusherCubit] Unsubscribed from: $channelName');
    } catch (e) {
      cprint('[PusherCubit] Unsubscribe error: $e');
    }
  }

  /// Register a listener for events on a specific channel
  void addEventListener(
    String channelName,
    void Function(String eventName, dynamic data) listener,
  ) {
    _eventListeners.putIfAbsent(channelName, () => []);
    _eventListeners[channelName]!.add(listener);
    cprint(
      '[PusherCubit] Registered listener for "$channelName". Total: ${_eventListeners[channelName]!.length}',
    );
  }

  /// Remove listeners for a channel
  void removeEventListeners(String channelName) {
    _eventListeners.remove(channelName);
  }

  // ─── Internal Handlers ───

  void _onConnectionStateChange(String currentState, String previousState) {
    if (isClosed) return;
    cprint('[PusherCubit] Connection: $previousState -> $currentState');
    switch (currentState.toLowerCase()) {
      case 'connected':
        emit(PusherConnected());
        break;
      case 'disconnected':
        emit(PusherDisconnected());
        break;
      case 'connecting':
      case 'reconnecting':
        emit(PusherReconnecting());
        break;
    }
  }

  void _onError(String message, int? code, dynamic e) {
    if (isClosed) return;
    cprint('[PusherCubit] Base Error: $message (code: $code)');
    emit(PusherError(message));
  }

  void _onGlobalEvent(dynamic event) {
    if (event is! PusherEvent) return;
    cprint('[PusherCubit] (Global) Event: ${event.eventName}');
    _handleEvent(event);
  }

  void _onChannelEvent(dynamic event) {
    if (event is! PusherEvent) return;
    cprint('[PusherCubit] (Channel) Event: ${event.eventName}');
    _handleEvent(event);
  }

  void _handleEvent(PusherEvent event) {
    cprint(
      '[PusherCubit] 📡 RAW EVENT: "${event.eventName}" on channel: "${event.channelName}"',
    );
    cprint(event.toString());

    // Skip internal pusher structural events
    if (event.eventName.startsWith('pusher:') ||
        event.eventName.startsWith('pusher_internal:')) {
      return;
    }

    cprint('================ RECEIVED EVENT ================');
    cprint('[PusherCubit] eventName:   "${event.eventName}"');
    cprint('[PusherCubit] channelName: "${event.channelName}"');
    cprint('[PusherCubit] raw data:    ${event.data}');

    dynamic parsedData;
    try {
      parsedData = event.data != null ? jsonDecode(event.data!) : null;
    } catch (e) {
      parsedData = event.data;
    }

    if (isClosed) return;
    emit(PusherEventReceived(eventName: event.eventName, data: parsedData));

    final listeners = _eventListeners[event.channelName];
    if (listeners != null && listeners.isNotEmpty) {
      cprint(
        '[PusherCubit] Routing to ${listeners.length} listeners on channel ${event.channelName}',
      );
      for (final listener in listeners) {
        listener(event.eventName, parsedData);
      }
    } else {
      cprint(
        '[PusherCubit] ⚠️ No specific listeners for ${event.channelName}, checking all keys... Registered keys: ${_eventListeners.keys.toList()}',
      );
      for (final entry in _eventListeners.entries) {
        if (event.channelName.contains(entry.key) == true ||
            entry.key.contains(event.channelName)) {
          cprint('[PusherCubit] Fallback matched key: ${entry.key}');
          for (final listener in entry.value) {
            listener(event.eventName, parsedData);
          }
        }
      }
    }
  }

  /// Disconnect and clean up
  Future<void> disconnect() async {
    if (_pusher == null) return;
    try {
      await _pusher!.disconnect();
      _pusher = null;
      _eventListeners.clear();
      _subscribedChannels.clear();

      if (isClosed) return;
      emit(PusherDisconnected());
      cprint('[PusherCubit] Disconnected clean');
    } catch (e) {
      cprint('[PusherCubit] Disconnect error: $e');
    }
  }

  /// Manual authorizer for private channels - Dart based (Dio)
  Future<Map<String, dynamic>?> _handleAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      cprint('🔐 Pusher Auth Call: Authorizing $channelName...');
      cprint('🔐 Pusher Socket ID: $socketId');

      final token = await CacheMethods.getToken();
      if (token == null || token.isEmpty) {
        cprint('❌ Pusher Auth: No token available');
        return null;
      }

      final payload = {'channel_name': channelName, 'socket_id': socketId};

      cprint('🔐 Pusher Auth Request (Network Service): ${Endpoints.broadcastingAuth}');
      cprint('🔐 Pusher Auth Payload: $payload');

      final response = await Network().request(
        Endpoints.broadcastingAuth,
        method: ServerMethods.POST,
        body: payload,
        baseUrl: AppConfig.PUSHER_AUTH_ENDPOINT,
      );

      cprint('✅ Pusher Auth Response Status: ${response.statusCode}');
      cprint('✅ Pusher Auth Response Body: ${response.data}');

      // Return the auth response - must contain 'auth' field
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else if (response.data is String) {
        return jsonDecode(response.data as String) as Map<String, dynamic>;
      }

      return null;
    } catch (e) {
      cprint('❌ Pusher Auth Exception: $e');
      return null;
    }
  }

  @override
  Future<void> close() async {
    await disconnect();
    return super.close();
  }
}
