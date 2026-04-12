import 'package:equatable/equatable.dart';

class MessagesModel extends Equatable {
  final bool? success;
  final MessagesData? data;

  const MessagesModel({
    this.success,
    this.data,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? MessagesData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [success, data];
}

class MessagesData extends Equatable {
  final int? currentPage;
  final List<ChatModel>? chats;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  const MessagesData({
    this.currentPage,
    this.chats,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MessagesData.fromJson(Map<String, dynamic> json) {
    return MessagesData(
      currentPage: json['current_page'] as int?,
      chats: json['data'] != null
          ? (json['data'] as List).map((i) => ChatModel.fromJson(i)).toList()
          : null,
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      nextPageUrl: json['next_page_url'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        chats,
        firstPageUrl,
        from,
        lastPage,
        lastPageUrl,
        nextPageUrl,
        perPage,
        prevPageUrl,
        to,
        total,
      ];
}

class ChatModel extends Equatable {
  final int? id;
  final int? orderId;
  final int? customerId;
  final int? driverId;
  final String? lastMessageAt;
  final String? createdAt;
  final String? updatedAt;
  final int? unreadCount;
  final ChatUserModel? customer;
  final ChatUserModel? driver;
  final List<ChatMessageModel>? messages;

  const ChatModel({
    this.id,
    this.orderId,
    this.customerId,
    this.driverId,
    this.lastMessageAt,
    this.createdAt,
    this.updatedAt,
    this.unreadCount,
    this.customer,
    this.driver,
    this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      customerId: json['customer_id'] as int?,
      driverId: json['driver_id'] as int?,
      lastMessageAt: json['last_message_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      unreadCount: json['unread_count'] as int?,
      customer: json['customer'] != null
          ? ChatUserModel.fromJson(json['customer'])
          : null,
      driver: json['driver'] != null
          ? ChatUserModel.fromJson(json['driver'])
          : null,
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((i) => ChatMessageModel.fromJson(i))
              .toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        customerId,
        driverId,
        lastMessageAt,
        createdAt,
        updatedAt,
        unreadCount,
        customer,
        driver,
        messages,
      ];
}

class ChatUserModel extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? faceImageUrl;

  const ChatUserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.faceImageUrl,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      faceImageUrl: json['face_image_url'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, phone, email, avatar, faceImageUrl];
}

class ChatMessageModel extends Equatable {
  final int? id;
  final int? chatId;
  final int? senderId;
  final String? message;
  final String? type;
  final String? attachmentUrl;
  final bool? isRead;
  final String? readAt;
  final String? createdAt;

  const ChatMessageModel({
    this.id,
    this.chatId,
    this.senderId,
    this.message,
    this.type,
    this.attachmentUrl,
    this.isRead,
    this.readAt,
    this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as int?,
      chatId: json['chat_id'] as int?,
      senderId: json['sender_id'] as int?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      attachmentUrl: json['attachment_url'] as String?,
      isRead: json['is_read'] as bool?,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        message,
        type,
        attachmentUrl,
        isRead,
        readAt,
        createdAt,
      ];
}
