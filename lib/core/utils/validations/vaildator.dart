import 'dart:async';

import 'package:flutter/material.dart';
import '../constant/app_strings.dart';
import '../extensions/extensions.dart';

class Validator {
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('ادخل البريد الإكتروني بشكل صحيح');
      }
    },
  );
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.length > 2) {
        sink.add(name);
      } else {
        sink.addError('ادخل الاسم بشكل صحيح');
      }
    },
  );

  var number = StreamTransformer<String, String>.fromHandlers(
    handleData: (String value, sink) {
      if (value.length > 9) {
        sink.add(value);
      } else {
        sink.addError('يجب ان يكون رقم الجوال من 10 خانات');
      }
    },
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 7) {
        sink.add(password);
      } else {
        sink.addError('يجب ان لا تقل كلمة المرور عن 8 خانات');
      }
    },
  );

  var confirmPassWordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 7) {
        sink.add(password);
      } else {
        sink.addError('تأكيد كلمة المرور خاطئ');
      }
    },
  );
}

class EmailValidator {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emailCannotBeEmptyPleaseEnterAValidEmail.tr;
    }

    // Remove leading/trailing whitespace
    email = email.trim();

    // Check for spaces anywhere in the email
    if (email.contains(' ')) {
      return AppStrings.emailCannotContainSpaces.tr;
    }

    // Check for basic structure (must contain exactly one @)
    if (!email.contains('@') || email.split('@').length != 2) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    final parts = email.split('@');
    final localPart = parts[0];
    final domainPart = parts[1];

    // Validate local part (before @)
    final localValidation = _validateLocalPart(localPart);
    if (localValidation != null) {
      return localValidation;
    }

    // Validate domain part (after @)
    final domainValidation = _validateDomainPart(domainPart);
    if (domainValidation != null) {
      return domainValidation;
    }

    return null;
  }

  static String? _validateLocalPart(String localPart) {
    // Local part cannot be empty
    if (localPart.isEmpty) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Local part cannot be longer than 64 characters
    if (localPart.length > 64) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Local part cannot start or end with a dot
    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Local part cannot have consecutive dots
    if (localPart.contains('..')) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Check for valid characters in local part
    final validLocalChars = RegExp(r'^[a-zA-Z0-9._%+-]+$');
    if (!validLocalChars.hasMatch(localPart)) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    return null;
  }

  static String? _validateDomainPart(String domainPart) {
    // Domain part cannot be empty
    if (domainPart.isEmpty) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Domain part cannot be longer than 253 characters
    if (domainPart.length > 253) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Domain part cannot start or end with a dot
    if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Domain part cannot have consecutive dots
    if (domainPart.contains('..')) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Domain part cannot start or end with a hyphen
    if (domainPart.startsWith('-') || domainPart.endsWith('-')) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Domain must contain at least one dot (for TLD)
    if (!domainPart.contains('.')) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Split domain into labels (parts separated by dots)
    final labels = domainPart.split('.');

    // Must have at least 2 labels (domain + TLD)
    if (labels.length < 2) {
      return AppStrings.pleaseEnterAValidEmailFormat.tr;
    }

    // Validate each label
    for (int i = 0; i < labels.length; i++) {
      final label = labels[i];

      // Each label cannot be empty
      if (label.isEmpty) {
        return AppStrings.pleaseEnterAValidEmailFormat.tr;
      }

      // Each label cannot be longer than 63 characters
      if (label.length > 63) {
        return AppStrings.pleaseEnterAValidEmailFormat.tr;
      }

      // Each label cannot start or end with a hyphen
      if (label.startsWith('-') || label.endsWith('-')) {
        return AppStrings.pleaseEnterAValidEmailFormat.tr;
      }

      // Check for valid characters in each label
      final validDomainChars = RegExp(r'^[a-zA-Z0-9-]+$');
      if (!validDomainChars.hasMatch(label)) {
        return AppStrings.pleaseEnterAValidEmailFormat.tr;
      }

      // TLD (last label) must be at least 2 characters and contain only letters
      if (i == labels.length - 1) {
        if (label.length < 2) {
          return AppStrings.pleaseEnterAValidEmailFormat.tr;
        }
        final tldPattern = RegExp(r'^[a-zA-Z]{2,}$');
        if (!tldPattern.hasMatch(label)) {
          return AppStrings.pleaseEnterAValidEmailFormat.tr;
        }
      }
    }

    return null;
  }
}

class PhoneValidator {
  static String? phoneValidator(String? phone, [String? dialCode]) {
    if (phone == null || phone.isEmpty) {
      return AppStrings.phoneCannotBeEmptyPleaseEnterAValidPhone.tr;
    }

    if (dialCode != null) {
      if (dialCode == '+966') {
        // Saudi Arabia mobile numbers start with 5 or 05
        if (!RegExp(r'^(5\d{8}|05\d{8})$').hasMatch(phone)) {
          return AppStrings.pleaseEnterAValidPhoneFormat.tr;
        }
      } else if (dialCode == '+20') {
        // Egypt mobile numbers start with 10, 11, 12, or 15 (10 digits) or 01... (11 digits)
        if (!RegExp(r'^(01[0125]\d{8}|1[0125]\d{8})$').hasMatch(phone)) {
          return AppStrings.pleaseEnterAValidPhoneFormat.tr;
        }
      } else {
        // General check for other countries: minimum 8 digits
        if (phone.length < 8 || !RegExp(r'^\d+$').hasMatch(phone)) {
          return AppStrings.pleaseEnterAValidPhoneFormat.tr;
        }
      }
    } else {
      // General check if no dialCode is provided: minimum 8 digits
      if (phone.length < 8 || !RegExp(r'^\d+$').hasMatch(phone)) {
        return AppStrings.pleaseEnterAValidPhoneFormat.tr;
      }
    }

    return null;
  }
}

