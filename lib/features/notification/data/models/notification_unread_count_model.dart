import 'package:equatable/equatable.dart';

class NotificationUnreadCountModel extends Equatable {
  final bool? success;
  final int? unreadCount;

  const NotificationUnreadCountModel({
    this.success,
    this.unreadCount,
  });

  factory NotificationUnreadCountModel.fromJson(Map<String, dynamic> json) {
    return NotificationUnreadCountModel(
      success: json['success'] as bool?,
      unreadCount: json['unread_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'unread_count': unreadCount,
    };
  }

  @override
  List<Object?> get props => [success, unreadCount];
}
