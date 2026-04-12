import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/features/order_tracking/data/models/order_tracking_model.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';
import 'package:intl/intl.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';

class DriverInfoCard extends StatelessWidget {
  final TrackingDriver? driverInfo;
  final List<DeliveryStatus>? statusHistory;
  final String status;
  final String statusLabel;
  final int? orderId;

  const DriverInfoCard({
    Key? key,
    required this.driverInfo,
    this.statusHistory,
    this.status = 'in_transit',
    this.statusLabel = 'قيد التنفيذ',
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Status Section with border
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(239, 239, 239, 1)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainAppBloc.isArabic ? 'حالة الطلب' : 'Order Status',
                  style: AppTextStyles.ibmPlexSansSize12w400WhiteOpacity
                      .copyWith(color: const Color.fromRGBO(160, 160, 160, 1)),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 243, 227, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Color.fromRGBO(255, 145, 0, 1),
                      ),
                      Text(
                        statusLabel,
                        style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                          color: Color.fromRGBO(255, 145, 0, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2. Driver Info Section with border
          if (driverInfo != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(239, 239, 239, 1),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Driver photo
                  Container(
                    width: 48,
                    height: 48,
                    child:
                        driverInfo!.faceImage != null &&
                            driverInfo!.faceImage!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              driverInfo!.faceImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(AppImages.imageCarriers),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Carrier Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driverInfo!.name,
                          style: AppTextStyles.ibmPlexSansSize14w600White
                              .copyWith(
                                color: const Color.fromRGBO(29, 34, 77, 1),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 246, 234, 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  AppSvg.starCarriers,
                                  width: 10,
                                  height: 10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              driverInfo!.rateing,
                              style: AppTextStyles.ibmPlexSansSize12w500Title
                                  .copyWith(
                                    color: Color.fromRGBO(255, 186, 8, 1),
                                  ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${driverInfo!.numberOfRateing} تقييم)',
                              style: AppTextStyles.ibmPlexSansSize12w400Grey
                                  .copyWith(
                                    color: const Color.fromRGBO(
                                      130,
                                      134,
                                      171,
                                      1,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (driverInfo != null) const SizedBox(height: 12),

          // 3. Timeline Section with border
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(239, 239, 239, 1)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: List.generate(
                statusHistory!.length,
                (index) => _buildTimelineItem(
                  statusHistory![index],
                  isFirst: index == 0,
                  isLast: index == statusHistory!.length - 1,
                ),
              ),
            ),
          ),

          if (status == 'delivered') ...[
            const SizedBox(height: 16),
            DefaultButton(
              width: double.infinity,
              height: 50,
              text: mainAppBloc.isArabic ? 'تقييم السائق' : 'Rate Driver',
              borderRadiusValue: 44,
              textStyle: AppTextStyles.ibmPlexSansSize14w600White,
              onPressed: () {
                if (orderId != null) {
                  CustomNavigator.push(Routes.RATE_NEGOTIATION, extra: orderId);
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    DeliveryStatus status, {
    required bool isFirst,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Timeline Indicator (Left Side)
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: status.isCompleted || status.isCurrent
                      ? AppColors.primaryGreenHub
                      : Colors.transparent,
                  border: Border.all(
                    color: status.isCompleted || status.isCurrent
                        ? AppColors.primaryGreenHub
                        : const Color.fromRGBO(239, 239, 239, 1),
                    width: 2,
                  ),
                ),
                child: status.isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : status.isCurrent
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          AppSvg.loader,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    : null,
              ),
              if (!isLast)
                Container(
                  width: 3,
                  height: 50,
                  color: status.isCompleted
                      ? AppColors.primaryGreenHub
                      : const Color.fromRGBO(239, 239, 239, 1),
                ),
            ],
          ),
          const SizedBox(width: 4),

          // 2. Title Section (Middle - Expanded)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          status.title,
                          style: AppTextStyles.ibmPlexSansSize12w600Grey
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isLast ? 0 : 50),
                ],
              ),
            ),
          ),

          // 3. Date/Time Section (Right Side)
          if (status.timestamp != null)
            SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(235, 249, 245, 1),
                    ),
                    child: SvgPicture.asset(
                      AppSvg.calendar,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryGreenHub,
                        BlendMode.srcIn,
                      ),
                      width: 12,
                      height: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      _formatDateTime(status.timestamp!),
                      style: AppTextStyles.ibmPlexSansSize9w500White.copyWith(
                        color: const Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
  }
}

String getStatusText(String status) {
  switch (status) {
    case 'in_transit':
      return 'قيد التنفيذ';
    case 'delivered':
      return 'تم التسليم';
    case 'pending':
      return 'قيد الانتظار';
    default:
      return 'قيد التنفيذ';
  }
}
