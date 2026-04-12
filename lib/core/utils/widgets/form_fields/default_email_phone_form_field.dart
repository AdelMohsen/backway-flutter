import 'package:flutter/material.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/vaildator.dart';
import 'default_form_field.dart';

class DefaultEmailPhoneFormField extends StatelessWidget {
  const DefaultEmailPhoneFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    //default 24.sp
    this.titleIconSize,
    //default 24.r
    this.borderRadious,
    this.controller,
    this.readOnly = false,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      hintStyle: AppTextStyles.bodySmMedium.copyWith(
        fontSize: hintFontSize ?? 14,
        color: const Color.fromRGBO(210, 210, 210, 1),
      ),
      style: AppTextStyles.bodySmMedium.copyWith(
        fontSize: titleFontSize ?? 14,
        color: const Color.fromRGBO(114, 48, 134, 1),
      ),
      labelStyle: AppTextStyles.bodySmMedium.copyWith(
        fontSize: hintFontSize ?? 14,
        color: const Color.fromRGBO(210, 210, 210, 1),
      ),
      hintText: AppStrings.emailOrPhoneNumber.tr,
      fillColor: const Color.fromRGBO(248, 248, 248, 1),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.pleaseEnterAValidEmailAddressOrPhoneNumber.tr;
        }
        if (RegExp(r'^[0-9]+$').hasMatch(value)) {
          return PhoneValidator.phoneValidator(value);
        } else {
          return EmailValidator.emailValidator(value);
        }
      },
      cursorColor: const Color.fromRGBO(114, 48, 134, 1),
      foucsBorderColor: const Color.fromRGBO(114, 48, 134, 1),
      borderRadious: borderRadious ?? 8,
      keyboardType: TextInputType.text,
      controller: controller,
      textAlign: TextAlign.start,
      onTapOutside: (p0) {},
      readOnly: readOnly,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
