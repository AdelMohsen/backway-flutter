import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/wallet/logic/cubit/wallet_cubit.dart';
import 'package:greenhub/features/wallet/ui/pages/wallet/widgets/transaction_history_widget.dart';
import 'package:greenhub/features/wallet/ui/pages/wallet/widgets/wallet_balance_card.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
        child: GradientHeaderLayout(
          title: AppStrings.myWallet.tr,
          child: Builder(
            builder: (context) {
              return RefreshIndicator(
                color: AppColors.primaryGreenHub,
                onRefresh: () async {
                  await context.read<WalletCubit>().onRefresh(type: 'credit');
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const WalletBalanceCard(),
                      const SizedBox(height: 20),
                      DefaultButton(
                            onPressed: () {
                              context.pushNamed(Routes.RECHARGE);
                            },
                            backgroundColor: AppColors.primaryGreenHub,
                            borderRadiusValue: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppStrings.addBalance.tr,
                                  style: AppTextStyles
                                      .ibmPlexSansSize16w700Black
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 16,
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
                          ),
                      const SizedBox(height: 30),
                      const TransactionHistoryWidget(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
