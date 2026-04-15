import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';
import 'package:greenhub/core/utils/widgets/loading/animated_loading.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';
import 'package:greenhub/core/utils/enums/enums.dart';
import 'package:greenhub/features/auth/login/logic/login_cubit.dart';
import 'package:greenhub/features/auth/login/logic/login_state.dart';
import 'package:greenhub/features/auth/verifycode/data/params/verify_code_route_params.dart';

class MainContainerAndFiled extends StatelessWidget {
  const MainContainerAndFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SendOtpSuccess) {
            final cubit = context.read<LoginCubit>();
            CustomToast.showSuccess(context, message: state.data.message);
            CustomNavigator.push(
              Routes.VERIFY_CODE,
              extra: VerifyCodeRouteParams(
                phoneNumber: cubit.phone.text,
                fromScreen: VerifyCodeFromScreen.fromLogin,
              ),
            );
          } else if (state is SendOtpError) {
            CustomToast.showError(context, message: state.error.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 25,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Phone Number Label
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            AppStrings.phoneFieldLabel.tr,
                            style: Styles.urbanistSize16w600White.copyWith(
                              fontSize: 14,
                              color: const Color.fromRGBO(64, 64, 64, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        /// Phone Input Field
                        DefaultPhoneFormField(
                          controller: cubit.phone,
                          hintText: AppStrings.phoneFieldHint.tr,
                          fillColor: Color.fromRGBO(249, 250, 251, 1),
                          borderColor: const Color(0xFFF5F6F8),
                          hintStyle: Styles.urbanistSize14w400White.copyWith(
                            fontSize: 12,
                            color: const Color.fromRGBO(148, 163, 184, 1),
                          ),
                          style: Styles.urbanistSize14w400White.copyWith(
                            color: Colors.black87,
                          ),
                          borderRadious: 26,
                          showCountryPicker: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              SvgImages.phone,
                              width: 22,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                Color.fromRGBO(180, 180, 190, 1),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          onChanged: (value) {
                            cubit.isValidPhoneFunction();
                          },
                        ),

                        const SizedBox(height: 38),

                        /// Sign In Button
                        DefaultButton(
                          text: AppStrings.signIn.tr,
                          isLoading: state is SendOtpLoading,
                          onPressed: () {
                            if (cubit.isLoginValidate()) {
                              cubit.sendOtpStatesHandled();
                            }
                          },
                          backgroundColor: ColorsApp.kPrimary,
                          height: 48,
                          borderRadiusValue: 28,
                          textStyle: Styles.urbanistSize14w700White,
                        ),

                        const SizedBox(height: 32),

                        /// New here? Create an account
                        Center(
                          child: GestureDetector(
                            child: RichText(
                              text: TextSpan(
                                text: AppStrings.newHere.tr,
                                style: Styles.urbanistSize14w400White.copyWith(
                                  color: Color.fromRGBO(133, 133, 133, 1),
                                ),
                                children: [
                                  TextSpan(
                                    text: AppStrings.guestText.tr,
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

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutBack);
        },
      ),
    );
  }
}
