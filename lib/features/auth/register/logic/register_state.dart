import '../../../../core/shared/entity/error_entity.dart';
import '../data/model/register_model.dart';

sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess(this.data);
  final RegisterModel data;
}

final class RegisterError extends RegisterState {
  const RegisterError(this.error);
  final ErrorEntity error;
}

final class LocationDetecting extends RegisterState {
  const LocationDetecting();
}

final class LocationDetected extends RegisterState {
  const LocationDetected({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
  final double latitude;
  final double longitude;
  final String address;
}

final class LocationDetectFailed extends RegisterState {
  const LocationDetectFailed(this.message);
  final String message;
}
