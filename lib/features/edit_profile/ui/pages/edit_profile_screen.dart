import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/services/toast/toast_service.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/edit_profile/logic/cubit/edit_profile_cubit.dart';
import 'package:greenhub/features/edit_profile/logic/state/edit_profile_state.dart';
import 'package:greenhub/features/edit_profile/ui/widgets/formfiled_edit_profile_widget.dart';
import 'package:greenhub/features/user/logic/user_cubit.dart';
import 'package:greenhub/features/user/logic/user_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    _initializeFromUserData();
  }

  void _initializeFromUserData() {
    final userState = context.read<UserCubit>().state;
    if (userState is UserLoaded) {
      context.read<EditProfileCubit>().initFromUser(userState.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          ToastService.showSuccess(
            AppStrings.profileUpdatedSuccessfully.tr,
            context,
          );
          // Refresh user data in global UserCubit
          context.read<UserCubit>().getUserProfile();
        } else if (state is EditProfileError) {
          ToastService.showError(state.error.message, context);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: CustomScaffoldWidget(
          needAppbar: false,
          backgroundColor: AppColors.kWhite,
          child: Column(
            children: [
              Expanded(
                child: GradientHeaderLayout(
                  showAction: true,
                  title: AppStrings.editAccount.tr,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<
                                    EditProfileCubit,
                                    EditProfileState
                                  >(
                                    buildWhen: (previous, current) =>
                                        current is EditProfileInitial,
                                    builder: (context, state) {
                                      return FormfiledEditProfileWidget(
                                        nameController: cubit.nameController,
                                        phoneController: cubit.phoneController,
                                        emailController: cubit.emailController,
                                        selectedGender: cubit.displayGender,
                                        onGenderChanged: cubit.setGender,
                                        formKey: cubit.formKey,
                                      );
                                    },
                                  ),
                                  Column(
                                    children: [
                                      // Save Button
                                      BlocBuilder<
                                        EditProfileCubit,
                                        EditProfileState
                                      >(
                                        builder: (context, state) {
                                          final isLoading =
                                              state is EditProfileLoading;
                                          return DefaultButton(
                                            text: isLoading
                                                ? AppStrings.updatingProfile.tr
                                                : AppStrings.save.tr,
                                            backgroundColor:
                                                AppColors.primaryGreenHub,
                                            borderRadiusValue: 45,
                                            height: 56,
                                            textStyle: AppTextStyles
                                                .cairoW600Size16White
                                                .copyWith(color: Colors.white),
                                            onPressed: isLoading
                                                ? null
                                                : () => cubit.updateProfile(),
                                          );
                                        },
                                      ),

                                      const SizedBox(height: 12),

                                      // Cancel Button
                                      DefaultButton(
                                        text: AppStrings.cancelEdit.tr,
                                        backgroundColor: const Color(
                                          0xFFF1F7F7,
                                        ),
                                        borderRadiusValue: 45,
                                        height: 56,
                                        textStyle: AppTextStyles
                                            .cairoW600Size16White
                                            .copyWith(
                                              color: AppColors.primaryGreenHub,
                                            ),
                                        onPressed: () {
                                          CustomNavigator.pop();
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
