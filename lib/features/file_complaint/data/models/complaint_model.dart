import 'package:equatable/equatable.dart';

class ComplaintModel extends Equatable {
  final int id;
  final int customerId;
  final String title;
  final String details;
  final String? image;
  final String createdAt;
  final String updatedAt;

  const ComplaintModel({
    required this.id,
    required this.customerId,
    required this.title,
    required this.details,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      customerId: json['customer_id'],
      title: json['title'],
      details: json['details'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'title': title,
      'details': details,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
    id,
    customerId,
    title,
    details,
    image,
    createdAt,
    updatedAt,
  ];
}
