import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/vaildator.dart';

import '../../models/country.dart';
import 'default_form_field.dart';
import 'custom_country_picker_modal.dart';

class DefaultPhoneFormField extends StatefulWidget {
  const DefaultPhoneFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    this.prefixIcon,
    //default 24.sp
    this.titleIconSize,
    //default 24.r
    this.borderRadious,
    this.controller,
    this.readOnly = false,
    this.needValidation,
    this.contentPadding,
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
    this.validator,
    this.style,
    this.labelInsideBorder = false,
    this.showCountryPicker = false,
    this.initialCountryCode,
    this.onCountryChanged,
    this.onFormattedChanged,
    this.keyboardType = TextInputType.phone,
  });

  final String? Function(String?)? validator;

  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadious;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool labelInsideBorder;
  final TextEditingController? controller;
  final bool readOnly;
  final bool? needValidation;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onFormattedChanged;
  final Color? fillColor;
  final Color? borderColor;
  final bool showCountryCode;
  final bool showCountryPicker;
  final String? initialCountryCode;
  final void Function(Country)? onCountryChanged;
  final TextStyle? titleStyle;
  final String? hintText;
  final String? titleText;
  final Widget? prefixIcon;
  final bool enabeld;
  final void Function(String?)? onSaved;
  final TextInputType keyboardType;

  @override
  State<DefaultPhoneFormField> createState() => _DefaultPhoneFormFieldState();
}

class _DefaultPhoneFormFieldState extends State<DefaultPhoneFormField> {
  String? errorText;
  String? countryError;

