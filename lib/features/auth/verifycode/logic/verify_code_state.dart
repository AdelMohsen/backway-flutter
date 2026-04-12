import '../../../../../core/shared/entity/error_entity.dart';
import '../../login/data/model/login_model.dart';
import '../data/model/verify_otp_then_login_model.dart';

sealed class VerifyCodeState {
  const VerifyCodeState();
}

final class VerifyCodeInitial extends VerifyCodeState {}

// Timer states
final class TimerTick extends VerifyCodeState {
  const TimerTick(this.secondsRemaining, this.isResendActive);
  final int secondsRemaining;
  final bool isResendActive;
}

// Resend OTP states
final class ResendOtpLoading extends VerifyCodeState {
  const ResendOtpLoading();
}

final class ResendOtpSuccess extends VerifyCodeState {
  const ResendOtpSuccess(this.data);
  final LoginModel data;
}

final class ResendOtpError extends VerifyCodeState {
  const ResendOtpError(this.error);
  final ErrorEntity error;
}

// Verify OTP states
final class VerifyOtpLoading extends VerifyCodeState {
  const VerifyOtpLoading();
}

final class VerifyOtpSuccess extends VerifyCodeState {
  const VerifyOtpSuccess(this.data);
  final VerifyOtpThenLoginModel data;
}

final class VerifyOtpError extends VerifyCodeState {
  const VerifyOtpError(this.error);
  final ErrorEntity error;
}

// Change Phone Number states
final class ChangePhoneLoading extends VerifyCodeState {
  const ChangePhoneLoading();
}

final class ChangePhoneSuccess extends VerifyCodeState {
  const ChangePhoneSuccess(this.data, this.newPhoneNumber);
  final LoginModel data;
  final String newPhoneNumber;
}

final class ChangePhoneError extends VerifyCodeState {
  const ChangePhoneError(this.error);
  final ErrorEntity error;
}
