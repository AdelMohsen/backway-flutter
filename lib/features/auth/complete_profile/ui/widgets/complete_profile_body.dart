import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_username_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_email_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_city_form_field.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';
import '../../logic/complete_profile_cubit.dart';
import '../../logic/complete_profile_state.dart';

class CompleteProfileBody extends StatelessWidget {
  const CompleteProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSuccess) {
          CustomToast.showSuccess(context, message: state.message);
          CustomNavigator.push(Routes.NAV_LAYOUT, clean: true);
        } else if (state is CompleteProfileError) {
          CustomToast.showError(context, message: state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CompleteProfileCubit>();
        return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Username
                      _buildLabel(AppStrings.usernameLabel.tr),
                      const SizedBox(height: 6),
                      DefaultUsernameFormField(
                        foucsBorderColor: ColorsApp.KorangePrimary,
                        controller: cubit.usernameController,
                        hintText: AppStrings.usernameHint.tr,
                        fillColor: const Color.fromRGBO(251, 251, 253, 1),
                        borderRadious: 26,
                        borderColor: const Color(0xFFF5F6F8),
                        prefixIcon: _buildPrefixIcon(SvgImages.user),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Phone Number
                      _buildLabel(AppStrings.phoneFieldLabel.tr),
                      const SizedBox(height: 6),
                      DefaultPhoneFormField(
                        controller: cubit.phoneController,
                        hintText: AppStrings.phoneFieldHint.tr,
                        showCountryPicker: true,
                        fillColor: const Color.fromRGBO(251, 251, 253, 1),
                        borderRadious: 26,
                        borderColor: const Color(0xFFF5F6F8),
                        prefixIcon: _buildPrefixIcon(SvgImages.phone),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 14,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// City
                      _buildLabel(AppStrings.selectCityLabel.tr),
                      const SizedBox(height: 6),
                      DefaultCityFormField(
                        centerTitle: true,
                        value: cubit.cityController.text.isEmpty
                            ? null
                            : cubit.cityController.text,
                        items: const [
                          DropdownMenuItem(
                            value: 'City 1',
                            child: Text('City 1'),
                          ),
                          DropdownMenuItem(
                            value: 'City 2',
                            child: Text('City 2'),
                          ),
                          DropdownMenuItem(
                            value: 'City 3',
                            child: Text('City 3'),
                          ),
                        ],
                        onChanged: (value) {
                          cubit.cityController.text = value ?? '';
                        },
                        hintText: AppStrings.pickCityHint.tr,
                      ),
                      const SizedBox(height: 16),

                      /// Email
                      _buildLabel(AppStrings.emailLabel.tr),
                      const SizedBox(height: 6),
                      DefaultEmailFormField(
                        controller: cubit.emailController,
                        hintText: AppStrings.emailHintText.tr,
                        fillColor: const Color.fromRGBO(251, 251, 253, 1),
                        borderRadious: 26,
                        borderColor: const Color(0xFFF5F6F8),
                        prefixIcon: _buildPrefixIcon(SvgImages.sms),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      const SizedBox(height: 32),

                      /// Get Started Button
                      DefaultButton(
                        text: AppStrings.getStarted.tr,
                        isLoading: state is CompleteProfileLoading,
                        onPressed: () {
                          CustomNavigator.push(Routes.NAV_LAYOUT, clean: true);
                        },
                        backgroundColor: ColorsApp.kPrimary,
                        height: 52,
                        borderRadiusValue: 28,
                        textStyle: Styles.urbanistSize14w700White.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 39),

                      /// Login Link
                      Center(
                        child: GestureDetector(
                          onTap: () =>
                              CustomNavigator.push(Routes.LOGIN, clean: true),
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.haveAccount.tr,
                              style: Styles.urbanistSize14w400White.copyWith(
                                color: const Color.fromRGBO(133, 133, 133, 1),
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.logIn.tr,
                                  style: Styles.urbanistSize14w400White
                                      .copyWith(
                                        color: ColorsApp.kPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOutBack);
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Text(
        text,
        style: Styles.urbanistSize16w600White.copyWith(
          fontSize: 14,
          color: const Color.fromRGBO(64, 64, 64, 1),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon(String icon) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(
          Color.fromRGBO(180, 180, 190, 1),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
