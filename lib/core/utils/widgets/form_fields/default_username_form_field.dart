import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import 'default_form_field.dart';

class DefaultUsernameFormField extends StatelessWidget {
  const DefaultUsernameFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    this.hintColor,
    //default 24.sp
    this.titleIconSize,
    this.fillColor,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    //default 24.r
    this.borderRadious,
    this.hintFontWeight,
    this.controller,
    this.readonly = false,
    this.needUserName = true,
    this.hintText,
    this.titleText,
    this.onSaved,
    this.contentPadding,
    this.borderColor,
    this.padding,
    this.validator,
    this.textAlign,
    this.height,
    this.style,
    this.foucsBorderColor,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final Color? fillColor;
  final Widget? prefixIcon;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readonly;
  final bool needUserName;
  final String? titleText;
  final String? hintText;
  final Widget? suffixIcon;

  final int? maxLines;
  final Color? hintColor;
  final void Function(String?)? onSaved;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final FontWeight? hintFontWeight;
  final TextAlign? textAlign;
  final double? height;
  final TextStyle? style;
  final Color? foucsBorderColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DefaultFormField(
        titleText: titleText,
        contentPadding:
            contentPadding ??
            const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 28),
        hintStyle: Styles.urbanistSize12w400White.copyWith(
          color: hintColor ?? const Color.fromRGBO(148, 163, 184, 1),
        ),
        style:
            style ??
            AppTextStyles.interW500Size20.copyWith(
              color: ColorsApp.subColor,
              fontSize: titleFontSize ?? 14,
            ),
        labelStyle: AppTextStyles.cairoW400Size12.copyWith(
          fontSize: hintFontSize ?? 14,
          color: const Color.fromRGBO(210, 210, 210, 1),
        ),
        hintText: hintText ?? AppStrings.firstName.tr,
        maxLines: maxLines,
        fillColor: fillColor ?? const Color.fromRGBO(247, 247, 247, 1),
        titleStyle: Styles.urbanistSize12w400White.copyWith(
          fontSize: titleFontSize,
        ),
        borderRadious: borderRadious ?? 12,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        controller: controller,
        textAlign: textAlign ?? TextAlign.start,
        readOnly: readonly,
        padding: padding,

        borderColor: borderColor ?? Colors.transparent,
        enabledBorderColor: borderColor ?? Colors.transparent,
        foucsBorderColor: foucsBorderColor ?? AppColors.primaryGreenHub,
        onSaved: onSaved,
        focusedErrorBorderColor: Colors.red,
        validator: validator,
      ),
    );
  }
}