  late FocusNode _focusNode;
  bool _isFocused = false;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    final String initialCodeStr =
        widget.initialCountryCode ?? AppConstant.countryCode;
    _selectedCountry = Country.parse(initialCodeStr);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void didUpdateWidget(covariant DefaultPhoneFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCountryCode != oldWidget.initialCountryCode &&
        widget.initialCountryCode != null) {
      setState(() {
        _selectedCountry = Country.parse(widget.initialCountryCode!);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  Color _getBorderColor() {
    // Error state takes priority
    if (errorText != null) {
      return Colors.red;
    }
    // Focused state
    if (_isFocused) {
      return ColorsApp.KorangePrimary;
    }
    // Normal state
    return widget.borderColor ?? const Color.fromRGBO(220, 220, 220, 1);
  }

  Widget _buildCountryPicker() {
    return GestureDetector(
      onTap: () {
        CustomCountryPickerModal.show(
          context,
          selectedCountryCode: _selectedCountry.code,
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = country;
            });
            if (widget.onCountryChanged != null) {
              widget.onCountryChanged!(_selectedCountry);
            }
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        height: 50,

        decoration: BoxDecoration(
          color: widget.fillColor ?? const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(widget.borderRadious ?? 26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Flag in circle with lavender border
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromRGBO(210, 210, 230, 0.5),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  _selectedCountry.flagEmoji,
                  style: Styles.urbanistSize12w400White.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            /// Dial Code
            Text(
              _selectedCountry.dialCode,
              style: Styles.urbanistSize12w400White.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(115, 115, 115, 1),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnChanged(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    if (widget.onFormattedChanged != null) {
      widget.onFormattedChanged!('${_selectedCountry.dialCode}$value');
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadious ?? AppRadiuos.rS;

    Widget standardContent = (() {
      Widget content;
      if (widget.labelInsideBorder) {
        content = Container(
          height: 57,
          decoration: BoxDecoration(
            color: widget.fillColor ?? Colors.white,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: _getBorderColor(), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.titleText != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10, start: 16),
                  child: Text(
                    widget.titleText!,
                    style:
                        widget.titleStyle ??
                        GoogleFonts.ibmPlexSansArabic(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ).copyWith(color: const Color.fromRGBO(71, 85, 105, 1)),
                  ),
                ),
              DefaultFormField(
                focusNode: _focusNode,
                maxLines: 1,
                fillColor: Colors.transparent,
                style:
                    widget.style ??
                    Styles.urbanistSize12w400White.copyWith(
                      color: ColorsApp.kPrimary,
                    ),
                hintStyle:
                    widget.hintStyle ??
                    Styles.urbanistSize12w400White.copyWith(
                      color: const Color.fromRGBO(148, 163, 184, 1),
                    ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorStyle: const TextStyle(fontSize: 0, height: 0),
                  contentPadding:
                      widget.contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  isDense: true,
                ),
                enabled: widget.enabeld,
                validator: (value) {
                  final error = (widget.validator != null)
                      ? widget.validator!(value)
                      : PhoneValidator.phoneValidator(value);
                  if (error != errorText) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          errorText = error;
                        });
                      }
                    });
                  }
                  return error;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                controller: widget.controller,
                needValidation: widget.needValidation,
                onTapOutside: (p0) {},
                readOnly: widget.readOnly,
                onChanged: _handleOnChanged,
                onSaved: widget.onSaved,
              ),
            ],
          ),
        );
      } else {
        content = DefaultFormField(
          textAlign: TextAlign.start,
          focusNode: _focusNode,
          maxLines: 1,
          fillColor: widget.fillColor ?? Colors.white,
          hintStyle:
              widget.hintStyle ??
              Styles.urbanistSize12w400White.copyWith(
                fontSize: widget.hintFontSize ?? 12,
                color: const Color.fromRGBO(187, 187, 187, 1),
              ),
          style:
              widget.style ??
              Styles.urbanistSize12w400White.copyWith(
                fontSize: widget.titleFontSize ?? 14,
              ),
          labelStyle: Styles.urbanistSize12w400White.copyWith(
            fontSize: widget.hintFontSize ?? 14,
            color: const Color.fromRGBO(210, 210, 210, 1),
          ),
          foucsBorderColor: ColorsApp.KorangePrimary,
          titleStyle:
              widget.titleStyle ??
              AppTextStyles.ibmPlexSansSize8w400Description.copyWith(
                fontSize: widget.titleFontSize,
              ),
          labelText: widget.titleText,
          borderColor:
              widget.borderColor ?? const Color.fromRGBO(220, 220, 220, 1),
          enabled: widget.enabeld,
          contentPadding:
              widget.contentPadding ??
              const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
          hintText: widget.hintText ?? AppStrings.phoneNumber.tr,
          prefixIcon: widget.prefixIcon,
          validator: (value) {
            // Validate phone
            final error = (widget.validator != null)
                ? widget.validator!(value)
                : PhoneValidator.phoneValidator(
                    value,
                    _selectedCountry.dialCode,
                  );
            if (error != errorText) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    errorText = error;
                  });
                }
              });
            }
            // Also validate country code if picker is shown
            if (widget.showCountryPicker) {
              final cError = CountryCodeValidator.validate(
                _selectedCountry.dialCode,
              );
              if (cError != countryError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      countryError = cError;
                    });
                  }
                });
              }
            }
            return error;
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          borderRadious: radius,
          keyboardType: TextInputType.phone,
          controller: widget.controller,
          needValidation: widget.needValidation,
          onTapOutside: (p0) {},
          readOnly: widget.readOnly,
          onChanged: _handleOnChanged,
          onSaved: widget.onSaved,
          focusedErrorBorderColor: Colors.red,
          errorStyle: const TextStyle(fontSize: 0, height: 0),
        );
      }

      Widget result;
      if (widget.showCountryPicker) {
        result = Row(
          children: [
            Expanded(child: content),
            const SizedBox(width: 10),
            _buildCountryPicker(),
          ],
        );
      } else {
        result = content;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          result,
          if (errorText != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, top: 4),
              child: Text(
                errorText!,
                style: TextStyle(color: Colors.red[700], fontSize: 12),
              ),
            ),
          if (widget.showCountryPicker && countryError != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, top: 4),
              child: Text(
                countryError!,
                style: TextStyle(color: Colors.red[700], fontSize: 12),
              ),
            ),
        ],
      );
    })();
    return Directionality(
      textDirection: mainAppBloc.isArabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: standardContent,
    );
  }
}
