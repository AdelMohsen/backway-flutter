/// Notification types constants for Momento app
class NotificationTypes {
  // Momento-specific notification types
  static const String booking = 'booking';
  static const String service = 'service';
  static const String package = 'package';
  static const String order = 'order';
  static const String payment = 'payment';
  static const String promotion = 'promotion';
  static const String general = 'general';
  static const String reminder = 'reminder';
  static const String update = 'update';
  static const String news = 'news';
  static const String alert = 'alert';
  static const String message = 'message';
  static const String favourite = 'favourite';
  static const String cart = 'cart';
  static const String provider = 'provider';
}

/// Notification actions constants
class NotificationActions {
  static const String openUrl = 'open_url';
  static const String showDialog = 'show_dialog';
  static const String refreshData = 'refresh_data';
  static const String navigate = 'navigate';
  static const String none = 'none';
}

/// Notification priority levels
class NotificationPriority {
  static const String high = 'high';
  static const String normal = 'normal';
  static const String low = 'low';
}

/// Notification channels for Android
class NotificationChannels {
  static const String highImportance = 'high_importance_channel';
  static const String normalImportance = 'normal_importance_channel';
  static const String lowImportance = 'low_importance_channel';
}
