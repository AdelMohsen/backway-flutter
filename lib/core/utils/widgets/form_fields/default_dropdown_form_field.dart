import 'package:flutter/material.dart';
import '../../../theme/text_styles/text_styles.dart';

class DefaultDropdownFormField extends StatelessWidget {
  const DefaultDropdownFormField({
    super.key,
    this.hintText,
    this.value,
    this.items,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadious,
    this.borderColor,
    this.fillColor,
    this.hintFontSize,
    this.contentPadding,
  });

  final String? hintText;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadious;
  final Color? borderColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? hintFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? const Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(borderRadious ?? 45),
        border: Border.all(color: borderColor ?? Colors.transparent, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
              fontSize: hintFontSize ?? 12,
              color: const Color.fromRGBO(160, 160, 167, 1),
            ),
            prefixIcon: prefixIcon,
            contentPadding: contentPadding ?? EdgeInsets.zero,
          ),
          icon:
              suffixIcon ??
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9E9E9E)),
          isExpanded: true,
          value: value,
          items: items ?? [],
          onChanged: onChanged,
          dropdownColor: Colors.white,
          style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
            fontSize: hintFontSize ?? 14,
            color: const Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
      ),
    );
  }
}
