import 'package:equatable/equatable.dart';

class OrderDetailsParams extends Equatable {
  final int orderId;
  final String? lang;

  const OrderDetailsParams({
    required this.orderId,
    this.lang,
  });

  Map<String, dynamic> returnedMap() {
    final map = <String, dynamic>{};
    if (lang != null) {
      map['lang'] = lang;
    }
    return map;
  }

  @override
  List<Object?> get props => [orderId, lang];
}
