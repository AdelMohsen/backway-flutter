import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ComplaintDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;

  const ComplaintDescriptionField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      controller: controller,
      validator: validator,
      hintStyle: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
        color: Color.fromRGBO(132, 132, 132, 1),
      ),
      hintText: hintText ?? AppStrings.complaintDescriptionHint.tr,
      maxLines: 5,
      textAlign: TextAlign.start,
      fillColor: const Color.fromRGBO(245, 245, 245, 1),
      borderColor: Colors.transparent,
      enabledBorderColor: Colors.transparent,
      foucsBorderColor: AppColors.primaryGreenHub,
      borderRadious: 12,
      needValidation: true,
      prefixIcon: Padding(
        padding: const EdgeInsetsDirectional.only(end: 12, bottom: 40),
        child: Align(
          alignment: AlignmentDirectional.topEnd,
          widthFactor: 1.0,
          heightFactor: 5.0,
          child: SvgPicture.asset(AppSvg.note1),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }
}
