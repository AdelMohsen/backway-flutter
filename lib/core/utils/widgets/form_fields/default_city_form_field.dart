import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'default_dropdown_form_field.dart';

class DefaultCityFormField extends StatelessWidget {
  const DefaultCityFormField({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.hintText,
    this.validator,
    this.titleText,
    this.titleFontSize,
    this.titleIconWidget,
    this.centerTitle = false,
  });

  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? titleText;
  final double? titleFontSize;
  final Widget? titleIconWidget;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return DefaultDropdownFormField(
      value: value,
      items: items,
      onChanged: onChanged,
      titleText: titleText,
      titleFontSize: titleFontSize,
      titleIconWidget: titleIconWidget,
      centerTitle: centerTitle,
      hintText: hintText ?? AppStrings.pickCityHint.tr,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          SvgImages.location,

          colorFilter: const ColorFilter.mode(
            Color.fromRGBO(148, 163, 184, 1),
            BlendMode.srcIn,
          ),
        ),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SvgPicture.asset(
          SvgImages.drop,
          colorFilter: const ColorFilter.mode(
            Color.fromRGBO(180, 180, 190, 1),
            BlendMode.srcIn,
          ),
        ),
      ),

      fillColor: const Color.fromRGBO(249, 250, 251, 1),
      borderRadious: 26,
      borderColor: const Color(0xFFF5F6F8),
      hintFontSize: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
    );
  }
}
