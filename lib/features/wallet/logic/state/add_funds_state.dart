import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/add_funds_model.dart';

sealed class AddFundsState {
  const AddFundsState();
}

final class AddFundsInitial extends AddFundsState {}

final class AddFundsLoading extends AddFundsState {}

final class AddFundsSuccess extends AddFundsState {
  final AddFundsResponseModel response;
  const AddFundsSuccess(this.response);
}

final class AddFundsError extends AddFundsState {
  final ErrorEntity error;
  const AddFundsError(this.error);
}
