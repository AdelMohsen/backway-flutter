import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/validations/vaildator.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../logic/verify_code_cubit.dart';
import '../../logic/verify_code_state.dart';

class ChangePhoneBottomSheet extends StatelessWidget {
  const ChangePhoneBottomSheet({super.key});

  static void show(BuildContext context) {
    final cubit = context.read<VerifyCodeCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: cubit,
        child: const ChangePhoneBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyCodeCubit>();

    return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
      listener: (context, state) {
        if (state is ChangePhoneSuccess) {
          CustomNavigator.pop(); // Close bottom sheet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.data.message),
              backgroundColor: AppColors.primaryGreenHub,
            ),
          );
        } else if (state is ChangePhoneError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ChangePhoneLoading;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 30, 24, 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: Form(
              key: cubit.changePhoneFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.editMobileNumber.tr,
                        style: AppTextStyles.ibmPlexSansSize26w700White
                            .copyWith(color: Colors.black, fontSize: 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DefaultPhoneFormField(
                    controller: cubit.newPhoneController,
                    hintText: AppStrings.phoneHint.tr,
                    fillColor: const Color(0xffF7F7F7),
                    borderRadious: 44,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                      5,
                      5,
                      5,
                      5,
                    ),
                    validator: PhoneValidator.phoneValidator,
                  ),
                  const SizedBox(height: 55),
                  DefaultButton(
                    text: isLoading ? null : AppStrings.yes.tr,
                    onPressed: isLoading
                        ? null
                        : () => cubit.changePhoneNumber(),
                    backgroundColor: AppColors.primaryGreenHub,
                    height: 62,
                    borderRadiusValue: 44,
                    textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                        .copyWith(color: Colors.white),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: isLoading ? null : () => CustomNavigator.pop(),
                    child: Text(
                      AppStrings.back.tr,
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isLoading
                            ? const Color(0xffBBBBBB)
                            : const Color(0xff666666),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
