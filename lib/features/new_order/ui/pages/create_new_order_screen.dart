import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';

import 'package:greenhub/features/new_order/logic/cubit/create_order_cubit.dart';
import 'package:greenhub/features/new_order/logic/state/create_order_state.dart';
import 'package:greenhub/features/new_order/ui/widgets/List_carriers_widget.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order.dart';
import 'package:greenhub/features/new_order/ui/widgets/payment_widget.dart';
import 'package:greenhub/features/nav_layout/cubit/navbar_layout_cubit.dart';

import 'package:greenhub/features/orders/logic/orders_cubit.dart';

class CreateNewOrderScreen extends StatefulWidget {
  final int? orderType;
  const CreateNewOrderScreen({Key? key, this.orderType}) : super(key: key);

  @override
  State<CreateNewOrderScreen> createState() => _CreateNewOrderScreenState();
}

class _CreateNewOrderScreenState extends State<CreateNewOrderScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateOrderCubit>(
      create: (context) => CreateOrderCubit()
        ..loadVehicleTypes()
        ..loadPackageTypes(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: BlocListener<CreateOrderCubit, CreateOrderState>(
          listener: (context, state) {
            if (state is CreateOrderSuccess) {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.response.message.isNotEmpty
                        ? state.response.message
                        : AppStrings.orderCreatedSuccessfully.tr,
                  ),
                  backgroundColor: AppColors.primaryGreenHub,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );

              final cubit = NavbarLayoutCubit.get(context);
              CustomNavigator.pop(result: 'new');
              Future.delayed(const Duration(milliseconds: 350), () {
                OrdersCubit.nextInitialTabIndex = 0;
                cubit.changeIndex(3);
              });
            } else if (state is CreateOrderError) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error.message.isNotEmpty
                        ? state.error.message
                        : AppStrings.orderCreationFailed.tr,
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
              // Stay on current screen — do nothing
            }
          },
          child: CustomScaffoldWidget(
            needAppbar: false,
            child: GradientHeaderLayout(
              showAction: true,
              title: AppStrings.createNewOrder.tr,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _buildStepperProgress(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Color.fromRGBO(255, 255, 255, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            offset: Offset(2, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Content based on current step
                    Expanded(child: _buildStepContent()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepperProgress() {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 4),
            _buildStepLabel(AppStrings.orderDetails.tr, currentStep >= 0),
            _buildStepLabel(AppStrings.carriersList.tr, currentStep >= 1),
            _buildStepLabel(AppStrings.payment.tr, currentStep >= 2),
            SizedBox(width: 4),
          ],
        ),
        const SizedBox(height: 8),
        // Circles and lines row
        Row(
          children: [
            SizedBox(width: 55),
            _buildCircle(
              isActive: currentStep == 0,
              isCompleted: currentStep > 0,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 3,
                color: currentStep > 0
                    ? AppColors.primaryGreenHub
                    : AppColors.textGrey.withAlpha(40),
              ),
            ),
            const SizedBox(width: 8),
            _buildCircle(
              isActive: currentStep == 1,
              isCompleted: currentStep > 1,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 3,
                color: currentStep > 1
                    ? AppColors.primaryGreenHub
                    : AppColors.textGrey.withAlpha(40),
              ),
            ),
            const SizedBox(width: 8),
            _buildCircle(
              isActive: currentStep == 2,
              isCompleted: currentStep > 2,
            ),
            SizedBox(width: 55),
          ],
        ),
      ],
    );
  }

  Widget _buildStepLabel(String label, bool isActiveOrCompleted) {
    return Text(
      label,
      style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
        color: isActiveOrCompleted ? AppColors.kBlack : AppColors.textGrey,
        fontWeight: isActiveOrCompleted ? FontWeight.w600 : FontWeight.w400,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCircle({required bool isActive, required bool isCompleted}) {
    return Container(
      width: isActive || isCompleted ? 28 : 18,
      height: isActive || isCompleted ? 28 : 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive || isCompleted
            ? AppColors.primaryGreenHub
            : Colors.transparent,
        border: Border.all(
          color: isActive || isCompleted
              ? AppColors.primaryGreenHub
              : AppColors.textGrey.withAlpha(80),
          width: 2,
        ),
      ),
      child: Center(
        child: isActive
            ? SvgPicture.asset(AppSvg.loader, width: 15, height: 15)
            : isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return DetailsOrderWidget(
          step: currentStep,
          orderType: widget.orderType,
          onNextStep: () {
            setState(() {
              currentStep = 1;
            });
          },
        );
      case 1:
        return ListCarriersWidget(
          step: currentStep,
          onNextStep: () {
            setState(() {
              currentStep = 2;
            });
          },
        );
      case 2:
        return PaymentWidget();
      default:
        return const SizedBox.shrink();
    }
  }
}
