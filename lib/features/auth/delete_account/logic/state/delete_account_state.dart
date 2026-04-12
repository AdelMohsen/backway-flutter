import 'package:equatable/equatable.dart';

import '../../../../../core/shared/entity/error_entity.dart';
import '../../data/models/delete_account_model.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

final class DeleteAccountInitial extends DeleteAccountState {
  const DeleteAccountInitial();
}

final class DeleteAccountLoading extends DeleteAccountState {
  const DeleteAccountLoading();
}

final class DeleteAccountSuccess extends DeleteAccountState {
  final DeleteAccountModel deleteAccountModel;

  const DeleteAccountSuccess(this.deleteAccountModel);

  @override
  List<Object> get props => [deleteAccountModel];
}

final class DeleteAccountError extends DeleteAccountState {
  final ErrorEntity error;

  const DeleteAccountError(this.error);

  @override
  List<Object> get props => [error];
}