class CountryCodeValidator {
  /// Pass the currently selected dial-code (e.g. "+1", "+966").
  /// Returns an error string if no valid country code is selected.
  static String? validate(String? dialCode) {
    if (dialCode == null || dialCode.trim().isEmpty || dialCode == '+0') {
      return AppStrings.validationSelectCountryCode.tr;
    }
    return null;
  }
}

class PasswordValidator {
  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.passwordCannotBeEmpty.tr;
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneUppercaseLetter.tr;
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneLowercaseLetter.tr;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneNumber.tr;
    }
    if (password.contains(' ')) {
      return AppStrings.yourPasswordCannotContainSpaces.tr;
    }
    if (password.length < 8) {
      return AppStrings.passwordIsTooShortItMustBeAtLeast8.tr;
    }

    final reg = RegExp(
      r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:'
      ',<>./?]',
    );

    if (!reg.hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneSpecialCharacter.tr;
    }

    return null;
  }
}

class PasswordConfirmationValidator {
  static String? passwordValidator(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppStrings.passwordCannotBeEmpty.tr;
    }
    if (password != confirmPassword) {
      return AppStrings.passwordsDonTMatchPleaseTryAgain.tr;
    }

    return null;
  }
}

class ChangePasswordConfirmationValidator {
  static String? passwordValidator(String? password, BuildContext context) {
    if (password == null || password.length < 6) {
      return AppStrings.confirmPassword.tr;
    }
    return null;
  }
}

class NameValidator {
  static String? nameValidator(var name) {
    if (name == null || name.length < 2) {
      return AppStrings.pleaseEnterValidUserName.tr;
    }
    return null;
  }
}

class TitleValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.length < 2) {
      return AppStrings.pleaseEnterValidTitle.tr;
    } else if (name.contains('٠١٥') ||
        name.contains('٠١٢') ||
        name.contains('٠١١') ||
        name.contains('٠١٠') ||
        name.contains('015') ||
        name.contains('012') ||
        name.contains('011') ||
        name.contains('010') ||
        name.contains('http://') ||
        name.contains('https://')) {
      return AppStrings.pleaseEnterValidTitleWithoutPhone.tr;
    }
    return null;
  }
}

class DescriptionValidator {
  static String? descriptionValidator(String? name) {
    if (name == null || name.length < 2) {
      return AppStrings.pleaseEnterValidDescription.tr;
    } else if (name.contains('٠١٥') ||
        name.contains('٠١٢') ||
        name.contains('٠١١') ||
        name.contains('٠١٠') ||
        name.contains('015') ||
        name.contains('012') ||
        name.contains('011') ||
        name.contains('010') ||
        name.contains('http://') ||
        name.contains('https://')) {
      return AppStrings.pleaseEnterValidDescriptionWithoutPhone.tr;
    }
    return null;
  }
}

class NoteValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.length < 2) {
      return AppStrings.pleaseEnterValidDescription.tr;
    }
    return null;
  }
}

class PriceValidator {
  static String? priceValidator(String? price) {
    if (price == null || double.tryParse(price) == null) {
      return AppStrings.pleaseEnterValidPrice.tr;
    }
    double doublePrice = double.parse(price);
    if (doublePrice < 1) {
      return AppStrings.pleaseEnterValidPrice.tr;
    }
    return null;
  }
}

class PriceToValidator {
  static String? priceValidator(
    String? price,
    String? stringPriceFrom,
    BuildContext context,
  ) {
    if (price == null || double.tryParse(price) == null) {
      return AppStrings.pleaseEnterValidPrice.tr;
    }
    double priceTo = double.parse(price);
    if (priceTo > 1) {
      if (stringPriceFrom == null || double.tryParse(stringPriceFrom) == null) {
        return null; // Or handle error
      }
      double priceFrom = double.parse(stringPriceFrom);
      if (priceTo < priceFrom) {
        return AppStrings.pleaseEnterValidPrice.tr;
      }
    } else {
      return AppStrings.pleaseEnterValidPrice.tr;
    }
    return null;
  }
}

class DiscountValidator {
  static String? discountValidator(String? discount) {
    if (discount == null ||
        discount.isEmpty ||
        double.tryParse(discount) == null ||
        double.parse(discount) > 100.00) {
      return AppStrings.pleaseEnterValidDiscount.tr;
    }
    return null;
  }
}

class LinkValidator {
  static String? linkValidator(String? link) {
    if (link == null || !link.contains('http')) {
      return AppStrings.pleaseEnterValidLink.tr;
    }
    return null;
  }
}

class AddressValidator {
  static String? addressValidator(var address) {
    if (address == null || address.length < 1) {
      return AppStrings.thisFieldIsRequired.tr;
    }
    return null;
  }
}

class DefaultValidator {
  static String? defaultValidator(var value) {
    if (value == null || value.length < 1) {
      return AppStrings.thisFieldIsRequired.tr;
    }
    return null;
  }
}
