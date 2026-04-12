import 'package:equatable/equatable.dart';
import '../../data/models/wallet_balance_model.dart';
import '../../data/models/wallet_transactions_model.dart';
import '../../../../core/shared/entity/error_entity.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletPaginationLoading extends WalletState {
  final WalletBalanceResponseModel? balanceData;
  final List<WalletTransactionModel> transactions;
  final int currentPage;
  final int lastPage;
  final int total;

  const WalletPaginationLoading({
    required this.balanceData,
    required this.transactions,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  @override
  List<Object?> get props =>
      [balanceData, transactions, currentPage, lastPage, total];
}

final class WalletLoaded extends WalletState {
  final WalletBalanceResponseModel? balanceData;
  final List<WalletTransactionModel> transactions;
  final int currentPage;
  final int lastPage;
  final int total;

  const WalletLoaded({
    this.balanceData,
    required this.transactions,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  @override
  List<Object?> get props =>
      [balanceData, transactions, currentPage, lastPage, total];
}

final class WalletError extends WalletState {
  final ErrorEntity error;
  const WalletError(this.error);

  @override
  List<Object?> get props => [error];
}
