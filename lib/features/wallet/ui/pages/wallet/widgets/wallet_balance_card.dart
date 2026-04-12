import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/wallet/logic/cubit/wallet_cubit.dart';
import 'package:greenhub/features/wallet/logic/state/wallet_state.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 246, 245, 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.totalCurrentBalance.tr,
                    style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
                      color: AppColors.kDescriptionText,
                    ),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 16,
                    color: AppColors.kDescriptionText,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGreenHub,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  if (state is WalletError) {
                    return Text(
                      '---',
                      style: AppTextStyles.ibmPlexSansSize31w700Black.copyWith(
                        color: const Color.fromRGBO(51, 51, 51, 1),
                      ),
                    );
                  }

                  if (state is WalletLoaded || state is WalletPaginationLoading) {
                    final balanceData = state is WalletLoaded
                        ? state.balanceData
                        : (state as WalletPaginationLoading).balanceData;

                    final balance = balanceData?.balance?.toString() ?? '0';
                    final isSar = balanceData?.currency == 'SAR';

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          balance,
                          style: AppTextStyles.ibmPlexSansSize31w700Black.copyWith(
                            color: const Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        if (isSar) ...[
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AppSvg.riyal,
                            width: 16,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              AppColors.primaryGreenHub,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
          SvgPicture.asset(AppSvg.wallet, width: 65, height: 65),
        ],
      ),
    );
  }
}
