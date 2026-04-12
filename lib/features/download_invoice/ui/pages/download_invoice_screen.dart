import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/features/download_invoice/ui/widgets/invoice_header_widget.dart';
import 'package:greenhub/features/download_invoice/ui/widgets/invoice_details_section_widget.dart';
import 'package:greenhub/features/download_invoice/ui/widgets/qr_code_section_widget.dart';
import 'package:greenhub/features/download_invoice/ui/widgets/invoice_action_buttons_widget.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/utils/widgets/shimmer/custom_shimmer.dart';
import 'package:greenhub/features/download_invoice/logic/cubit/download_invoice_cubit.dart';
import 'package:greenhub/features/download_invoice/logic/state/download_invoice_state.dart';
import 'package:greenhub/features/download_invoice/data/services/invoice_pdf_service.dart';

class DownloadInvoiceScreen extends StatelessWidget {
  final int orderId;
  const DownloadInvoiceScreen({Key? key, required this.orderId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadInvoiceCubit()..fetchInvoice(orderId),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: CustomScaffoldWidget(
          needAppbar: false,
          backgroundColor: AppColors.kWhite,
          child: GradientHeaderLayout(
            title: AppStrings.downloadInvoice.tr,
            child: BlocBuilder<DownloadInvoiceCubit, DownloadInvoiceState>(
              builder: (context, state) {
                if (state is DownloadInvoiceLoading) {
                  return _buildShimmer();
                } else if (state is DownloadInvoiceSuccess) {
                  final data = state.invoice;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.04),
                                  offset: Offset(0, 4),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Header Section
                                InvoiceHeaderWidget(
                                  title: data.labels?.invoiceNumber != null
                                      ? (mainAppBloc.isArabic
                                            ? "فاتورة ضريبية مبسطة"
                                            : "Simplified Tax Invoice")
                                      : null,
                                  companyName: data.company?.name,
                                  address: data.company?.address,
                                ),

                                // Details Section
                                InvoiceDetailsSectionWidget(data: data),

                                // QR Code Section
                                QrCodeSectionWidget(qrImagePath: data.qrCode),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Action Buttons
                        InvoiceActionButtonsWidget(
                          onDownload: () {
                            InvoicePdfService.generateInvoicePdf(data);
                          },
                          onBackToHome: () {
                            CustomNavigator.push(
                              Routes.NAV_LAYOUT,
                              clean: true,
                            );
                          },
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  );
                } else if (state is DownloadInvoiceError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context
                              .read<DownloadInvoiceCubit>()
                              .fetchInvoice(orderId),
                          child: Text(AppStrings.tryAgain.tr),
                        ),
                      ],
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

  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const CustomShimmerContainer(height: 400),
          const SizedBox(height: 32),
          Row(
            children: [
              const Expanded(child: CustomShimmerContainer(height: 50)),
              const SizedBox(width: 16),
              const Expanded(child: CustomShimmerContainer(height: 50)),
            ],
          ),
        ],
      ),
    );
  }
}
