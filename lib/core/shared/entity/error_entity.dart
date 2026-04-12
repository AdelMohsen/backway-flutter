import 'package:equatable/equatable.dart';

class ErrorEntity extends Equatable {
  const ErrorEntity({
    required this.statusCode,
    required this.message,
    required this.errors,
  });
  final int statusCode;
  final String message;
  final List<String>? errors;

  @override
  List<Object?> get props => [statusCode, message, errors];
}
