import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

import '../../data/models/orders_model.dart';

class OrderLocationTimeline extends StatelessWidget {
  final OrderModel order;

  const OrderLocationTimeline({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 4, end: 2, top: 12),
      child: Stack(
        children: [
          // Background Dashed Line exactly at the center axis of the markers
          Positioned(
            top: 12.5, // Center of the 25x25 marker circles
            left: mainAppBloc.isArabic ? 110 : 10,
            right: mainAppBloc.isArabic
                ? 10
                : 110, // Account for the right padding on the second column
            child: LayoutBuilder(
              builder: (context, constraints) {
                final boxWidth = constraints.constrainWidth();
                const dashWidth = 4.0;
                const dashSpace = 4.0;
                const dashHeight = 1.0;
                final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
                return Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: List.generate(dashCount, (_) {
                    return const SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          // Foreground Content (Original Left/Right Row Layout)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // From Column (Pickup)
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // From Icon
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryGreenHub),
                        color: Color.fromRGBO(247, 247, 247, 1),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(AppSvg.marker),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.from.tr,
                      style: AppTextStyles.ibmPlexSansSize12w500Grey.copyWith(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.pickup?.address ?? '',
                      style: AppTextStyles.ibmPlexSansSize14w600Black,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              // To Column (Delivery)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: mainAppBloc.isArabic ? 5 : 0,
                    start: mainAppBloc.isArabic ? 16 : 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // To Icon exactly aligned above its text
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(AppSvg.marker),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.to.tr,
                        style: AppTextStyles.ibmPlexSansSize12w500Grey.copyWith(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.delivery?.address ?? '',
                        style: AppTextStyles.ibmPlexSansSize14w600Black,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
