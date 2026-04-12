import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/failure_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/add_address/logic/add_address_cubit.dart';
import 'package:greenhub/features/add_address/logic/add_address_state.dart';
import 'package:greenhub/features/add_address/ui/widgets/all_filds_form_add_address.dart';
import 'package:greenhub/features/user/logic/user_cubit.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAddressCubit(),
      child: const _AddAddressView(),
    );
  }
}

class _AddAddressView extends StatelessWidget {
  const _AddAddressView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAddressCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
        resizeToAvoidBottomInset: true,
        child: BlocConsumer<AddAddressCubit, AddAddressState>(
          listener: (context, state) {
            if (state is AddAddressSaved) {
              context.read<UserCubit>().getUserProfile();
              SuccessBottomSheet.show(
                context,
                title: mainAppBloc.isArabic
                    ? "تمت الإضافة بنجاح"
                    : "Added successfully",
                subtitle: state.success.message.isNotEmpty
                    ? state.success.message
                    : (mainAppBloc.isArabic
                          ? "تم حفظ عنوانك بنجاح"
                          : "Your address has been saved successfully"),
                onDismiss: () {
                  CustomNavigator.pop();
                },
              );
            } else if (state is AddAddressError) {
              FailureBottomSheet.show(
                context,
                title: AppStrings.addressAddFailed.tr,
                subtitle: state.message.message,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  /// 🔹 Gradient Header with Scrollable Content
                  Expanded(
                    child: GradientHeaderLayout(
                      showAction: true,
                      title: AppStrings.addNewAddress.tr,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AllFildsFormAddAddress()
                              .animate()
                              .fadeIn(duration: 350.ms, delay: 700.ms)
                              .slideY(
                                begin: 0.5,
                                end: 0.0,
                                curve: Curves.fastOutSlowIn,
                              ),
                        ),
                      ),
                    ),
                  ),

                  /// 🔹 Save Button - Fixed at Bottom
                  Padding(
                        padding: const EdgeInsets.all(20),
                        child: DefaultButton(
                          isLoading: state is AddAddressSaving,
                          onPressed: () => cubit.saveAddress(),
                          borderRadius: BorderRadius.circular(44),
                          width: double.infinity,
                          height: 56,
                          child: Center(
                            child: Text(
                              AppStrings.save.tr,
                              style: AppTextStyles.ibmPlexSansSize18w600White,
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 350.ms, delay: 700.ms)
                      .slideY(
                        begin: 0.5,
                        end: 0.0,
                        curve: Curves.fastOutSlowIn,
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
