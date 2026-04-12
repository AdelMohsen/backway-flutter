import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/utils/enums/enums.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/failure_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:greenhub/features/auth/register/logic/register_cubit.dart';
import 'package:greenhub/features/auth/register/logic/register_state.dart';
import 'package:greenhub/features/auth/register/ui/widgets/form_filed_register.dart';
import 'package:greenhub/features/auth/verifycode/data/params/verify_code_route_params.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const _RegisterScreenBody(),
    );
  }
}

class _RegisterScreenBody extends StatelessWidget {
  const _RegisterScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          SuccessBottomSheet.show(
            context,
            title: AppStrings.registerSuccess.tr,
            subtitle: state.data.message,
            onDismiss: () {
              CustomNavigator.push(
                clean: true,
                Routes.VERIFY_CODE,
                extra: VerifyCodeRouteParams(
                  phoneNumber: cubit.phoneController.text,
                  fromScreen: VerifyCodeFromScreen.fromRegister,
                ),
              );
            },
          );
        } else if (state is RegisterError) {
          FailureBottomSheet.show(
            context,
            title: AppStrings.registerFailed.tr,
            subtitle: state.error.message,
          );
        } else if (state is LocationDetectFailed) {
          FailureBottomSheet.show(
            context,
            title: AppStrings.locationFailed.tr,
            subtitle: state.message,
          );
        }
      },
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
          resizeToAvoidBottomInset: true,
          child: GradientHeaderLayout(
            showAction: false,
            logo: SvgPicture.asset(AppSvg.iconApp, width: 35, height: 45),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          MainText(
                            text: AppStrings.createAccount.tr,
                            style: AppTextStyles.ibmPlexSansSize26w700White
                                .copyWith(color: Color.fromRGBO(51, 51, 51, 1)),
                          ),
                          SizedBox(height: 24),
                          FormFiledRegister(),
                          SizedBox(height: 20),
                          // Terms and Conditions checkbox
                          BlocBuilder<RegisterCubit, RegisterState>(
                            buildWhen: (previous, current) =>
                                current is RegisterInitial,
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () => cubit.toggleTerms(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: cubit.isTermsAccepted
                                              ? AppColors.primaryGreenHub
                                              : Color.fromRGBO(
                                                  160,
                                                  160,
                                                  167,
                                                  1,
                                                ),
                                          width: 1.5,
                                        ),
                                        color: cubit.isTermsAccepted
                                            ? AppColors.primaryGreenHub
                                            : AppColors.kWhite,
                                      ),
                                      child: cubit.isTermsAccepted
                                          ? Icon(
                                              Icons.check,
                                              size: 14,
                                              color: AppColors.kWhite,
                                            )
                                          : null,
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        CustomNavigator.push(Routes.ABOUT);
                                      },
                                      child: MainText(
                                        text: AppStrings
                                            .agreeToTermsAndConditions
                                            .tr,
                                        style: AppTextStyles
                                            .ibmPlexSansSize12w400Grey
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primaryGreenHub,
                                              color: Color.fromRGBO(
                                                111,
                                                111,
                                                116,
                                                1,
                                              ),
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  // Button stays at bottom
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20,
                      bottom: 20,
                    ),
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      buildWhen: (previous, current) =>
                          current is RegisterLoading ||
                          current is RegisterSuccess ||
                          current is RegisterError ||
                          current is RegisterInitial,
                      builder: (context, state) {
                        final isLoading = state is RegisterLoading;
                        return DefaultButton(
                          borderRadius: BorderRadius.circular(44),
                          height: 56,
                          textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                              .copyWith(color: AppColors.kWhite),
                          text: isLoading
                              ? AppStrings.loading.tr
                              : AppStrings.saveData.tr,
                          onPressed: isLoading
                              ? null
                              : () => cubit.registerUser(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
