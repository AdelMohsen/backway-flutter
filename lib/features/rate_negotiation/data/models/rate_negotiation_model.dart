import 'package:equatable/equatable.dart';

class RateNegotiationModel extends Equatable {
  const RateNegotiationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final RateNegotiationData? data;

  factory RateNegotiationModel.fromJson(Map<String, dynamic> json) {
    return RateNegotiationModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? RateNegotiationData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [
        success,
        message,
        data,
      ];
}

class RateNegotiationData extends Equatable {
  const RateNegotiationData({
    required this.id,
    required this.orderId,
    required this.raterId,
    required this.ratedId,
    required this.raterType,
    required this.rating,
    required this.comment,
    this.aspects,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int orderId;
  final int raterId;
  final int ratedId;
  final String raterType;
  final int rating;
  final String comment;
  final dynamic aspects;
  final String createdAt;
  final String updatedAt;

  factory RateNegotiationData.fromJson(Map<String, dynamic> json) {
    return RateNegotiationData(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      raterId: json['rater_id'] ?? 0,
      ratedId: json['rated_id'] ?? 0,
      raterType: json['rater_type'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      aspects: json['aspects'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        raterId,
        ratedId,
        raterType,
        rating,
        comment,
        aspects,
        createdAt,
        updatedAt,
      ];
}
