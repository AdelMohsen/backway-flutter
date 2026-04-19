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
    this.titleText,
    this.titleFontSize,
    this.titleIconWidget,
    this.centerTitle = false,
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
  final String? titleText;
  final double? titleFontSize;
  final Widget? titleIconWidget;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centerTitle
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (titleText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: centerTitle
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                titleIconWidget ?? const SizedBox.shrink(),
                if (titleIconWidget != null) const SizedBox(width: 8),
                Text(
                  titleText!,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  style: AppTextStyles.interW500Size20.copyWith(
                    fontSize: titleFontSize ?? 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(64, 64, 64, 1),
                  ),
                ),
              ],
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: fillColor ?? const Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.circular(borderRadious ?? 45),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: Styles.urbanistSize12w400White.copyWith(
                  fontSize: hintFontSize ?? 12,
                  color: const Color.fromRGBO(148, 163, 184, 1),
                ),
                prefixIcon: prefixIcon,
                contentPadding: contentPadding ?? EdgeInsets.zero,
              ),
              icon:
                  suffixIcon ??
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF9E9E9E),
                  ),
              isExpanded: true,
              value: value,
              items: items ?? [],
              onChanged: onChanged,
              dropdownColor: Colors.white,
              style: Styles.urbanistSize12w400White.copyWith(
                color: const Color.fromRGBO(156, 163, 175, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
