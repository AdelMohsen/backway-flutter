import 'package:equatable/equatable.dart';

class OpenChatModel extends Equatable {
  final bool? success;
  final String? message;
  final OpenChatData? data;

  const OpenChatModel({this.success, this.message, this.data});

  factory OpenChatModel.fromJson(Map<String, dynamic> json) {
    return OpenChatModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? OpenChatData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}

class OpenChatData extends Equatable {
  final ChatDetails? chat;

  const OpenChatData({this.chat});

  factory OpenChatData.fromJson(Map<String, dynamic> json) {
    return OpenChatData(
      chat: json['chat'] != null ? ChatDetails.fromJson(json['chat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (chat != null) 'chat': chat?.toJson(),
    };
  }

  @override
  List<Object?> get props => [chat];
}

class ChatDetails extends Equatable {
  final int? id;
  final int? orderId;

  const ChatDetails({this.id, this.orderId});

  factory ChatDetails.fromJson(Map<String, dynamic> json) {
    return ChatDetails(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
    };
  }

  @override
  List<Object?> get props => [id, orderId];
}
