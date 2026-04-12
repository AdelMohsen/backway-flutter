import 'package:equatable/equatable.dart';

class AddFundsResponseModel extends Equatable {
  final bool? success;
  final String? message;
  final TransactionModel? transaction;
  final String? newBalance;

  const AddFundsResponseModel({
    this.success,
    this.message,
    this.transaction,
    this.newBalance,
  });

  factory AddFundsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return AddFundsResponseModel(
      success: json['success'],
      message: json['message'],
      transaction: data != null && data['transaction'] != null
          ? TransactionModel.fromJson(data['transaction'])
          : null,
      newBalance: data?['new_balance']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'transaction': transaction?.toJson(),
      'new_balance': newBalance,
    };
  }

  @override
  List<Object?> get props => [success, message, transaction, newBalance];
}

class TransactionModel extends Equatable {
  final int? id;
  final String? transactionId;
  final int? userId;
  final int? orderId;
  final String? type;
  final String? amount;
  final String? balanceBefore;
  final String? balanceAfter;
  final String? status;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  const TransactionModel({
    this.id,
    this.transactionId,
    this.userId,
    this.orderId,
    this.type,
    this.amount,
    this.balanceBefore,
    this.balanceAfter,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionId: json['transaction_id'],
      userId: json['user_id'],
      orderId: json['order_id'],
      type: json['type'],
      amount: json['amount']?.toString(),
      balanceBefore: json['balance_before']?.toString(),
      balanceAfter: json['balance_after']?.toString(),
      status: json['status'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'user_id': userId,
      'order_id': orderId,
      'type': type,
      'amount': amount,
      'balance_before': balanceBefore,
      'balance_after': balanceAfter,
      'status': status,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        transactionId,
        userId,
        orderId,
        type,
        amount,
        balanceBefore,
        balanceAfter,
        status,
        description,
        createdAt,
        updatedAt,
      ];
}
