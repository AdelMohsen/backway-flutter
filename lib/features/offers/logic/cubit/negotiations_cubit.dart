import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/params/negotiations_params.dart';
import '../../data/repository/negotiations_repository.dart';
import '../state/negotiations_state.dart';

class NegotiationsCubit extends Cubit<NegotiationsState> {
  NegotiationsCubit() : super(NegotiationsInitial());

  List<dynamic> allNegotiations = [];

  Future<void> fetchNegotiations({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(NegotiationsLoading());
    }

    final params = const NegotiationsParams();
    
    final result = await NegotiationsRepository.getNegotiations(params);

    result.fold(
      (error) {
        if (!isClosed) emit(NegotiationsError(error));
      },
      (data) {
        allNegotiations = data;
        if (!isClosed) emit(NegotiationsSuccess(data));
      },
    );
  }

  Future<void> rejectNegotiation({
    required int orderId,
    required int negotiationId,
  }) async {
    emit(NegotiationRejectLoading());

    final result = await NegotiationsRepository.rejectNegotiation(
      orderId: orderId,
      negotiationId: negotiationId,
    );

    result.fold(
      (error) {
        if (!isClosed) emit(NegotiationRejectError(error));
      },
      (data) {
        if (!isClosed) {
          emit(NegotiationRejectSuccess(data));
          fetchNegotiations(isRefresh: true); // Auto refresh after success
        }
      },
    );
  }

  Future<void> acceptNegotiation({
    required int orderId,
    required int negotiationId,
  }) async {
    emit(NegotiationAcceptLoading());

    final result = await NegotiationsRepository.acceptNegotiation(
      orderId: orderId,
      negotiationId: negotiationId,
    );

    result.fold(
      (error) {
        if (!isClosed) emit(NegotiationAcceptError(error));
      },
      (data) {
        if (!isClosed) {
          emit(NegotiationAcceptSuccess(data));
          fetchNegotiations(isRefresh: true); // Auto refresh after success
        }
      },
    );
  }
}
