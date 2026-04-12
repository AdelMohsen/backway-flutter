import '../../utils/utility.dart';
import '../entity/error_entity.dart';

class ErrorModel extends ErrorEntity {
  const ErrorModel({
    required super.statusCode,
    required super.message,
    required super.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    List<String> errorsList = [];

    // Handle errors field
    if (json['errors'] != null) {
      if (checkFromArray(json['errors'])) {
        // Case 1: errors is an array of strings
        errorsList = List<String>.from(json['errors']);
      } else if (json['errors'] is Map) {
        // Case 2: errors is a map with unknown keys
        // Example: {"phone": ["error1", "error2"], "email": "error3"}
        final errorsMap = json['errors'] as Map<String, dynamic>;

        errorsMap.forEach((key, value) {
          if (value is List) {
            // If value is a list, add all items prefixed with the key (field name)
            for (var item in value) {
              errorsList.add('$key: ${item.toString()}');
            }
          } else if (value is String) {
            // If value is a string, add it prefixed with the key
            errorsList.add('$key: $value');
          }
        });
      }
    }

    // Prioritize specific validation errors over generic messages
    String? message = json['message'];
    final bool isGenericValidation =
        message == 'Validation failed' ||
        message == 'The given data was invalid.' ||
        message == 'فشل التحقق من البيانات' ||
        message == null;

    if (isGenericValidation && errorsList.isNotEmpty) {
      // Join all errors with newlines for a complete message
      message = errorsList.join('\n');
    }

    return ErrorModel(
      statusCode: statusCode ?? -1000,
      message: message ?? (errorsList.isNotEmpty ? errorsList.first : 'null'),
      errors: errorsList,
    );
  }
}
