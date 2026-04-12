import '../../../assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/vaildator.dart';
import '../text/main_text.dart';
import 'default_form_field.dart';

class DefaultPhoneFormField extends StatefulWidget {
  const DefaultPhoneFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    this.suffixIcon,
    this.style,
    //default 24.sp
    this.titleIconSize,
    //default 24.r
    this.borderRadious,
    this.controller,
    this.readOnly = false,
    this.needValidation,
    this.useGradientBorder = false,
    this.gradientColors,
    this.gradientBorderWidth = 1.5,
    this.gradientBegin,
    this.gradientEnd,
    this.onChanged,
    this.fillColor,
    this.borderColor,
    this.showCountryCode = true,
    this.titleStyle,
    this.hintStyle,
    this.hintText,
    this.titleText,
    this.enabeld = true,
    this.onSaved,

    this.contentPadding,
    this.validator,
    this.focusNode,
  });

  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final bool readOnly;
  final bool? needValidation;
  final bool useGradientBorder;
  final List<Color>? gradientColors;
  final TextStyle? style;
  final double gradientBorderWidth;
  final AlignmentGeometry? gradientBegin;
  final AlignmentGeometry? gradientEnd;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? borderColor;
  final bool showCountryCode;
  final TextStyle? titleStyle;
  final String? hintText;
  final Widget? suffixIcon;
  final String? titleText;
  final bool enabeld;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  State<DefaultPhoneFormField> createState() => _DefaultPhoneFormFieldState();
}

class _DefaultPhoneFormFieldState extends State<DefaultPhoneFormField> {
  String? errorText;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  Color _getBorderColor() {
    // Error state takes priority
    if (errorText != null) {
      return Colors.red;
    }
    // Focused state
    if (_isFocused) {
      return const Color.fromRGBO(244, 158, 93, 0.7);
    }
    // Normal state
    return widget.borderColor ?? const Color.fromRGBO(220, 220, 220, 1);
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadious ?? AppRadiuos.rS;

    if (!widget.useGradientBorder) {
      return Directionality(
        textDirection: mainAppBloc.isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: DefaultFormField(
          suffixIcon: widget.suffixIcon,
          focusNode: _focusNode,
          maxLines: 1,
          fillColor: widget.fillColor ?? const Color.fromRGBO(247, 247, 247, 1),
          hintStyle:
              widget.hintStyle ??
              AppTextStyles.cairoW400Size12.copyWith(
                fontSize: widget.hintFontSize ?? 12,
                color: const Color.fromRGBO(187, 187, 187, 1),
              ),
          style:
              widget.style ??
              AppTextStyles.interW500Size20.copyWith(
                fontSize: widget.titleFontSize ?? 14,
              ),
          labelStyle: AppTextStyles.bodySmMedium.copyWith(
            fontSize: widget.hintFontSize ?? 14,
            color: const Color.fromRGBO(210, 210, 210, 1),
          ),
          foucsBorderColor: AppColors.primaryGreenHub,
          titleStyle:
              widget.titleStyle ??
              AppTextStyles.cairoW500Size16.copyWith(
                fontSize: widget.titleFontSize,
              ),
          labelText: widget.titleText,
          borderColor: widget.borderColor ?? Colors.transparent,
          enabled: widget.enabeld,
          contentPadding:
              widget.contentPadding ??
              const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 28),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(AppImages.iconsudio, width: 32, height: 35),
                  Text(
                    "+${AppConstant.countryCode}",
                    style: AppTextStyles.cairoW400Size12.copyWith(
                      color: Color.fromRGBO(75, 75, 75, 1),
                    ),
                  ),
                ],
              ),
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(234, 234, 234, 1),
                ),
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          ),
          hintText: widget.hintText ?? AppStrings.phoneNumber.tr,
          validator: (value) {
            final error = widget.validator != null
                ? widget.validator!(value)
                : PhoneValidator.phoneValidator(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  errorText = error;
                });
              }
            });
            return error;
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          borderRadious: radius,
          keyboardType: TextInputType.phone,
          controller: widget.controller,
          needValidation: widget.needValidation,
          onTapOutside: (p0) {},
          textAlign: TextAlign.start,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          focusedErrorBorderColor: Colors.red,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8),
          child: Row(
            children: [
              MainText(
                text: 'AppStrings.phoneNumber.tr',
                style: AppTextStyles.bodySmMedium.copyWith(
                  fontSize: widget.titleFontSize,
                ),
              ),
              MainText(
                text: ' *',
                style: AppTextStyles.bodySmMedium.copyWith(
                  fontSize: widget.titleFontSize,
                  color: const Color.fromRGBO(208, 44, 76, 1),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.gradientBorderWidth),
            child: Container(
              decoration: BoxDecoration(
                color:
                    widget.fillColor ?? const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(
                  radius - widget.gradientBorderWidth / 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 53,
                    margin: const EdgeInsetsDirectional.only(
                      top: 1,
                      bottom: 1,
                      start: 16,
                      end: 4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.fillColor ?? AppColors.kWhite,
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(AppRadiuos.rS),
                        bottomStart: Radius.circular(AppRadiuos.rS),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: AlignmentDirectional.center,
                    child: Image.asset(AppImages.iconSaudio),
                  ),
                  Expanded(
                    child: DefaultFormField(
                      key: _fieldKey,
                      controller: widget.controller,
                      style: AppTextStyles.bodySmMedium.copyWith(
                        fontSize: widget.titleFontSize ?? 14,
                      ),
                      validator: (value) {
                        final error = widget.validator != null
                            ? widget.validator!(value)
                            : PhoneValidator.phoneValidator(value);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              errorText = error;
                            });
                          }
                        });
                        return error;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.phone,
                      readOnly: widget.readOnly,
                      fillColor:
                          widget.fillColor ??
                          const Color.fromRGBO(247, 247, 247, 1),
                      borderColor: widget.borderColor ?? Colors.transparent,
                      enabled: widget.enabeld,
                      onChanged: widget.onChanged,
                      enabledBorderColor: Colors.transparent,
                      foucsBorderColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16, top: 4),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
    );
  }
}
