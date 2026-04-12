import 'package:greenhub/core/theme/colors/styles.dart';

import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../theme/text_styles/text_styles.dart';
import '../../validations/vaildator.dart';
import 'default_form_field.dart';

class DefaultEmailFormField extends StatelessWidget {
  const DefaultEmailFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    //default 24.sp
    this.borderRadious,
    this.controller,
    this.readOnly = false,
    this.onSaved,
    this.titleText,
    this.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.fillColor,
    this.borderColor,
    this.textAlign,
    this.style,
    this.contentPadding,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readOnly;
  final void Function(String?)? onSaved;
  final String? titleText;
  final bool? enabled;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: titleText,
      contentPadding:
          contentPadding ??
          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 28),
      hintStyle: AppTextStyles.cairoW400Size12.copyWith(
        fontSize: hintFontSize ?? 12,
        color: const Color.fromRGBO(187, 187, 187, 1),
      ),
      style:
          style ??
          AppTextStyles.interW500Size20.copyWith(fontSize: titleFontSize ?? 14),
      labelStyle: AppTextStyles.bodySmMedium.copyWith(
        fontSize: hintFontSize ?? 14,
        color: const Color.fromRGBO(210, 210, 210, 1),
      ),
      hintText: AppStrings.emailHint.tr,
      fillColor: fillColor ?? const Color.fromRGBO(247, 247, 247, 1),
      validator: (value) => EmailValidator.emailValidator(value),
      borderRadious: borderRadious ?? 12,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,

      controller: controller,
      textAlign: textAlign ?? TextAlign.start,

      borderColor: borderColor ?? Colors.transparent,
      enabledBorderColor: Colors.transparent,
      foucsBorderColor: AppColors.primaryGreenHub,
      onSaved: onSaved,
      focusedErrorBorderColor: Colors.red,
    );
  }
}
