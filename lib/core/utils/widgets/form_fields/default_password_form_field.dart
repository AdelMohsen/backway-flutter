import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../validations/vaildator.dart';
import 'default_form_field.dart';

class DefaultPasswordFormField extends StatefulWidget {
  const DefaultPasswordFormField({
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
    this.titleText,
    this.hintText,
    this.validator,
    this.readOnly = false,
    this.needValidation = true,
    this.onChanged,
    this.showPasswordGuidelines = false,
    this.passwordGuidelinesFontSize,
    this.onSaved,
    this.fillColor,
    this.borderColor,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? passwordGuidelinesFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final String? titleText;
  final String? hintText;
  final String? Function(String? value)? validator;
  final bool readOnly;
  final bool needValidation;
  final void Function(String value)? onChanged;
  final bool showPasswordGuidelines;
  final void Function(String?)? onSaved;
  final Color? fillColor;
  final Color? borderColor;
  @override
  State<DefaultPasswordFormField> createState() =>
      _DefaultPasswordFormFieldState();
}

class _DefaultPasswordFormFieldState extends State<DefaultPasswordFormField> {
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultFormField(
          enabled: true,
          fillColor: widget.fillColor ?? const Color.fromRGBO(255, 255, 255, 1),
          needValidation: widget.needValidation,
          hintText: widget.hintText,
          hintStyle: AppTextStyles.cairoW400Size12.copyWith(
            fontSize: widget.hintFontSize ?? 12,
            color: const Color.fromRGBO(187, 187, 187, 1),
          ),
          style: AppTextStyles.interW500Size20.copyWith(
            fontSize: widget.titleFontSize ?? 14,
          ),
          labelStyle: AppTextStyles.bodySmMedium.copyWith(
            fontSize: widget.titleFontSize ?? 14,
            color: const Color.fromRGBO(210, 210, 210, 1),
          ),
          // labelText: widget.titleText ?? AppStrings.password.tr,
          validator: widget.needValidation
              ? widget.validator ??
                    (value) => PasswordValidator.passwordValidator(value)
              : null,
          borderRadious: widget.borderRadious ?? 12,
          obscureText: isPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            icon: Icon(
              isPasswordVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              color: const Color.fromRGBO(172, 181, 187, 1),
              size: 18,
            ),
          ),
          controller: widget.controller,
          onTapOutside: (p0) {},
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          borderColor:
              widget.borderColor ?? const Color.fromRGBO(220, 220, 220, 1),
          enabledBorderColor: const Color.fromRGBO(220, 220, 220, 1),
          foucsBorderColor: const Color.fromRGBO(244, 158, 93, 0.7),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
          onSaved: widget.onSaved,
          focusedErrorBorderColor: Colors.red,
        ),
        if (widget.showPasswordGuidelines)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: mainAppBloc.isArabic
                            ? 'يجب أن تتضمن “'
                            : '⬝ must include, ',
                        style: GoogleFonts.cairo(
                          fontSize: widget.passwordGuidelinesFontSize ?? 9,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(148, 148, 148, 1),
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 3)),
                      TextSpan(
                        text: mainAppBloc.isArabic
                            ? ' حرف كبير - حرف صغير - حرف خاص (#@!) - رقم'
                            : 'Capital letter - Lowercase letter - Special character (#@!) - Number',
                        style: GoogleFonts.cairo(
                          fontSize: widget.passwordGuidelinesFontSize ?? 9,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(105, 105, 105, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: mainAppBloc.isArabic
                            ? 'يجب أن لا تقل عن'
                            : '⬝ must include, ',
                        style: GoogleFonts.cairo(
                          fontSize: widget.passwordGuidelinesFontSize ?? 9,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(148, 148, 148, 1),
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 3)),
                      TextSpan(
                        text: mainAppBloc.isArabic
                            ? '٨ أحرف'
                            : 'Capital letter - Lowercase letter - Special character (#@!) - Number',
                        style: GoogleFonts.cairo(
                          fontSize: widget.passwordGuidelinesFontSize ?? 9,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(105, 105, 105, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
