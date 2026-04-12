import '../../services/error_handler/api_response_code.dart';
import 'error_entity.dart';

class InvalidJsonException implements Exception {
  final ErrorEntity error;
  InvalidJsonException(this.error);

  @override
  String toString() => 'InvalidJsonException: ${error.message}';
}

T parseJsonField<T>(Map<String, dynamic> json, String fieldName) {
  final value = json[fieldName];

  if (value is T) {
    return value;
  }

  throw InvalidJsonException(ErrorEntity(
    statusCode: ResponseCode.jsonValidationError,
    message: 'Field $fieldName is not of type $T',
    errors: [
      'Field $fieldName is not of type $T',
    ],
  ));
}
