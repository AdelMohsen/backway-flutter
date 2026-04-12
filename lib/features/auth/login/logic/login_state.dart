import '../../../../core/shared/entity/error_entity.dart';
import '../data/model/login_model.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class IsValidPhoneNumber extends LoginState {
  const IsValidPhoneNumber(this.isValid);
  final bool isValid;
}

final class SendOtpLoading extends LoginState {
  const SendOtpLoading();
}

final class SendOtpSuccess extends LoginState {
  const SendOtpSuccess(this.data);
  final LoginModel data;
}

final class SendOtpError extends LoginState {
  const SendOtpError(this.error);
  final ErrorEntity error;
}
