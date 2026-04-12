import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/params/offers_params.dart';
import '../../data/repository/offers_repository.dart';
import '../state/offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  Future<void> getOffers({OffersParams? params}) async {
    emit(OffersLoading());
    final response = await OffersRepository.getOffers(
      params ?? const OffersParams(),
    );
    response.fold(
      (failure) => emit(OffersError(failure)),
      (success) => emit(OffersSuccess(success)),
    );
  }
}
