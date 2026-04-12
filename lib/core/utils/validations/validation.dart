import '../constant/app_strings.dart';
import '../extensions/extensions.dart';

// validateEmail(String? value) {
//   String pattern =
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$';
//   RegExp regex = RegExp(pattern);
//   if (value == null || value.isEmpty || !regex.hasMatch(value)) {
//     return AppStrings.enterValidEmailAddress.tr;
//   } else if (!value.contains('.')) {
//     return AppStrings.enterValidEmailAddress.tr;
//   } else {
//     return null;
//   }
// }

// validatePassword(String? value) {
//   RegExp regex =
//       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   if (value!.isEmpty) {
//     return 'AppStrings.passwordValidationMessage.tr()';
//   } else {
//     if (!regex.hasMatch(value)) {
//       return 'AppStrings.passwordValidationMessage.tr()';
//     } else {
//       return null;
//     }
//   }
// }

String? validatePhone(String? mobileNumber) {
  // Add your function code here!
  if (mobileNumber == null || mobileNumber.isEmpty) {
    return 'Mobile Number Is Required'.tr;
  }
  RegExp regex = RegExp(r'^(\+201|01|00201)[0-2,5]{1}[0-9]{8}$');
  if (!regex.hasMatch(mobileNumber)) {
    return 'Mobile Number Is Not Valid'.tr;
  } else {
    return null;
  }
}

Map<String, dynamic> checkPasswordStrengthAction(String? enteredPassword) {
  if (enteredPassword == null || enteredPassword.isEmpty) {
    return {};
  }
  final bool more8Char = (enteredPassword.length > 8) ? true : false;
  final bool upper = (enteredPassword.contains(RegExp(r'[A-Z]')) &&
          enteredPassword.contains(RegExp(r'[a-z]')))
      ? true
      : false;
  final bool digits =
      (enteredPassword.contains(RegExp(r'[0-9]'))) ? true : false;
  final bool hasSpecialChar = (enteredPassword
          .contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:' ',<>./?]')))
      ? true
      : false;
  final Map<String, bool> finalList = {
    'hasMore8Char': more8Char,
    'hasUpper': upper,
    'hasDigits': digits,
    'hasSpecialChar': hasSpecialChar,
    'accepted': more8Char && upper && hasSpecialChar && digits ? true : false,
  };
  return finalList;
}

/// Validates a credit card number using the Luhn algorithm
String? validateCreditCard(String? value) {
  if (value == null || value.isEmpty) {
    return '${'AppStrings.cardNumber.tr'} ${'is required'.tr}';
  }
  
  // Remove any spaces or dashes
  String cleanValue = value.replaceAll(RegExp(r'[\s-]'), '');
  
  // Check if it contains only digits
  if (!RegExp(r'^\d+$').hasMatch(cleanValue)) {
    return '${'AppStrings.cardNumber.tr'} ${'should only contain digits'.tr}';
  }
  
  // Check length (most credit cards are between 13-19 digits)
  if (cleanValue.length < 13 || cleanValue.length > 19) {
    return '${'AppStrings.cardNumber.tr'} ${'has an invalid length'.tr}';
  }

  // Luhn Algorithm validation
  bool isValid = _validateWithLuhnAlgorithm(cleanValue);
  if (!isValid) {
    return '${'AppStrings.cardNumber.tr'} ${'is invalid'.tr}';
  }
  
  return null;
}

/// Validates credit card expiration date in MM/YY format
String? validateExpiryDate(String? value) {
  if (value == null || value.isEmpty) {
    return '${'AppStrings.expirationDate.tr'} ${'is required'.tr}';
  }
  
  // Check if the format is correct (MM/YY)
  if (!RegExp(r'^(0[1-9]|1[0-2])/([0-9]{2})$').hasMatch(value)) {
    return '${'AppStrings.expirationDate.tr'} ${'should be in MM/YY format'.tr}';
  }
  
  // Extract month and year
  List<String> parts = value.split('/');
  int month = int.parse(parts[0]);
  int year = int.parse(parts[1]) + 2000; // Convert YY to 20YY
  
  // Get current date
  final now = DateTime.now();
  final currentMonth = now.month;
  final currentYear = now.year;
  
  // Check if the card is expired
  if (year < currentYear || (year == currentYear && month < currentMonth)) {
    return '${'AppStrings.expirationDate.tr'} ${'has expired'.tr}';
  }
  
  // Check if the date is too far in the future (typically cards are valid for max 10 years)
  if (year > currentYear + 10) {
    return '${'AppStrings.expirationDate.tr'} ${'is too far in the future'.tr}';
  }
  
  return null;
}

/// Implementation of the Luhn algorithm for card validation
bool _validateWithLuhnAlgorithm(String cardNumber) {
  int sum = 0;
  bool alternate = false;
  
  // Process from right to left
  for (int i = cardNumber.length - 1; i >= 0; i--) {
    int digit = int.parse(cardNumber[i]);
    
    if (alternate) {
      digit *= 2;
      if (digit > 9) digit -= 9;
    }
    
    sum += digit;
    alternate = !alternate;
  }
  
  return sum % 10 == 0;
}
