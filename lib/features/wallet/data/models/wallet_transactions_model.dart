import 'package:equatable/equatable.dart';

class WalletTransactionsResponseModel extends Equatable {
  final bool? success;
  final int? currentPage;
  final List<WalletTransactionModel>? transactions;
  final int? lastPage;
  final int? perPage;
  final int? total;

  const WalletTransactionsResponseModel({
    this.success,
    this.currentPage,
    this.transactions,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory WalletTransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return WalletTransactionsResponseModel(
      success: json['success'],
      currentPage: data?['current_page'],
      transactions: data?['data'] != null
          ? List<WalletTransactionModel>.from(
              data['data'].map((x) => WalletTransactionModel.fromJson(x)),
            )
          : null,
      lastPage: data?['last_page'],
      perPage: data?['per_page'],
      total: data?['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'current_page': currentPage,
      'data': transactions?.map((x) => x.toJson()).toList(),
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }

  @override
  List<Object?> get props => [
        success,
        currentPage,
        transactions,
        lastPage,
        perPage,
        total,
      ];
}

class WalletTransactionModel extends Equatable {
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

  const WalletTransactionModel({
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

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
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
