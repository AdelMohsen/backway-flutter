import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/services/toast/toast_service.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/nav_layout/cubit/navbar_layout_cubit.dart';
import 'package:greenhub/features/wallet/logic/cubit/add_funds_cubit.dart';
import 'package:greenhub/features/wallet/logic/cubit/wallet_cubit.dart';
import 'package:greenhub/features/wallet/logic/state/add_funds_state.dart';
import 'package:greenhub/features/recharge_balance/widget/formfileds_recharge_widget.dart';

class RechargeBalanceScreen extends StatefulWidget {
  const RechargeBalanceScreen({super.key});

  @override
  State<RechargeBalanceScreen> createState() => _RechargeBalanceScreenState();
}

class _RechargeBalanceScreenState extends State<RechargeBalanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedPaymentMethod = 'madaCard';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFundsCubit(),
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
          child: GradientHeaderLayout(
            title: AppStrings.rechargeBalance.tr,
            child: BlocListener<AddFundsCubit, AddFundsState>(
              listener: (context, state) {
                if (state is AddFundsSuccess) {
                  ToastService.showSuccess(
                    AppStrings.rechargeSuccess.tr,
                    context,
                  );
                  final navCubit = NavbarLayoutCubit.get(context);

                  // Try to refresh wallet data immediately
                  try {
                    final walletCubit = context.read<WalletCubit>();
                    walletCubit.onRefresh(type: 'credit');
                  } catch (_) {
                    // WalletCubit not available in current context,
                    // will refresh when navigating back to wallet screen
                  }

                  CustomNavigator.pop();
                  Future.delayed(const Duration(milliseconds: 350), () {
                    // Navigate to wallet tab (More screen)
                    navCubit.changeIndex(4);
                  });
                }
                if (state is AddFundsError) {
                  ToastService.showError(state.error.message, context);
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.enterAmount.tr,
                        style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                          color: const Color.fromRGBO(103, 103, 103, 1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FormfiledsRechargeWidget(
                        amountController: _amountController,
                        selectedPaymentMethod: _selectedPaymentMethod,
                        onPaymentMethodChanged: (val) {
                          setState(() {
                            _selectedPaymentMethod = val;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      BlocBuilder<AddFundsCubit, AddFundsState>(
                        builder: (context, state) {
                          final isLoading = state is AddFundsLoading;
                          return DefaultButton(
                                height: 56,
                                isLoading: isLoading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final amountText = _amountController.text
                                        .trim();
                                    final amount = double.tryParse(amountText);

                                    context.read<AddFundsCubit>().addFunds(
                                      amount: amount!,
                                      paymentMethod: 'credit_card',
                                    );
                                  }
                                },
                                backgroundColor: AppColors.primaryGreenHub,
                                borderRadiusValue: 25,
                                child: isLoading
                                    ? Center(
                                        child:
                                            LoadingAnimationWidget.staggeredDotsWave(
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppStrings.recharge.tr,
                                            style: AppTextStyles
                                                .ibmPlexSansSize16w600Black
                                                .copyWith(color: Colors.white),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFAECF5C),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                              .animate()
                              .fadeIn(duration: 350.ms, delay: 700.ms)
                              .slideY(
                                begin: 0.5,
                                end: 0.0,
                                curve: Curves.fastOutSlowIn,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
