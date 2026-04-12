import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/params/add_funds_params.dart';
import '../../data/repository/add_funds_repo.dart';
import '../state/add_funds_state.dart';

class AddFundsCubit extends Cubit<AddFundsState> {
  AddFundsCubit() : super(AddFundsInitial());

  Future<void> addFunds({
    required double amount,
    required String paymentMethod,
  }) async {
    emit(AddFundsLoading());

    final params = AddFundsParams(
      amount: amount,
      paymentMethod: paymentMethod,
    );

    final result = await AddFundsRepo.addFunds(params);
    result.fold(
      (error) => emit(AddFundsError(error)),
      (response) => emit(AddFundsSuccess(response)),
    );
  }
}
