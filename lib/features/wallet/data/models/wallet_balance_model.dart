import 'package:equatable/equatable.dart';

class WalletBalanceResponseModel extends Equatable {
  final bool? success;
  final num? balance;
  final String? currency;

  const WalletBalanceResponseModel({
    this.success,
    this.balance,
    this.currency,
  });

  factory WalletBalanceResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return WalletBalanceResponseModel(
      success: json['success'],
      balance: data?['balance'],
      currency: data?['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': {
        'balance': balance,
        'currency': currency,
      }
    };
  }

  @override
  List<Object?> get props => [success, balance, currency];
}
