import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/services/toast/toast_service.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_username_form_field.dart';
import 'package:greenhub/features/order_details/logic/cubit/cancel_order_cubit.dart';
import 'package:greenhub/features/order_details/logic/state/cancel_order_state.dart';

class OrderDetailsCancelBottomSheet extends StatefulWidget {
  final int orderId;
  final VoidCallback? onCancelSuccess;
  const OrderDetailsCancelBottomSheet({
    Key? key,
    required this.orderId,
    this.onCancelSuccess,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required int orderId,
    VoidCallback? onCancelSuccess,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => OrderDetailsCancelBottomSheet(
        orderId: orderId,
        onCancelSuccess: onCancelSuccess,
      ),
    );
  }

  @override
  State<OrderDetailsCancelBottomSheet> createState() =>
      _OrderDetailsCancelBottomSheetState();
}

class _OrderDetailsCancelBottomSheetState
    extends State<OrderDetailsCancelBottomSheet> {
  final _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CancelOrderDetailsCubit(),
      child: BlocConsumer<CancelOrderDetailsCubit, CancelOrderDetailsState>(
        listener: (context, state) {
          if (state is CancelOrderDetailsSuccess) {
            ToastService.showSuccess(
              state.model.message?.isNotEmpty == true
                  ? state.model.message!
                  : AppStrings.cancelOrderSuccess.tr,
              context,
            );
            CustomNavigator.pop();
            if (widget.onCancelSuccess != null) {
              widget.onCancelSuccess!();
            } else {
              // Navigate to main nav layout at index 3 (Orders Tab)
              CustomNavigator.pushReplacement(
                Routes.NAV_LAYOUT,
                extra: Routes.orders,
              );
            }
          }
          if (state is CancelOrderDetailsError) {
            ToastService.showError(state.error.message, context);
          }
        },
        builder: (context, state) {
          final isLoading = state is CancelOrderDetailsLoading;
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag Handle
                      Center(
                        child: Container(
                          width: 48,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.cancelOrderReason.tr,
                            style: AppTextStyles.ibmPlexSansSize18w600White
                                .copyWith(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () => CustomNavigator.pop(),
                            child: Container(
                              child: Center(
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromRGBO(161, 161, 161, 1),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Divider(
                          height: 1,
                          color: Color.fromRGBO(225, 233, 239, 1),
                        ),
                      ),

                      const SizedBox(height: 12),

                      DefaultUsernameFormField(
                        controller: _reasonController,
                        hintText: AppStrings.cancelOrderReason.tr,
                        fillColor: const Color(0xffF7F7F7),
                        borderRadious: 44,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                          15,
                          15,
                          15,
                          15,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppStrings.pleaseEnterCancelReason.tr;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Confirm Button
                      DefaultButton(
                        text: AppStrings.confirm.tr,
                        backgroundColor: AppColors.primaryGreenHub,
                        borderRadiusValue: 45,
                        height: 60,
                        isLoading: isLoading,
                        onPressed: () {
                          _onSubmit(context);
                        },
                        textStyle: AppTextStyles.ibmPlexSansSize16w600Black
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final reasonText = _reasonController.text.trim();

    CancelOrderDetailsCubit.get(context).cancelOrder(
      orderId: widget.orderId,
      reason: reasonText,
    );
  }
}
