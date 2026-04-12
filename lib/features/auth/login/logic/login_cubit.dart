import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validations/vaildator.dart';
import '../data/params/login_params.dart';
import '../data/repo/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  //---------------------------------VARIABLES----------------------------------//
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValidPhone = false;

  //---------------------------------FUNCTIONS----------------------------------//
  @override
  Future<void> close() {
    phone.dispose();
    return super.close();
  }

  void isValidPhoneFunction() {
    if (PhoneValidator.phoneValidator(phone.text) == null) {
      isValidPhone = true;
      emit(const IsValidPhoneNumber(true));
    } else {
      isValidPhone = false;
      emit(const IsValidPhoneNumber(false));
    }
  }

  bool isLoginValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

  //----------------------------------REQUEST-----------------------------------//
  Future<void> sendOtpStatesHandled({String? phoneNumber}) async {
    emit(const SendOtpLoading());
    final response = await LoginRepo.sendOtp(
      LoginParams(phoneNumber: phoneNumber ?? phone.text),
    );
    response.fold(
      (failure) {
        return emit(SendOtpError(failure));
      },
      (success) async {
        return emit(SendOtpSuccess(success));
      },
    );
  }
}
