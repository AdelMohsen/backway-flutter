import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/order_details/data/params/order_details_params.dart';
import 'package:greenhub/features/order_details/data/repository/order_details_repository.dart';
import 'package:greenhub/features/order_details/logic/state/order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());

  int? _currentOrderId;

  Future<void> fetchOrderDetails(int orderId, {bool isRefresh = false}) async {
    _currentOrderId = orderId;
    if (!isRefresh) {
      emit(OrderDetailsLoading());
    }

    final result = await OrderDetailsRepository.getOrderDetails(
      OrderDetailsParams(orderId: orderId),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(OrderDetailsError(error)),
      (response) {
        if (response.data != null) {
          emit(OrderDetailsLoaded(response.data!));
        } else {
          emit(OrderDetailsError(ErrorEntity(
            message: 'No data found',
            statusCode: 404,
            errors: const [],
          )));
        }
      },
    );
  }

  Future<void> onRefresh() async {
    if (_currentOrderId != null) {
      await fetchOrderDetails(_currentOrderId!, isRefresh: true);
    }
  }
}
