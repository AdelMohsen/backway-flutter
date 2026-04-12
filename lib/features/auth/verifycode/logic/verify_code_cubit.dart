import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/data/params/login_params.dart';
import '../data/params/verify_otp_then_login_params.dart';
import '../data/repo/verify_code_repo.dart';
import 'verify_code_state.dart';

import '../../../../../core/utils/enums/enums.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit({
    required String phoneNumber,
    required VerifyCodeFromScreen fromScreen,
  }) : _phoneNumber = phoneNumber,
       _fromScreen = fromScreen,
       super(VerifyCodeInitial()) {
    startTimer();
  }

  //---------------------------------VARIABLES----------------------------------//
  String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  final VerifyCodeFromScreen _fromScreen;
  VerifyCodeFromScreen get fromScreen => _fromScreen;

  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPhoneController = TextEditingController();
  final GlobalKey<FormState> changePhoneFormKey = GlobalKey<FormState>();
  Timer? _timer;
  int _secondsRemaining = 120; // 2 minutes
  bool isResendActive = false;

  //---------------------------------TIMER FUNCTIONS----------------------------------//
  void startTimer() {
    _secondsRemaining = 120;
    isResendActive = false;
    emit(TimerTick(_secondsRemaining, isResendActive));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        emit(TimerTick(_secondsRemaining, false));
      } else {
        _timer?.cancel();
        isResendActive = true;
        emit(TimerTick(0, true));
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  int get secondsRemaining => _secondsRemaining;

  //---------------------------------DISPOSE----------------------------------//
  @override
  Future<void> close() {
    _timer?.cancel();
    otpController.dispose();
    newPhoneController.dispose();
    return super.close();
  }

  //----------------------------------VERIFY OTP REQUEST-----------------------------------//
  Future<void> verifyOtpThenLogin() async {
    if (otpController.text.isEmpty || otpController.text.length < 6) {
      return;
    }

    emit(const VerifyOtpLoading());

    final params = VerifyOtpThenLoginParams(
      phoneNumber: phoneNumber,
      otp: otpController.text,
    );

    final response = await (fromScreen == VerifyCodeFromScreen.fromRegister
        ? VerifyCodeRepo.verifyRegisterOtp(params)
        : VerifyCodeRepo.verifyOtpThenLogin(params));

    await response.fold((failure) async {
      if (fromScreen == VerifyCodeFromScreen.fromLogin &&
          failure.statusCode == 403) {
        // Fallback to verify-register if account is not active
        final fallbackResponse = await VerifyCodeRepo.verifyRegisterOtp(params);
        fallbackResponse.fold(
          (fallbackFailure) => emit(VerifyOtpError(fallbackFailure)),
          (success) => emit(VerifyOtpSuccess(success)),
        );
      } else {
        emit(VerifyOtpError(failure));
      }
    }, (success) async => emit(VerifyOtpSuccess(success)));
  }

  //----------------------------------RESEND OTP REQUEST-----------------------------------//
  Future<void> resendOtp() async {
    if (!isResendActive) return;

    emit(const ResendOtpLoading());

    final response = await VerifyCodeRepo.resendOtp(
      LoginParams(phoneNumber: phoneNumber),
    );

    response.fold((failure) => emit(ResendOtpError(failure)), (success) {
      emit(ResendOtpSuccess(success));
      startTimer();
    });
  }

  //----------------------------------CHANGE PHONE NUMBER REQUEST-----------------------------------//
  Future<void> changePhoneNumber() async {
    if (!changePhoneFormKey.currentState!.validate()) {
      return;
    }

    final newPhone = newPhoneController.text.trim();
    if (newPhone.isEmpty) return;

    emit(const ChangePhoneLoading());

    final response = await VerifyCodeRepo.resendOtp(
      LoginParams(phoneNumber: newPhone),
    );

    response.fold((failure) => emit(ChangePhoneError(failure)), (success) {
      // Update phone number
      _phoneNumber = newPhone;
      // Clear OTP field
      otpController.clear();
      // Clear new phone field
      newPhoneController.clear();
      emit(ChangePhoneSuccess(success, newPhone));
      // Restart timer
      startTimer();
    });
  }
}
