import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/toast/toast_service.dart';
import '../../../../../core/utils/utility.dart';
import '../../data/params/delete_account_params.dart';
import '../../data/repository/delete_account_repo.dart';
import '../state/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(const DeleteAccountInitial());

  static DeleteAccountCubit get(context) => BlocProvider.of(context);

  //----------------------------------REQUEST-----------------------------------//
  Future<void> deleteAccount(BuildContext context) async {
    emit(const DeleteAccountLoading());

    const params = DeleteAccountParams();

    final response = await DeleteAccountRepo.deleteAccount(params);
    response.fold(
      (failure) {
        ToastService.showError(failure.message, context);
        emit(DeleteAccountError(failure));
      },
      (success) {
        // As defined in app_strings.dart, using a success message directly mapped via model if present,
        // or a fallback hardcoded translation since we didn't specify one strictly for deletion outside.
        ToastService.showSuccess(
          success.message ?? "Account deleted successfully",
          context,
        );
        Utility.logout(context: context);
        emit(DeleteAccountSuccess(success));
      },
    );
  }
}
