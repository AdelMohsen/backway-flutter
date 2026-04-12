import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/order_details/data/params/cancel_order_params.dart';
import 'package:greenhub/features/order_details/data/repository/cancel_order_repository.dart';
import 'package:greenhub/features/order_details/logic/state/cancel_order_state.dart';

class CancelOrderDetailsCubit extends Cubit<CancelOrderDetailsState> {
  CancelOrderDetailsCubit() : super(CancelOrderDetailsInitial());

  static CancelOrderDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> cancelOrder({
    required int orderId,
    required String reason,
  }) async {
    emit(CancelOrderDetailsLoading());

    final result = await CancelOrderDetailsRepository.cancelOrder(
      orderId: orderId,
      params: CancelOrderParams(reason: reason),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(CancelOrderDetailsError(error)),
      (response) => emit(CancelOrderDetailsSuccess(model: response)),
    );
  }
}
