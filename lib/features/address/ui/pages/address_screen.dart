import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/address/logic/address_cubit.dart';
import 'package:greenhub/features/address/logic/address_state.dart';
import 'package:greenhub/features/address/ui/widgets/address_card_widget.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: const _AddressView(),
    );
  }
}

class _AddressView extends StatelessWidget {
  const _AddressView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressCubit>();
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
        child: GradientHeaderLayout(
          showAction: true,
          style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
            color: AppColors.kWhite,
            fontSize: 22,
          ),
          title: AppStrings.chooseYourAddress.tr,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// State Builder for Addresses
                  BlocBuilder<AddressCubit, AddressState>(
                    builder: (context, state) {
                      if (state is AddressLoading) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is AddressError) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(child: Text(state.error.message)),
                        );
                      } else {
                        if (cubit.addresses.isEmpty) {
                          return _buildEmptyWidget();
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.addresses.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final address = cubit.addresses[index];
                            return AddressCardWidget(
                              isDefault: address.isDefault,
                              addressType: address.type.isNotEmpty
                                  ? address.type
                                  : AppStrings.address.tr,
                              location: address.title,
                              icon: SvgPicture.asset(
                                AppSvg.homeIcon,
                                width: 24,
                                height: 24,
                              ),
                              onEditTap: () async {
                                await CustomNavigator.push(
                                  Routes.EDIT_ADDRESS,
                                  extra: address,
                                );
                                if (context.mounted) {
                                  cubit.getAddresses();
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  /// Add New Address Button
                  DefaultButton(
                    onPressed: () async {
                      await CustomNavigator.push(Routes.ADD_ADDRESS);
                      if (context.mounted) {
                        cubit.getAddresses();
                      }
                    },
                    borderRadius: BorderRadius.circular(44),
                    width: double.infinity,
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          AppStrings.addNewAddress.tr,
                          style: AppTextStyles.ibmPlexSansSize18w600White,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(174, 207, 92, 1),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildEmptyWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.ordersEmpty),
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "ليس لديك عناوين حاليا"
                  : "You have no addresses currently",
              style: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                color: Colors.black,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "قم بانشاء طلبك الان وستصلك عروض الأسعار قريبًا"
                  : "Create your order now, and you will receive price quotes soon.",
              style: AppTextStyles.ibmPlexSansSize14w600Black.copyWith(
                color: const Color.fromRGBO(153, 153, 153, 1),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
