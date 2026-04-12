import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/enums/enums.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';
import 'package:greenhub/features/auth/verifycode/data/params/verify_code_route_params.dart';
import 'package:greenhub/features/auth/verifycode/logic/verify_code_cubit.dart';
import 'package:greenhub/features/auth/verifycode/logic/verify_code_state.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/back_to_login_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/change_phone_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/otp_input_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/resend_code_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/timer_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/verify_button_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/verify_code_icon_widget.dart';
import 'package:greenhub/features/auth/verifycode/ui/widgets/verify_code_title_widget.dart';

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
        child: CustomScaffoldWidget(
          needAppbar: false,
          child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
            listener: (context, state) {
              if (state is VerifyOtpSuccess) {
                // Show success message
                CustomToast.showSuccess(context, message: state.data.message);
                // Navigate based on fromScreen enum
                if (params.fromScreen == VerifyCodeFromScreen.fromLogin ||
                    params.fromScreen == VerifyCodeFromScreen.fromRegister) {
                  CustomNavigator.push(Routes.NAV_LAYOUT, clean: true);
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
              return GradientHeaderLayout(
                showAction: false,
                title: '',
                logo: SvgPicture.asset(AppSvg.iconApp, width: 35, height: 45),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 10),
                      // Icon Container
                      VerifyCodeIconWidget(),
                      SizedBox(height: 20),
                      // Title & Description
                      VerifyCodeTitleWidget(),
                      SizedBox(height: 48),
                      // Resend Code Row
                      ResendCodeWidget(),
                      SizedBox(height: 16),
                      // Timer
                      TimerWidget(),
                      SizedBox(height: 16),
                      // PIN Code Field
                      OtpInputWidget(),
                      // Change Phone Row
                      ChangePhoneWidget(),
                      SizedBox(height: 56),
                      // Login/Verify Button
                      VerifyButtonWidget(),
                      SizedBox(height: 16),
                      // Back to Login Link
                      BackToLoginWidget(),
                      SizedBox(height: 10),
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
