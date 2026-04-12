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
  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return AppStrings.phoneCannotBeEmptyPleaseEnterAValidPhone.tr;
    }

    // Remove spaces and dashes
    String normalizedPhone = phone.replaceAll(RegExp(r'[\s\-]'), '');

    // Remove leading + if present
    if (normalizedPhone.startsWith('+')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    String localNumber;

    if (normalizedPhone.startsWith('966')) {
      if (normalizedPhone.length == 12) {
        localNumber = normalizedPhone.substring(3); // Remove '966'
      } else {
        return AppStrings.pleaseEnterAValidPhoneFormat.tr;
      }
    } else if (normalizedPhone.startsWith('05')) {
      // Local format with leading zero: 05XXXXXXXX (10 digits)
      if (normalizedPhone.length == 10) {
        localNumber = normalizedPhone.substring(1); // Remove leading '0'
      } else {
        return AppStrings.pleaseEnterAValidPhoneFormat.tr;
      }
    } else if (normalizedPhone.startsWith('5')) {
      // Direct format: 5XXXXXXXX (9 digits)
      if (normalizedPhone.length == 9) {
        localNumber = normalizedPhone;
      } else {
        return AppStrings.pleaseEnterAValidPhoneFormat.tr;
      }
    } else {
      return AppStrings.pleaseEnterAValidPhoneFormat.tr;
    }

    // Validate the local part: must be 5 followed by 8 digits
    final phoneReg = RegExp(r'^5[0-9]{8}$');
    if (!phoneReg.hasMatch(localNumber)) {
      return AppStrings.pleaseEnterAValidPhoneFormat.tr;
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
    if (password!.length < 6) {
      return 'confirm_password'.tr;
    }
    // else if (password != context.read<PasswordBloc>().newPassword.value) {
    //   ext('confirmed_password_match_password'.tr;
    // }
    return null;
  }
}

class NameValidator {
  static String? nameValidator(var name) {
    if (name!.length < 2) {
      return 'please_enter_valid_user_name'.tr;
    }
    return null;
  }
}

class TitleValidator {
  static String? nameValidator(String? name) {
    if (name!.length < 2) {
      return 'please_enter_valid_title'.tr;
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
      return 'please_enter_valid_title_without_phone'.tr;
    }
    return null;
  }
}

class DescriptionValidator {
  static String? descriptionValidator(String? name) {
    // String pattern = '^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z][0-9]{5}*\$';
    // String pattern = '[a-z]+^[0-9]{5}\$';
    // String pattern = '^[A-Z]{3}[A-Z]{3}[0-9]{4}\$';
    //  RegExp regExp = RegExp(pattern);
    //  if (!regExp.hasMatch(name.trim())) {
    //    cprint("RegExp Name : "+name);
    //    ext("please_enter_valid_description".tr;
    //  }
    if (name!.length < 2) {
      return 'please_enter_valid_description'.tr;
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
      return 'please_enter_valid_description_without_phone'.tr;
    }
    return null;
  }
}

class NoteValidator {
  static String? nameValidator(String? name) {
    if (name!.length < 2) {
      return 'please_enter_valid_description'.tr;
    }
    return null;
  }
}

class PriceValidator {
  static String? priceValidator(String? price) {
    double doublePrice = double.parse(price!);
    if (doublePrice < 1) {
      return 'please_enter_valid_price'.tr;
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
    double priceTo = double.parse(price!);
    if (priceTo > 1) {
      double priceFrom = double.parse(stringPriceFrom!);
      if (priceTo < priceFrom) {
        return 'please_enter_valid_price'.tr;
      }
    } else {
      return 'please_enter_valid_price'.tr;
    }
    return null;
  }
}

class DiscountValidator {
  static String? discountValidator(String? discount) {
    if (discount!.isEmpty || double.parse(discount) > 100.00) {
      return 'please_enter_valid_discount'.tr;
    }
    return null;
  }
}

class LinkValidator {
  static String? linkValidator(String? link) {
    if (!link!.contains('http')) {
      return 'please_enter_valid_link'.tr;
    }
    return null;
  }
}

class AddressValidator {
  static String? addressValidator(var address) {
    if (address!.length < 1) {
      return 'this_field_is_required'.tr;
    }
    return null;
  }
}

class DefaultValidator {
  static String? defaultValidator(var value) {
    if (value!.length < 1) {
      return 'this_field_is_required'.tr;
    }
    return null;
  }
}
