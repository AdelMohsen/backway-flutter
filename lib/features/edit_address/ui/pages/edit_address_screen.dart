import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/failure_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import 'package:greenhub/features/address/data/models/address_model.dart';
import 'package:greenhub/features/edit_address/logic/edit_address_cubit.dart';
import 'package:greenhub/features/edit_address/logic/edit_address_state.dart';
import 'package:greenhub/features/edit_address/ui/widgets/all_filds_form_edit_address.dart';
import 'package:greenhub/features/user/logic/user_cubit.dart';

class EditAddressScreen extends StatelessWidget {
  final AddressModel address;
  const EditAddressScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAddressCubit()..initAddress(address),
      child: const _EditAddressView(),
    );
  }
}

class _EditAddressView extends StatelessWidget {
  const _EditAddressView();

  @override
  Widget build(BuildContext context) {
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
        child: BlocConsumer<EditAddressCubit, EditAddressState>(
          listener: (context, state) {
            if (state is EditAddressSaved) {
              context.read<UserCubit>().getUserProfile();
              SuccessBottomSheet.show(
                context,
                title: mainAppBloc.isArabic
                    ? "تم تحديث العنوان بنجاح"
                    : "Address updated successfully",
                subtitle: mainAppBloc.isArabic
                    ? "تم تحديث العنوان بنجاح"
                    : "Address updated successfully",
                onDismiss: () {
                  CustomNavigator.pop();
                },
              );
            } else if (state is EditAddressError) {
              FailureBottomSheet.show(
                context,
                title: AppStrings.error.tr,
                subtitle: state.error.message,
              );
            } else if (state is EditAddressDeleted) {
              context.read<UserCubit>().getUserProfile();
              SuccessBottomSheet.show(
                context,
                title: mainAppBloc.isArabic
                    ? "تم حذف العنوان بنجاح"
                    : "Address deleted successfully",
                subtitle: mainAppBloc.isArabic
                    ? "تم حذف العنوان بنجاح"
                    : "Address deleted successfully",
                onDismiss: () {
                  CustomNavigator.pop();
                },
              );
            } else if (state is EditAddressDeleteError) {
              FailureBottomSheet.show(
                context,
                title: AppStrings.error.tr,
                subtitle: state.error.message,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditAddressCubit>();
            return Column(
              children: [
                /// 🔹 Gradient Header with Scrollable Content
                Expanded(
                  child: GradientHeaderLayout(
                    showAction: true,
                    title: AppStrings.editAddress.tr,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AllFildsFormEditAddress()
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
                        onPressed:
                            state is EditAddressSaving ||
                                state is EditAddressDeleting
                            ? () {}
                            : () => cubit.updateAddress(),
                        borderRadius: BorderRadius.circular(44),
                        width: double.infinity,
                        height: 56,
                        child: Center(
                          child:
                              state is EditAddressSaving ||
                                  state is EditAddressDeleting
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  AppStrings.save.tr,
                                  style:
                                      AppTextStyles.ibmPlexSansSize18w600White,
                                ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 350.ms, delay: 700.ms)
                    .slideY(begin: 0.5, end: 0.0, curve: Curves.fastOutSlowIn),
              ],
            );
          },
        ),
      ),
    );
  }
}
