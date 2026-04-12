import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/features/order_tracking/logic/order_tracking_cubit.dart';
import 'package:greenhub/features/order_tracking/logic/order_tracking_state.dart';
import 'package:greenhub/features/order_tracking/ui/widgets/driver_info_card.dart';
import 'package:greenhub/features/order_tracking/ui/widgets/tracking_map_widget.dart';
import 'package:greenhub/features/order_tracking/data/models/order_tracking_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final int? orderId;

  const OrderTrackingScreen({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderId != null) {
      context.read<OrderTrackingCubit>().loadOrderTracking(orderId!);
    }

    return CustomScaffoldWidget(
      needAppbar: false,
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<OrderTrackingCubit>().refreshTracking();
        },
        child: BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
          builder: (context, state) {
            if (state is OrderTrackingLoading ||
                state is OrderTrackingInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrderTrackingError) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'حدث خطأ: ${state.error.message}',
                          style: AppTextStyles.ibmPlexSansSize16w600Black,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is OrderTrackingLoaded) {
              final orderData = state.orderData;
              final statusHistory = StatusMapper.mapStatusToHistory(orderData);

              return Stack(
                children: [
                  // Map view (full screen background)
                  Positioned.fill(
                    child: TrackingMapWidget(orderData: orderData),
                  ),

                  // Bottom sheet with order info
                  DraggableScrollableSheet(
                    initialChildSize: 0.25, // Start lower down
                    minChildSize: 0.2,
                    maxChildSize: 0.6,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Drag handle
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Content
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: DriverInfoCard(
                                  orderId: orderId,
                                  statusHistory: statusHistory,
                                  driverInfo: orderData.order.driver,
                                  status: orderData.order.status.key,
                                  statusLabel: orderData.order.status.label,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
