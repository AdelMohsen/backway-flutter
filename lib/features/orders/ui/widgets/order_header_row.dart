import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';

import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import '../../data/models/orders_model.dart';

class OrderHeaderRow extends StatelessWidget {
  final OrderModel order;
  final Widget statusChip;

  const OrderHeaderRow({
    super.key,
    required this.order,
    required this.statusChip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Expanded(
          child: Row(
            children: [
              // Box Icon in Circle
              const SizedBox(width: 8),

              if (order.pickup?.avatar != null)
                CircleAvatar(
                  radius: 22.5,
                  backgroundImage: NetworkImage(order.pickup!.avatar!),
                )
              else
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(AppSvg.delivery),
                  ),
                ),

              const SizedBox(width: 8),

              // Order ID
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.orderNumber.tr,
                      style: AppTextStyles.ibmPlexSansSize12w400Grey,
                    ),
                    Text(
                      order.orderNumber ?? '',
                      style: AppTextStyles.ibmPlexSansSize14w700Primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Status Chip
        statusChip,
      ],
    );
  }
}
