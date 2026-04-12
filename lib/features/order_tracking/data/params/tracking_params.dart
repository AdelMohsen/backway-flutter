import 'package:equatable/equatable.dart';

class TrackingParams extends Equatable {
  final int? id;
  final String? orderNumber;

  const TrackingParams({
    this.id,
    this.orderNumber,
  });

  Map<String, dynamic> returnedMap() {
    return {};
  }

  @override
  List<Object?> get props => [id, orderNumber];
}
