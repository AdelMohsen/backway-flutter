import 'package:equatable/equatable.dart';

class EnableNotificationModel extends Equatable {
  final bool? success;
  final String? message;
  final NotificationSettingsData? data;

  const EnableNotificationModel({
    this.success,
    this.message,
    this.data,
  });

  factory EnableNotificationModel.fromJson(Map<String, dynamic> json) {
    return EnableNotificationModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? NotificationSettingsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (message != null) 'message': message,
      if (data != null) 'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}

class NotificationSettingsData extends Equatable {
  final bool? notificationsEnabled;

  const NotificationSettingsData({
    this.notificationsEnabled,
  });

  factory NotificationSettingsData.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsData(
      notificationsEnabled: json['notifications_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (notificationsEnabled != null) 'notifications_enabled': notificationsEnabled,
    };
  }

  @override
  List<Object?> get props => [notificationsEnabled];
}
