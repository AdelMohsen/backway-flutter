import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/wallet_balance_model.dart';
import '../../data/models/wallet_transactions_model.dart';
import '../../data/params/wallet_balance_params.dart';
import '../../data/params/wallet_transactions_params.dart';
import '../../data/repository/wallet_balance_repo.dart';
import '../../data/repository/wallet_transactions_repo.dart';
import '../state/wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  List<WalletTransactionModel> _transactions = [];
  WalletBalanceResponseModel? _balanceData;
  int _currentPage = 1;
  int _lastPage = 1;
  int _total = 0;

  bool get hasMorePages => _currentPage < _lastPage;

  /// Fetch balance and first page of transactions together (initial load)
  Future<void> fetchWalletData({String? type}) async {
    emit(WalletLoading());
    _currentPage = 1;
    _transactions = [];
    _balanceData = null;

    final balanceResult =
        await WalletBalanceRepo.getBalance(const WalletBalanceParams());
    final transactionsResult =
        await WalletTransactionsRepo.getTransactions(WalletTransactionsParams(
      type: type,
      page: _currentPage,
    ));

    // If balance fails, emit error
    if (balanceResult.isLeft() && transactionsResult.isLeft()) {
      balanceResult.fold(
        (error) => emit(WalletError(error)),
        (_) {},
      );
      return;
    }

    balanceResult.fold(
      (_) {},
      (balanceResponse) => _balanceData = balanceResponse,
    );

    transactionsResult.fold(
      (error) => emit(WalletError(error)),
      (transactionsResponse) {
        _transactions = transactionsResponse.transactions ?? [];
        _currentPage = transactionsResponse.currentPage ?? 1;
        _lastPage = transactionsResponse.lastPage ?? 1;
        _total = transactionsResponse.total ?? 0;
        emit(WalletLoaded(
          balanceData: _balanceData,
          transactions: List.from(_transactions),
          currentPage: _currentPage,
          lastPage: _lastPage,
          total: _total,
        ));
      },
    );
  }

  /// Fetch next page (pagination)
  Future<void> fetchMoreTransactions({String? type}) async {
    if (!hasMorePages) return;
    if (state is WalletPaginationLoading) return;

    emit(WalletPaginationLoading(
      balanceData: _balanceData,
      transactions: List.from(_transactions),
      currentPage: _currentPage,
      lastPage: _lastPage,
      total: _total,
    ));

    final nextPage = _currentPage + 1;
    final result = await WalletTransactionsRepo.getTransactions(
      WalletTransactionsParams(type: type, page: nextPage),
    );

    result.fold(
      (error) {
        // On pagination error, keep existing data
        emit(WalletLoaded(
          balanceData: _balanceData,
          transactions: List.from(_transactions),
          currentPage: _currentPage,
          lastPage: _lastPage,
          total: _total,
        ));
      },
      (response) {
        _transactions.addAll(response.transactions ?? []);
        _currentPage = response.currentPage ?? nextPage;
        _lastPage = response.lastPage ?? _lastPage;
        _total = response.total ?? _total;
        emit(WalletLoaded(
          balanceData: _balanceData,
          transactions: List.from(_transactions),
          currentPage: _currentPage,
          lastPage: _lastPage,
          total: _total,
        ));
      },
    );
  }

  /// Pull-to-refresh: re-fetches both balance and transactions
  Future<void> onRefresh({String? type}) async {
    await fetchWalletData(type: type);
  }
}
