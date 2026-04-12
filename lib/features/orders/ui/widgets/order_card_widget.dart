import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/orders/logic/orders_cubit.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/features/orders/ui/widgets/details_order.dart';
import 'package:greenhub/features/orders/ui/widgets/order_action_buttons.dart';
import 'package:greenhub/features/orders/ui/widgets/order_header_row.dart';
import 'package:greenhub/features/orders/ui/widgets/order_location_timeline.dart';
import 'package:greenhub/features/orders/ui/widgets/order_status_chip.dart';
import '../../data/models/orders_model.dart';
import '../../../../features/order_details/ui/widgets/order_details_cancel_bottom_sheet.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;
  final int tabIndex; // 0: Scheduled, 1: In Transit, 2: Previous

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 18,
          end: 18,
          top: 15,
          bottom: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),

            // Row 1: Header with order ID and status
            OrderHeaderRow(
              order: order,
              statusChip: OrderStatusChip(order: order, tabIndex: tabIndex),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: Divider(
                color: Color.fromRGBO(247, 247, 247, 1),
                thickness: 1,
              ),
            ),

            // Row 2: Location Timeline
            OrderLocationTimeline(order: order),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: Divider(
                color: Color.fromRGBO(247, 247, 247, 1),
                thickness: 1,
              ),
            ),
            const SizedBox(height: 8),

            // Row 3: Info Chips (Time, Vehicle, Weight)
            DetailsOrder(order: order, tabIndex: tabIndex),
            tabIndex == 0 ? SizedBox.shrink() : const SizedBox(height: 16),

            // Row 4: Action Buttons
            OrderActionButtons(
              tabIndex: tabIndex,
              onCancelOrder: order.status?.key == 'pending' || order.status?.key == 'new'
                  ? () {
                      OrderDetailsCancelBottomSheet.show(
                        context,
                        orderId: order.id!,
                        onCancelSuccess: () {
                          context.read<OrdersCubit>().loadOrders(isRefresh: true);
                        },
                      );
                    }
                  : null,
              onShipmentDetails: () {
                CustomNavigator.push(Routes.ORDER_DETAILS, extra: order.id);
              },
              onTrackOrder: () {
                CustomNavigator.push(
                  Routes.ORDER_TRACKING,
                  pathParameters: {'orderId': order.id.toString()},
                );
              },
              onOrderDetails: () {
                CustomNavigator.push(Routes.ORDER_DETAILS, extra: order.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
