import 'package:equatable/equatable.dart';

class AddFundsParams extends Equatable {
  final double amount;
  final String paymentMethod;

  const AddFundsParams({
    required this.amount,
    required this.paymentMethod,
  });

  Map<String, dynamic> returnedMap() {
    final map = <String, dynamic>{
      'amount': amount,
      'payment_method': paymentMethod,
    };
    map.removeWhere((key, value) => value == null || value == '');
    return map;
  }

  @override
  List<Object?> get props => [amount, paymentMethod];
}
