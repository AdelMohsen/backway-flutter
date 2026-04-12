import 'package:greenhub/features/orders/data/models/orders_model.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';

sealed class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;
  final int selectedTabIndex; // 0: new, 1: in_progress, 2: completed
  final bool hasReachedMax;
  final int currentPage;

  OrdersLoaded({
    required this.orders,
    required this.selectedTabIndex,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  OrdersLoaded copyWith({
    List<OrderModel>? orders,
    int? selectedTabIndex,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return OrdersLoaded(
      orders: orders ?? this.orders,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class OrdersPaginationLoading extends OrdersLoaded {
  OrdersPaginationLoading({
    required super.orders,
    required super.selectedTabIndex,
    required super.hasReachedMax,
    required super.currentPage,
  });
}

class OrdersError extends OrdersState {
  final ErrorEntity message;
  final int selectedTabIndex;

  OrdersError(this.message, this.selectedTabIndex);
}
