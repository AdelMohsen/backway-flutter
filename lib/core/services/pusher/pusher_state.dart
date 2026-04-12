sealed class PusherState {
  const PusherState();
}

class PusherInitial extends PusherState {}

class PusherConnecting extends PusherState {}

class PusherConnected extends PusherState {}

class PusherDisconnected extends PusherState {}

class PusherReconnecting extends PusherState {}

class PusherError extends PusherState {
  final String message;

  const PusherError(this.message);
}

class PusherSubscriptionError extends PusherState {
  final String message;

  const PusherSubscriptionError(this.message);
}

class PusherSubscribed extends PusherState {
  final String channelName;

  const PusherSubscribed(this.channelName);
}

class PusherEventReceived extends PusherState {
  final String eventName;
  final dynamic data;
  final DateTime timestamp;

  PusherEventReceived({required this.eventName, required this.data})
    : timestamp = DateTime.now();
}
