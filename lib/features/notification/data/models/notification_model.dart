import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final bool? success;
  final NotificationPageData? data;
  final int? unreadCount;

  const NotificationModel({
    this.success,
    this.data,
    this.unreadCount,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? NotificationPageData.fromJson(json['data'])
          : null,
      unreadCount: json['unread_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'unread_count': unreadCount,
    };
  }

  @override
  List<Object?> get props => [success, data, unreadCount];
}

class NotificationPageData extends Equatable {
  final int? currentPage;
  final List<NotificationItem>? data;
  final int? lastPage;
  final int? perPage;
  final int? total;

  const NotificationPageData({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory NotificationPageData.fromJson(Map<String, dynamic> json) {
    return NotificationPageData(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List?)
          ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: json['last_page'] as int?,
      perPage: json['per_page'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((e) => e.toJson()).toList(),
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }

  @override
  List<Object?> get props => [currentPage, data, lastPage, perPage, total];
}

class NotificationItem extends Equatable {
  final int? id;
  final int? userId;
  final String? type;
  final String? title;
  final String? body;
  final Map<String, dynamic>? extraData;
  final bool? isRead;
  final String? createdAt;
  final String? titleLocalized;
  final String? bodyLocalized;
  final String? icon;

  const NotificationItem({
    this.id,
    this.userId,
    this.type,
    this.title,
    this.body,
    this.extraData,
    this.isRead,
    this.createdAt,
    this.titleLocalized,
    this.bodyLocalized,
    this.icon,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      extraData: json['data'] as Map<String, dynamic>?,
      isRead: json['is_read'] as bool?,
      createdAt: json['created_at'] as String?,
      titleLocalized: json['title_localized'] as String?,
      bodyLocalized: json['body_localized'] as String?,
      icon: json['icon'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'title': title,
      'body': body,
      'data': extraData,
      'is_read': isRead,
      'created_at': createdAt,
      'title_localized': titleLocalized,
      'body_localized': bodyLocalized,
      'icon': icon,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        title,
        body,
        extraData,
        isRead,
        createdAt,
        titleLocalized,
        bodyLocalized,
        icon,
      ];
}
