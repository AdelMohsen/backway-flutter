import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PaymentDetailsWidget extends StatelessWidget {
  final double? serviceCost;
  final double? vatAmount;
  final double? totalAmount;
  final double? platformFee;
  final double? driverOfferPrice;

  const PaymentDetailsWidget({
    Key? key,
    this.serviceCost,
    this.vatAmount,
    this.totalAmount,
    this.platformFee,
    this.driverOfferPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(right: 14, left: 14, top: 10),
            child: Text(
              AppStrings.paymentDetails.tr,
              style: AppTextStyles.ibmPlexSansSize16w600Black,
            ),
          ),
          // Payment Details
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  if (driverOfferPrice != null)
                    _buildPaymentRow(
                      AppStrings.driverOfferPriceLabel.tr,
                      driverOfferPrice!.toStringAsFixed(2),
                      showRiyal: true,
                    ),
                  if (serviceCost != null)
                    _buildPaymentRow(
                      mainAppBloc.isArabic ? "ارباح السائق" : "Driver Earnings",
                      serviceCost!.toStringAsFixed(2),
                      showRiyal: true,
                    ),
                  if (platformFee != null)
                    _buildPaymentRow(
                      AppStrings.platformFeeLabel.tr,
                      platformFee!.toStringAsFixed(0),
                      suffix: '%',
                    ),
                  if (vatAmount != null)
                    _buildPaymentRow(
                      isgreen: true,
                      AppStrings.vatPercentageLabel.tr,
                      vatAmount!.toStringAsFixed(0),
                      suffix: '%',
                    ),
                  const SizedBox(height: 10),
                  if (totalAmount != null)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(247, 247, 247, 1),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppStrings.totalAmount.tr,
                              style: AppTextStyles.ibmPlexSansSize16w600Black
                                  .copyWith(
                                    color: const Color.fromRGBO(29, 34, 77, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Text(
                            '${totalAmount!.toStringAsFixed(2)}',
                            style: AppTextStyles.ibmPlexSansSize18w700Primary
                                .copyWith(
                                  color: AppColors.primaryGreenHub,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 25,
                            child: SvgPicture.asset(
                              AppSvg.riyal,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primaryGreenHub,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value, {
    bool showRiyal = false,
    String? suffix,
    bool isgreen = false,
    TextStyle? style,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style:
                  style ??
                  AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                    color: const Color.fromRGBO(107, 114, 128, 1),
                  ),
            ),
          ),
          Text(
            '$value',
            style: AppTextStyles.cairoW600Size16White.copyWith(
              color: isgreen ? AppColors.primaryGreenHub : AppColors.kBlack,
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 25,
            child: showRiyal
                ? SvgPicture.asset(
                    AppSvg.riyal,
                    colorFilter: ColorFilter.mode(
                      isgreen
                          ? AppColors.primaryGreenHub
                          : const Color.fromRGBO(165, 165, 165, 1),
                      BlendMode.srcIn,
                    ),
                  )
                : suffix != null
                ? Text(
                    suffix,
                    style: AppTextStyles.cairoW600Size16White.copyWith(
                      color: isgreen
                          ? AppColors.primaryGreenHub
                          : AppColors.kBlack,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
