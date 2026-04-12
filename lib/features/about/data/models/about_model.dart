import 'package:equatable/equatable.dart';

class AboutModel extends Equatable {
  final bool? success;
  final AboutData? data;

  const AboutModel({
    this.success,
    this.data,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? AboutData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, data];
}

class AboutData extends Equatable {
  final String? type;
  final String? title;
  final String? body;

  const AboutData({
    this.type,
    this.title,
    this.body,
  });

  factory AboutData.fromJson(Map<String, dynamic> json) {
    return AboutData(
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'body': body,
    };
  }

  @override
  List<Object?> get props => [type, title, body];
}
