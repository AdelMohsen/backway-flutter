import 'package:equatable/equatable.dart';

abstract class CompleteProfileState extends Equatable {
  const CompleteProfileState();

  @override
  List<Object?> get props => [];
}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {
  final String message;
  const CompleteProfileSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CompleteProfileError extends CompleteProfileState {
  final String message;
  const CompleteProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class FormValidationState extends CompleteProfileState {
  final bool isValid;
  const FormValidationState(this.isValid);

  @override
  List<Object?> get props => [isValid];
}
