import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';

class DefaultPinCodeTextFieldWidget extends StatelessWidget {
  const DefaultPinCodeTextFieldWidget({
    super.key,
    this.onSave,
    this.onChanged,
    this.controller,
    this.onCompleted,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.fontSize,
    this.hintFontSize,
    this.borderRadious,
    this.fieldHeight,
    this.fieldWidth,
    this.length = 6,
  });

  final void Function(String?)? onSave;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final double? fontSize;
  final double? hintFontSize;
  final double? borderRadious;
  final double? fieldHeight;
  final double? fieldWidth;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Force LTR for pin code
      child: PinCodeTextField(
        controller: controller,
        onChanged: (value) {
          onChanged?.call(value);
        },
        onCompleted: (value) {
          onCompleted?.call(value);
        },
        onSubmitted: (value) {
          onSubmitted?.call(value);
        },
        onSaved: (value) {
          // No need to manual update controller, PinCodeTextField handles it
          onSave?.call(value);
        },
        length: length,
        autoDisposeControllers: false,
        obscureText: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        hintStyle: AppTextStyles.interW500Size20.copyWith(
          fontSize: hintFontSize,
          color: const Color.fromRGBO(0, 0, 0, 1),
        ),
        textStyle: AppTextStyles.interW500Size20.copyWith(
          fontSize: 19,
          color: const Color.fromRGBO(0, 0, 0, 1),
        ),
        enableActiveFill: true,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(borderRadious ?? 8),
          fieldOuterPadding: const EdgeInsets.all(0),
          fieldHeight: fieldHeight ?? 60,
          fieldWidth: fieldWidth ?? 60,
          borderWidth: 1,

          activeBorderWidth: 1,
          errorBorderColor: Colors.red,
          inactiveBorderWidth: 1,
          selectedBorderWidth: 1,
          disabledColor: Colors.green,
          inactiveColor: const Color.fromRGBO(187, 187, 187, .6),
          inactiveFillColor: Colors.white,
          activeColor: const Color.fromRGBO(4, 131, 114, 0.12),
          selectedColor: const Color.fromRGBO(4, 131, 114, 0.12),
          activeFillColor: Color.fromRGBO(4, 131, 114, 0.12),
          selectedFillColor: Color.fromRGBO(4, 131, 114, 0.12),
        ),
        errorTextDirection: mainAppBloc.isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        errorTextMargin: const EdgeInsets.only(left: 20, right: 20),
        errorTextSpace: 35,
        pastedTextStyle: const TextStyle(fontSize: 18),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        appContext: context,
        validator: (value) =>
            value!.isEmpty ? AppStrings.thisFieldIsRequired.tr : null,
      ),
    );
  }
}
