import 'package:equatable/equatable.dart';

class NegotiationOffersModel extends Equatable {
  final NegotiationChatModel? chat;
  final NegotiationMessagesPaginationModel? messagesPagination;

  const NegotiationOffersModel({
    this.chat,
    this.messagesPagination,
  });

  factory NegotiationOffersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return NegotiationOffersModel(
        chat: json['data']['chat'] != null ? NegotiationChatModel.fromJson(json['data']['chat']) : null,
        messagesPagination: json['data']['messages'] != null ? NegotiationMessagesPaginationModel.fromJson(json['data']['messages']) : null,
      );
    }
    return const NegotiationOffersModel();
  }

  @override
  List<Object?> get props => [chat, messagesPagination];
}

class NegotiationChatModel extends Equatable {
  final int? id;
  final int? orderId;
  final int? customerId;
  final int? driverId;
  final String? createdAt;
  final NegotiationUserModel? customer;
  final NegotiationUserModel? driver;

  const NegotiationChatModel({
    this.id,
    this.orderId,
    this.customerId,
    this.driverId,
    this.createdAt,
    this.customer,
    this.driver,
  });

  factory NegotiationChatModel.fromJson(Map<String, dynamic> json) {
    return NegotiationChatModel(
      id: json['id'],
      orderId: json['order_id'],
      customerId: json['customer_id'],
      driverId: json['driver_id'],
      createdAt: json['created_at'],
      customer: json['customer'] != null ? NegotiationUserModel.fromJson(json['customer']) : null,
      driver: json['driver'] != null ? NegotiationUserModel.fromJson(json['driver']) : null,
    );
  }

  @override
  List<Object?> get props => [id, orderId, customerId, driverId, createdAt, customer, driver];
}

class NegotiationUserModel extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? faceImageUrl;
  final String? role;

  const NegotiationUserModel({
    this.id,
    this.name,
    this.phone,
    this.faceImageUrl,
    this.role,
  });

  factory NegotiationUserModel.fromJson(Map<String, dynamic> json) {
    return NegotiationUserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      faceImageUrl: json['face_image_url'],
      role: json['role'],
    );
  }

  @override
  List<Object?> get props => [id, name, phone, faceImageUrl, role];
}

class NegotiationMessagesPaginationModel extends Equatable {
  final int? currentPage;
  final int? lastPage;
  final String? nextPageUrl;
  final List<NegotiationMessageModel>? data;

  const NegotiationMessagesPaginationModel({
    this.currentPage,
    this.lastPage,
    this.nextPageUrl,
    this.data,
  });

  factory NegotiationMessagesPaginationModel.fromJson(Map<String, dynamic> json) {
    return NegotiationMessagesPaginationModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      data: json['data'] != null
          ? List<NegotiationMessageModel>.from(json['data'].map((x) => NegotiationMessageModel.fromJson(x)))
          : null,
    );
  }

  @override
  List<Object?> get props => [currentPage, lastPage, nextPageUrl, data];
}

class NegotiationMessageModel extends Equatable {
  final int? id;
  final int? chatId;
  final int? senderId;
  final String? message;
  final String? type;
  final String? attachmentUrl;
  final bool? isRead;
  final String? createdAt;
  final NegotiationUserModel? sender;

  const NegotiationMessageModel({
    this.id,
    this.chatId,
    this.senderId,
    this.message,
    this.type,
    this.attachmentUrl,
    this.isRead,
    this.createdAt,
    this.sender,
  });

  factory NegotiationMessageModel.fromJson(Map<String, dynamic> json) {
    return NegotiationMessageModel(
      id: json['id'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      message: json['message']?.toString(), // Handle integer strings like "11"
      type: json['type'],
      attachmentUrl: json['attachment_url'],
      isRead: json['is_read'],
      createdAt: json['created_at'],
      sender: json['sender'] != null ? NegotiationUserModel.fromJson(json['sender']) : null,
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
        createdAt,
        sender,
      ];
}
