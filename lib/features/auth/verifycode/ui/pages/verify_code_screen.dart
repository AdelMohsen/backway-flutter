import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/enums/enums.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';
import 'package:greenhub/features/auth/verifycode/data/params/verify_code_route_params.dart';
import 'package:greenhub/features/auth/verifycode/logic/verify_code_cubit.dart';
import 'package:greenhub/features/auth/verifycode/logic/verify_code_state.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, required this.params});

  final VerifyCodeRouteParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCodeCubit(
        phoneNumber: params.phoneNumber,
        fromScreen: params.fromScreen,
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.kWhite,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
            listener: (context, state) {
              if (state is VerifyOtpSuccess) {
                CustomToast.showSuccess(context, message: state.data.message);
                if (params.fromScreen == VerifyCodeFromScreen.fromLogin ||
                    params.fromScreen == VerifyCodeFromScreen.fromRegister) {
                  //   CustomNavigator.push(Routes.COMPLETE_PROFILE, clean: true);
                }
              } else if (state is VerifyOtpError) {
                CustomToast.showError(context, message: state.error.message);
              } else if (state is ResendOtpSuccess) {
                CustomToast.showSuccess(context, message: state.data.message);
              } else if (state is ResendOtpError) {
                CustomToast.showError(context, message: state.error.message);
              }
            },
            builder: (context, state) {
              final cubit = context.read<VerifyCodeCubit>();
              return SafeArea(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 16, end: 16),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // AppBar Row
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => CustomNavigator.pop(),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF6F8FA),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      SvgImages.kBackIcon,
                                      colorFilter: const ColorFilter.mode(
                                        Color.fromRGBO(36, 35, 39, 1),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppStrings.authenticationCode.tr,
                                    textAlign: TextAlign.center,
                                    style: Styles.urbanistSize16w600White
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 44,
                                ), // To balance the row visually
                              ],
                            ),
                            const SizedBox(height: 40),

                            // Title
                            Text(
                              AppStrings.otpConfirmation.tr,
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ColorsApp.kPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Subtitle
                            Text(
                              AppStrings.otpSentDescription.tr.replaceAll(
                                '{phone}',
                                cubit.phoneNumber,
                              ),
                              style: Styles.urbanistSize14w400White.copyWith(
                                fontSize: 13,
                                color: const Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Timer
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 243, 239, 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  cubit.formatTime(cubit.secondsRemaining),
                                  style: Styles.urbanistSize14w400White
                                      .copyWith(
                                        color: ColorsApp.KorangePrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // PIN Code Field
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: PinCodeTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.otpRequired.tr;
                                  }
                                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                                    return AppStrings.otpDigitsOnly.tr;
                                  }
                                  if (value.length < 4) {
                                    return AppStrings.otpLength.tr;
                                  }
                                  return null;
                                },
                                appContext: context,
                                length: 4,
                                autoDisposeControllers: false,
                                controller: cubit.otpController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                autoFocus: true,
                                enableActiveFill: true,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                hintCharacter: '-',
                                hintStyle: const TextStyle(
                                  fontSize: 28,
                                  color: Color.fromRGBO(174, 173, 178, 1),
                                  fontWeight: FontWeight.w400,
                                ),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(16),
                                  fieldHeight: 72,
                                  fieldWidth: 72,
                                  borderWidth: 1,
                                  activeBorderWidth: 1,
                                  inactiveBorderWidth: 1,
                                  selectedBorderWidth: 1,
                                  errorBorderWidth: 1,
                                  activeColor:
                                      cubit.otpController.text.length == 4
                                      ? Colors.green
                                      : ColorsApp.KorangeSecondary,
                                  selectedColor:
                                      cubit.otpController.text.length == 4
                                      ? Colors.green
                                      : ColorsApp.KorangeSecondary,
                                  inactiveColor: const Color(0xFFE5E7EB),
                                  activeFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  inactiveFillColor: const Color(0xFFFBFBFD),
                                  errorBorderColor: Colors.red,
                                ),
                                textStyle: Styles.urbanistSize20w500Orange
                                    .copyWith(
                                      color: Color.fromRGBO(64, 64, 64, 1),
                                    ),
                                onChanged: (val) {
                                  // Update state to trigger button refresh
                                  if (val.length == 4 || val.length == 3) {
                                    cubit.emit(VerifyCodeInitial());
                                  }
                                },
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Resend Code
                            GestureDetector(
                              onTap: cubit.isResendActive
                                  ? () => cubit.resendOtp()
                                  : null,
                              child: Center(
                                child: Text(
                                  AppStrings.resendCode.tr,
                                  style: Styles.urbanistSize14w400White
                                      .copyWith(
                                        color: cubit.isResendActive
                                            ? Color.fromRGBO(75, 85, 99, 1)
                                            : Color.fromRGBO(183, 192, 200, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 46),
                            // Verify Button
                            DefaultButton(
                              text: AppStrings.otpVerificationButton.tr,
                              isLoading: state is VerifyOtpLoading,
                              backgroundColor:
                                  cubit.otpController.text.length == 4
                                  ? ColorsApp.kPrimary
                                  : const Color(0xFFBFC5CC),
                              height: 48,
                              borderRadiusValue: 28,
                              onPressed: cubit.otpController.text.length == 4
                                  ? () => CustomNavigator.push(
                                      Routes.COMPLETE_PROFILE,
                                      clean: true,
                                    )
                                  : () {
                                      if (cubit.otpController.text.isEmpty) {
                                        CustomToast.showError(
                                          context,
                                          message: AppStrings.otpRequired.tr,
                                        );
                                      } else if (cubit
                                              .otpController
                                              .text
                                              .length <
                                          4) {
                                        CustomToast.showError(
                                          context,
                                          message: AppStrings.otpLength.tr,
                                        );
                                      }
                                    },
                              textStyle: Styles.urbanistSize14w400White
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
