import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/features/order_details/logic/cubit/order_details_cubit.dart';
import 'package:greenhub/features/order_details/logic/state/order_details_state.dart';
import 'package:greenhub/features/order_details/ui/widgets/order_number_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/shipment_images_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/transport_type_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/shipment_data_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/address_details_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/notes_details_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/carrier_details_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/payment_details_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/invoice_button_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/payment_method_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/order_action_buttons_widget.dart';
import 'package:greenhub/features/order_details/ui/widgets/order_details_cancel_bottom_sheet.dart';
import 'package:greenhub/features/offers/logic/cubit/open_chat_cubit.dart';
import 'package:greenhub/features/offers/logic/state/open_chat_state.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int? orderId;
  const OrderDetailsScreen({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderId == null) {
      return Scaffold(
        appBar: AppBar(title: Text(AppStrings.orderDetailsTitle.tr)),
        body: Center(
          child: Text(
            mainAppBloc.isArabic
                ? "معرّف الطلب غير صالح."
                : "Invalid Order ID.",
          ),
        ),
      );
    }
    return BlocProvider(
      create: (context) => OrderDetailsCubit()..fetchOrderDetails(orderId!),
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
          backgroundColor: AppColors.kWhite,
          child: GradientHeaderLayout(
            title: AppStrings.orderDetailsTitle.tr,
            child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
              builder: (context, state) {
                if (state is OrderDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OrderDetailsError) {
                  return Center(
                    child: Text(
                      state.error.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is OrderDetailsLoaded) {
                  final order = state.order;
                  final driver = order.negotiations?.isNotEmpty == true
                      ? order.negotiations!.first.driver
                      : order.driver;

                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<OrderDetailsCubit>().onRefresh(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          // Order Number Section
                          OrderNumberWidget(
                            orderNumber: order.orderNumber ?? '',
                          ),

                          const SizedBox(height: 16),

                          // Transport Type Section
                          TransportTypeWidget(
                            transportType: mainAppBloc.isArabic
                                ? (order.vehicleType?.nameAr ??
                                      order.vehicleType?.name ??
                                      '')
                                : (order.vehicleType?.nameEn ??
                                      order.vehicleType?.name ??
                                      ''),
                            transportSubType: '',
                          ),

                          const SizedBox(height: 16),

                          // Shipment Data Section
                          ShipmentDataWidget(
                            weight: '${order.package?.weight ?? ''} KG',
                            shipmentType: mainAppBloc.isArabic
                                ? (order.package?.type?.nameAr ?? '')
                                : (order.package?.type?.nameEn ?? ''),
                            receiverPhone: order.pickup?.contactPhone ?? '',
                          ),

                          if (order.package?.images != null &&
                              order.package!.images!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            ShipmentImagesWidget(
                              images: order.package!.images!,
                            ),
                          ],

                          const SizedBox(height: 16),

                          // Address Section
                          AddressDetailsWidget(
                            pickupPoint: order.pickup?.address ?? '',
                            pickupCity: '',
                            destination: order.delivery?.address ?? '',
                            destinationCity: '',
                          ),

                          const SizedBox(height: 16),

                          // Notes Section
                          if (order.notes != null &&
                              order.notes!.isNotEmpty) ...[
                            NotesDetailsWidget(notes: order.notes!),
                            const SizedBox(height: 16),
                          ],

                          // Carrier Details Section
                          if (driver != null) ...[
                            BlocProvider(
                              create: (context) => OpenChatCubit(),
                              child: BlocConsumer<OpenChatCubit, OpenChatState>(
                                listener: (context, state) {
                                  if (state is OpenChatSuccess) {
                                    CustomNavigator.push(
                                      Routes.NEGOTIATION_OFFERS,
                                      extra:
                                          state.model.data?.chat?.orderId ??
                                          order.id,
                                    );
                                  } else if (state is OpenChatError) {
                                    CustomToast.showError(
                                      context,
                                      message: state.error.message,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return CarrierDetailsWidget(
                                    carrierName: driver.name ?? '',
                                    carrierImage: driver.faceImage,
                                    rating:
                                        double.tryParse(
                                          driver.rateing ?? '0',
                                        ) ??
                                        0.0,
                                    reviewsCount: driver.numberOfRateing ?? '0',
                                    isChatLoading: state is OpenChatLoading,
                                    onTalkWithDriver:
                                        order.status?.key == 'negotiating'
                                        ? null
                                        : () {
                                            if (order.id != null) {
                                              context
                                                  .read<OpenChatCubit>()
                                                  .openChat(orderId: order.id!);
                                            }
                                          },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Details to hide when pending
                          if (order.status?.key != 'pending') ...[
                            // Payment Details Section
                            PaymentDetailsWidget(
                              driverOfferPrice: double.tryParse(
                                order.pricing?.driverOfferPrice?.toString() ??
                                    '',
                              ),
                              serviceCost: double.tryParse(
                                order.pricing?.driverEarnings?.toString() ?? '',
                              ),
                              platformFee: double.tryParse(
                                order.pricing?.platformFee?.toString() ?? '',
                              ),
                              vatAmount: double.tryParse(
                                order.pricing?.vatAmount?.toString() ?? '',
                              ),
                              totalAmount: double.tryParse(
                                order.pricing?.finalPrice?.toString() ?? '',
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Invoice Button
                            InvoiceButtonWidget(
                              onTap: () {
                                CustomNavigator.push(
                                  Routes.DOWNLOAD_INVOICE,
                                  extra: order.id,
                                );
                              },
                            ),

                            const SizedBox(height: 24),

                            // Payment Method Section
                            const PaymentMethodWidget(methodName: 'بطاقة مدى'),

                            const SizedBox(height: 24),
                          ],

                          // Action Buttons
                          OrderActionButtonsWidget(
                            orderStatus: order.status?.key,
                            onCancelOrder: order.status?.key == 'pending'
                                ? () {
                                    OrderDetailsCancelBottomSheet.show(
                                      context,
                                      orderId: orderId!,
                                    );
                                  }
                                : null,
                            onTrackOrder: () {
                              CustomNavigator.push(
                                Routes.ORDER_TRACKING,
                                pathParameters: {
                                  'orderId': order.id.toString(),
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
