import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/orders/data/models/orders_model.dart';
import 'package:greenhub/features/orders/data/params/orders_params.dart';
import 'package:greenhub/features/orders/data/repository/orders_repository.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  static int nextInitialTabIndex = 0;

  OrdersCubit() : super(OrdersInitial()) {
    _selectedTabIndex = nextInitialTabIndex;
    // Reset to default for next instances
    nextInitialTabIndex = 0;
  }

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  Future<void> loadOrders({bool isRefresh = false}) async {
    if (state is OrdersLoading) return;

    if (isRefresh || state is OrdersInitial || state is OrdersError) {
      emit(OrdersLoading());
    } else if (state is OrdersLoaded) {
      final currentState = state as OrdersLoaded;
      if (currentState.hasReachedMax) return;
      emit(OrdersPaginationLoading(
        orders: currentState.orders,
        selectedTabIndex: currentState.selectedTabIndex,
        hasReachedMax: currentState.hasReachedMax,
        currentPage: currentState.currentPage,
      ));
    }

    int page = 1;
    List<OrderModel> currentOrders = [];
    if (state is OrdersPaginationLoading) {
      final currentState = state as OrdersPaginationLoading;
      page = currentState.currentPage + 1;
      currentOrders = currentState.orders;
    }

    String status = _getStatusFromIndex(_selectedTabIndex);

    final result = await OrdersRepository.getOrders(OrdersParams(
      page: page,
      perPage: 15,
      status: status,
    ));

    if (isClosed) return;

    result.fold(
      (error) {
        emit(OrdersError(error, _selectedTabIndex));
      },
      (response) {
        final newOrders = response.data ?? [];
        final isLastPage = (response.pagination?.currentPage ?? 1) >=
            (response.pagination?.lastPage ?? 1);

        emit(OrdersLoaded(
          orders: page == 1 ? newOrders : [...currentOrders, ...newOrders],
          selectedTabIndex: _selectedTabIndex,
          hasReachedMax: isLastPage,
          currentPage: response.pagination?.currentPage ?? 1,
        ));
      },
    );
  }

  void changeTab(int index) {
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    loadOrders(isRefresh: true);
  }

  Future<void> onRefresh() async {
    await loadOrders(isRefresh: true);
  }

  String _getStatusFromIndex(int index) {
    switch (index) {
      case 0:
        return 'new'; // AppStrings.scheduled
      case 1:
        return 'in_progress'; // AppStrings.inTransit
      case 2:
        return 'completed'; // AppStrings.previous
      default:
        return 'in_progress';
    }
  }
}
