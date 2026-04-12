import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_email_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_username_form_field.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class FormfiledEditProfileWidget extends StatelessWidget {
  const FormfiledEditProfileWidget({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.formKey,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          // Name Field
          DefaultUsernameFormField(
            style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
              color: const Color.fromRGBO(51, 51, 51, 1),
            ),
            controller: nameController,
            hintText: AppStrings.firstName.tr,
            fillColor: const Color(0xFFF9F9F9),
            borderRadious: 25,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              20,
              15,
              20,
              22,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                AppSvg.profileauth,
                width: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryGreenHub,
                  BlendMode.srcIn,
                ),
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(AppSvg.edit3, width: 10),
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),

          // Phone Field
          DefaultPhoneFormField(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(AppSvg.edit3, width: 10),
            ),
            style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
              color: const Color.fromRGBO(51, 51, 51, 1),
            ),
            controller: phoneController,
            fillColor: const Color(0xFFF9F9F9),
            borderRadious: 25,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              20,
              15,
              20,
              22,
            ),
            onChanged: (value) {},
          ),

          const SizedBox(height: 16),

          // Email Field
          DefaultEmailFormField(
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              20,
              15,
              20,
              22,
            ),
            controller: emailController,
            fillColor: const Color(0xFFF9F9F9),
            borderRadious: 25,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(
                AppSvg.smsTracking,
                width: 10,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryGreenHub,
                  BlendMode.srcIn,
                ),
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(AppSvg.edit3, width: 10),
            ),
            textAlign: TextAlign.start,
            style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
              color: const Color.fromRGBO(51, 51, 51, 1),
            ),
          ),

          const SizedBox(height: 16),

          // Gender Field
          DefaultDropdownFormField(
            contentPadding: const EdgeInsetsDirectional.all(10),
            hintText: AppStrings.gender.tr,
            value: selectedGender,
            items: [
              DropdownMenuItem(
                value: AppStrings.male.tr,
                child: Text(AppStrings.male.tr),
              ),
              DropdownMenuItem(
                value: AppStrings.female.tr,
                child: Text(AppStrings.female.tr),
              ),
            ],
            onChanged: onGenderChanged,
            fillColor: const Color(0xFFF9F9F9),
            borderRadious: 45,
          ),
        ],
      ),
    );
  }
}
