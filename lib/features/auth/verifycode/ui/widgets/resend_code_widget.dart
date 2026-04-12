import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../logic/verify_code_cubit.dart';
import '../../logic/verify_code_state.dart';

class ResendCodeWidget extends StatelessWidget {
  const ResendCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      buildWhen: (previous, current) =>
          current is TimerTick ||
          current is ResendOtpLoading ||
          current is ResendOtpSuccess ||
          current is ResendOtpError,
      builder: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        final isActive = cubit.isResendActive;
        final isLoading = state is ResendOtpLoading;

        return Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.didNotReceiveCode.tr,
                  style: AppTextStyles.ibmPlexSansSize12w400Grey,
                ),
                GestureDetector(
                  onTap: isActive && !isLoading
                      ? () => cubit.resendOtp()
                      : null,
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryGreenHub,
                          ),
                        )
                      : Text(
                          AppStrings.resendCodeAction.tr,
                          style: AppTextStyles.ibmPlexSansSize12w600Grey
                              .copyWith(
                                color: isActive
                                    ? AppColors.primaryGreenHub
                                    : AppColors.primaryGreenHub,
                                decoration: isActive
                                    ? TextDecoration.underline
                                    : null,
                              ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
