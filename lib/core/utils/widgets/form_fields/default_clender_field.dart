import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../../translation/all_translation.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';

class DefaultClenderField extends StatefulWidget {
  const DefaultClenderField({
    super.key,
    this.titleFontSize,
    this.hintFontSize,
    this.borderRadious,
    this.controller,
    this.readOnly = false,
    this.needValidation = true,
    this.onChanged,
    this.fillColor,
    this.borderColor,
    this.titleStyle,
    this.prefixIcon,
    this.hintStyle,
    this.hintText,
    this.titleText,
    this.enabled = true,
    this.onSaved,
    this.suffixIcon,
    this.hintColor,
  });

  final double? titleFontSize;
  final double? hintFontSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readOnly;
  final bool needValidation;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? titleText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final void Function(String?)? onSaved;
  final Color? hintColor;

  @override
  State<DefaultClenderField> createState() => _DefaultClenderFieldState();
}

class _DefaultClenderFieldState extends State<DefaultClenderField> {
  DateTime? pickedDate;

  Future<void> _selectBirthDate(BuildContext context) async {
    await _showIOSDatePicker(context);
  }

  Future<void> _showIOSDatePicker(BuildContext context) async {
    DateTime tempDate = pickedDate ?? DateTime(2000);
    final bool isArabic = allTranslations.currentLanguage == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? Colors.grey.shade700
                          : CupertinoColors.separator,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.cancel.tr,
                        style: const TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.done.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          pickedDate = tempDate;
                          final formattedDate =
                              '${pickedDate!.day.toString().padLeft(2, '0')}/${pickedDate!.month.toString().padLeft(2, '0')}/${pickedDate!.year}';
                          widget.controller?.text = formattedDate;
                          widget.onChanged?.call(formattedDate);
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: isDark ? Brightness.dark : Brightness.light,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: tempDate,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    dateOrder: DatePickerDateOrder.dmy,
                    onDateTimeChanged: (DateTime newDate) {
                      tempDate = newDate;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadious ?? 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 8),
            child: Text(
              widget.titleText!,
              style:
                  widget.titleStyle ??
                  AppTextStyles.bodySmMedium.copyWith(
                    fontSize: widget.titleFontSize ?? 14,
                    color: AppColors.kBlack,
                  ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          enabled: widget.enabled,
          onTap: () {
            if (widget.enabled) {
              _selectBirthDate(context);
            }
          },
          validator: widget.needValidation
              ? (value) {
                  if (value == null || value.isEmpty) {
                    // الرسالة حسب اللغة
                    return mainAppBloc.isArabic
                        ? 'تاريخ الميلاد مطلوب'
                        : 'Birth date is required';
                  }
                  return null; // لو القيمة موجودة، يبقى صحيحة
                }
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: widget.onSaved,
          style: AppTextStyles.interW500Size20.copyWith(
            fontSize: widget.titleFontSize ?? 14,
            color: AppColors.Kblue,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? AppColors.kWhite,
            hintText:
                widget.hintText ??
                (mainAppBloc.isArabic ? 'يوم/شهر/سنة' : 'DD/MM/YYYY'),
            hintStyle:
                widget.hintStyle ??
                AppTextStyles.cairoW400Size12.copyWith(
                  fontSize: widget.hintFontSize ?? 12,
                  color: widget.hintColor ?? AppColors.textGrey,
                ),
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              20,
              10,
              20,
              10,
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,

            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.borderLightGrey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.7),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(radius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.borderLightGrey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
