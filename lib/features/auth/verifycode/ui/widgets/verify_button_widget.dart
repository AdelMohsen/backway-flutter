import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/verify_code_cubit.dart';
import '../../logic/verify_code_state.dart';

class VerifyButtonWidget extends StatelessWidget {
  const VerifyButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      buildWhen: (previous, current) =>
          current is VerifyOtpLoading ||
          current is VerifyOtpSuccess ||
          current is VerifyOtpError ||
          current is VerifyCodeInitial,
      builder: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        final isLoading = state is VerifyOtpLoading;

        return DefaultButton(
          height: 62,
          onPressed: isLoading ? null : () => cubit.verifyOtpThenLogin(),
          backgroundColor: AppColors.primaryGreenHub,
          borderRadiusValue: 28,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    AppStrings.loginAction.tr,
                    style: AppTextStyles.ibmPlexSansSize18w700Primary.copyWith(
                      color: const Color.fromARGB(255, 234, 232, 232),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
