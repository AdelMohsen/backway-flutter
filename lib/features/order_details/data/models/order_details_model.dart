import 'package:equatable/equatable.dart';
import 'package:greenhub/features/orders/data/models/orders_model.dart';

class OrderDetailsResponseModel extends Equatable {
  final bool? success;
  final OrderModel? data;

  const OrderDetailsResponseModel({this.success, this.data});

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponseModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? OrderModel.fromJson(json['data']) : null,
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
