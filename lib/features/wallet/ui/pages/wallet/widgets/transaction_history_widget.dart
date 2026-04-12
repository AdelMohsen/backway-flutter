import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/wallet/data/models/wallet_transactions_model.dart';
import 'package:greenhub/features/wallet/logic/cubit/wallet_cubit.dart';
import 'package:greenhub/features/wallet/logic/state/wallet_state.dart';
import 'package:intl/intl.dart';

class TransactionHistoryWidget extends StatefulWidget {
  const TransactionHistoryWidget({super.key});

  @override
  State<TransactionHistoryWidget> createState() =>
      _TransactionHistoryWidgetState();
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(
                color: AppColors.primaryGreenHub,
              ),
            ),
          );
        }

        if (state is WalletError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                state.error.message,
                style: AppTextStyles.ibmPlexSansSize12w400Grey,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state is WalletLoaded || state is WalletPaginationLoading) {
          final transactions = state is WalletLoaded
              ? state.transactions
              : (state as WalletPaginationLoading).transactions;
          final total = state is WalletLoaded
              ? state.total
              : (state as WalletPaginationLoading).total;
          final currentPage = state is WalletLoaded
              ? state.currentPage
              : (state as WalletPaginationLoading).currentPage;
          final lastPage = state is WalletLoaded
              ? state.lastPage
              : (state as WalletPaginationLoading).lastPage;

          if (transactions.isEmpty) {
            return _buildEmptyWidget();
          }

          final showLoadMore = _isExpanded && currentPage < lastPage;
          final displayCount = _isExpanded
              ? transactions.length + (showLoadMore ? 1 : 0)
              : (transactions.length > 10 ? 10 : transactions.length);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.transactionHistory.tr,
                          style: AppTextStyles.ibmPlexSansSize18w600White
                              .copyWith(color: AppColors.nutral01),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($total)',
                          style: AppTextStyles.ibmPlexSansSize12w400Grey,
                        ),
                      ],
                    ),
                    if (!_isExpanded && transactions.length > 10)
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isExpanded = true;
                          });
                        },
                        child: Text(
                          AppStrings.seeAll.tr,
                          style: AppTextStyles.ibmPlexSansSize12w600Grey
                              .copyWith(
                                color: const Color.fromRGBO(145, 145, 145, 1),
                              ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayCount,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (_isExpanded && index == transactions.length) {
                    // Load more trigger
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<WalletCubit>().fetchMoreTransactions(
                        type: 'credit',
                      );
                    });
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryGreenHub,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    );
                  }
                  return _buildTransactionItem(transactions[index]);
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTransactionItem(WalletTransactionModel transaction) {
    final isDeposit = transaction.type == 'deposit';
    final amountPrefix = isDeposit ? '+' : '-';
    final amountColor = isDeposit
        ? AppColors.primaryGreenHub
        : const Color(0xFFE53935);

    // Format the date
    String formattedDate = '';
    if (transaction.createdAt != null) {
      try {
        final dateTime = DateTime.parse(transaction.createdAt!);
        final now = DateTime.now();
        final isToday =
            dateTime.year == now.year &&
            dateTime.month == now.month &&
            dateTime.day == now.day;
        if (isToday) {
          formattedDate =
              '${AppStrings.today.tr} ${DateFormat('hh:mm a').format(dateTime)}';
        } else {
          formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
        }
      } catch (_) {
        formattedDate = transaction.createdAt ?? '';
      }
    }

    // Format transaction ID display
    final displayId = transaction.transactionId ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF7F7F7)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(AppSvg.delivery, width: 20, height: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${AppStrings.orderNumber.tr}: ',
                              style: AppTextStyles.ibmPlexSansSize10w400Grey,
                            ),
                            TextSpan(
                              text: displayId,
                              style: AppTextStyles.ibmPlexSansSize12w700Black
                                  .copyWith(color: AppColors.primaryGreenHub),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$amountPrefix${transaction.amount ?? '0'}',
                          style: AppTextStyles.ibmPlexSansSize16w700Black
                              .copyWith(fontSize: 14, color: amountColor),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          AppSvg.riyal,
                          width: 12,
                          height: 12,
                          colorFilter: ColorFilter.mode(
                            const Color.fromRGBO(174, 207, 92, 1),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(237, 246, 245, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AppSvg.calendar,
                              width: 14,
                              height: 14,
                              colorFilter: ColorFilter.mode(
                                AppColors.primaryGreenHub,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formattedDate,
                          style: AppTextStyles.ibmPlexSansSize10w400Grey
                              .copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: isDeposit
                                ? AppColors.primaryGreenHub
                                : const Color(0xFFE53935),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(
                            isDeposit
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: AppColors.kWhite,
                            size: 10,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isDeposit
                              ? AppStrings.deposit.tr
                              : AppStrings.withdrawal.tr,
                          style: AppTextStyles.ibmPlexSansSize10w400Grey
                              .copyWith(
                                fontSize: 10,
                                color: isDeposit
                                    ? AppColors.primaryGreenHub
                                    : const Color(0xFFE53935),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
            Image.asset(AppImages.offersEmpty),
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "ليس لديك معاملات حاليا"
                  : "You have no transactions currently",
              style: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                color: Colors.black,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "قم باضافة رصيد لحسابك"
                  : "Add balance to your account",
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
