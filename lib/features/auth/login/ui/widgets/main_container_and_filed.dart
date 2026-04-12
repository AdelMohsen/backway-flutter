import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
          if (state is SendOtpLoading) {
            AnimatedLoading.showAnimatedLoading();
          } else if (state is SendOtpSuccess) {
            AnimatedLoading.hideAnimatedLoading(); // Dismiss loading
            final cubit = context.read<LoginCubit>();
            // Show success toast
            CustomToast.showSuccess(context, message: state.data.message);
            // Navigate to verify code with params
            CustomNavigator.push(
              Routes.VERIFY_CODE,
              extra: VerifyCodeRouteParams(
                phoneNumber: cubit.phone.text,
                fromScreen: VerifyCodeFromScreen.fromLogin,
              ),
            );
          } else if (state is SendOtpError) {
            AnimatedLoading.hideAnimatedLoading(); // Dismiss loading
            // Show error toast
            CustomToast.showError(context, message: state.error.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 24, 14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.loginCardTitle.tr,
                              style: AppTextStyles.ibmPlexSansSize26w700White
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        DefaultPhoneFormField(
                          controller: cubit.phone,
                          hintText: mainAppBloc.isArabic
                              ? "رقم الجوال"
                              : "Phone Number",
                          fillColor: const Color(0xffF7F7F7),
                          borderRadious: 44,
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            5,
                            5,
                            5,
                            5,
                          ),
                          onChanged: (value) {
                            cubit.isValidPhoneFunction();
                          },
                        ),
                        const SizedBox(height: 40),
                        DefaultButton(
                          text: mainAppBloc.isArabic ? "سجل دخولك" : "Login",
                          onPressed: () {
                            if (cubit.isLoginValidate()) {
                              cubit.sendOtpStatesHandled();
                            }
                          },
                          backgroundColor: AppColors.primaryGreenHub,
                          height: 56,
                          borderRadiusValue: 44,
                          textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => CustomNavigator.pop(),
                          child: Text(
                            AppStrings.loginReturn.tr,
                            style: GoogleFonts.ibmPlexSansArabic(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff666666),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 700.ms)
              .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack);
        },
      ),
    );
  }
}
