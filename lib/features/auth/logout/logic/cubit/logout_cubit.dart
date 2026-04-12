import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/toast/toast_service.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/utility.dart';
import '../../data/params/logout_params.dart';
import '../../data/repository/logout_repo.dart';
import '../state/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(const LogoutInitial());

  static LogoutCubit get(context) => BlocProvider.of(context);

  //----------------------------------REQUEST-----------------------------------//
  Future<void> logout(BuildContext context) async {
    emit(const LogoutLoading());

    const params = LogoutParams();

    final response = await LogoutRepo.logout(params);
    response.fold(
      (failure) {
        ToastService.showError(failure.message, context);
        emit(LogoutError(failure));
      },
      (success) {
        ToastService.showSuccess(AppStrings.loggedOutSuccessfully.tr, context);
        Utility.logout(context: context);
        emit(LogoutSuccess(success));
      },
    );
  }
}
