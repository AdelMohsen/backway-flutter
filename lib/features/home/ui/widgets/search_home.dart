import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class SearchHome extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const SearchHome({Key? key, this.controller, this.validator})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      controller: controller,
      validator: validator,
      width: double.infinity,
      hintText: AppStrings.homeSearchHint.tr,
      hintStyle: AppTextStyles.ibmPlexSansSize10w400Hint,
      fillColor: AppColors.kWhite,
      borderColor: Colors.transparent,
      enabledBorderColor: Colors.transparent,
      foucsBorderColor: Colors.transparent,
      borderRadious: 60,
      needValidation: validator != null,
      textAlign: TextAlign.start,

      padding: EdgeInsets.zero,
      verticalEdge: 0,
      style: AppTextStyles.ibmPlexSansSize10w400Hint.copyWith(
        color: AppColors.kBlack,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.homeSearchHint.tr,
        hintStyle: AppTextStyles.ibmPlexSansSize10w400Hint,
        fillColor: AppColors.kWhite,
        filled: true,
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 35, // Adjusted for 44 height
            height: 35,
            decoration: const BoxDecoration(
              color: AppColors.kSearchIconBg,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: SvgPicture.asset(
                AppSvg.search,
                colorFilter: ColorFilter.mode(
                  AppColors.kSearchIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: AppColors.kWhiteOpacity16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: AppColors.kWhiteOpacity16),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: AppColors.kWhiteOpacity16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: AppColors.kWhiteOpacity16),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: AppColors.kWhiteOpacity16),
        ),
      ),
    );
  }
}
