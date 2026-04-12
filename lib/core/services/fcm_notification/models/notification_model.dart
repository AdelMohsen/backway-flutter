import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationModel {
  final int? id;
  final String? title;
  final String? body;
  final String? imageUrl;
  final Map<String, dynamic>? data;
  final String? type;
  final String? action;
  final DateTime? receivedAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.imageUrl,
    this.data,
    this.type,
    this.action,
    this.receivedAt,
  });

  /// Create from Firebase RemoteMessage
  factory NotificationModel.fromRemoteMessage(RemoteMessage message) {
    return NotificationModel(
      id: message.messageId?.hashCode,
      title: message.notification?.title ?? message.data['title'],
      body: message.notification?.body ?? message.data['body'],
      imageUrl: message.notification?.android?.imageUrl ?? 
                message.notification?.apple?.imageUrl ?? 
                message.data['image'],
      data: message.data,
      type: message.data['type'],
      action: message.data['action'],
      receivedAt: DateTime.now(),
    );
  }

  /// Create from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['imageUrl'],
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
      type: json['type'],
      action: json['action'],
      receivedAt: json['receivedAt'] != null 
          ? DateTime.parse(json['receivedAt']) 
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'data': data,
      'type': type,
      'action': action,
      'receivedAt': receivedAt?.toIso8601String(),
    };
  }

  /// Check if notification has image
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  /// Get specific data value
  String? getDataValue(String key) {
    return data?[key]?.toString();
  }

  /// Check if notification is of specific type
  bool isType(String notificationType) {
    return type?.toLowerCase() == notificationType.toLowerCase();
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, body: $body, type: $type, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
