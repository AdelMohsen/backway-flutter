import 'package:equatable/equatable.dart';

class AboutServicesModel extends Equatable {
  final bool? success;
  final AboutServicesData? data;

  const AboutServicesModel({
    this.success,
    this.data,
  });

  factory AboutServicesModel.fromJson(Map<String, dynamic> json) {
    return AboutServicesModel(
      success: json['success'] as bool?,
      data:
          json['data'] != null
              ? AboutServicesData.fromJson(json['data'])
              : null,
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

class AboutServicesData extends Equatable {
  final String? type;
  final String? title;
  final String? body;

  const AboutServicesData({
    this.type,
    this.title,
    this.body,
  });

  factory AboutServicesData.fromJson(Map<String, dynamic> json) {
    return AboutServicesData(
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
