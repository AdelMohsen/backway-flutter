import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/features/choice_type_order/ui/widgets/order_type_card.dart';
import 'package:greenhub/features/negotiation_offers/data/repository/negotiation_offers_repository.dart';
import 'package:greenhub/core/services/toast/toast_service.dart';

class BottomChoiceServicesType extends StatefulWidget {
  final int orderId;
  const BottomChoiceServicesType({super.key, required this.orderId});

  @override
  State<BottomChoiceServicesType> createState() =>
      _BottomChoiceServicesTypeState();
}

class _BottomChoiceServicesTypeState extends State<BottomChoiceServicesType> {
  int selectedType = 0; // 0 = Quick Order, 1 = Regular Order
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Drag Handle
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(224, 224, 224, 1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          /// Title
          Text(
            mainAppBloc.isArabic
                ? 'اختر نوع الخدمة؟'
                : 'Choose your service type?',
            style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          /// Order Type Cards
          Row(
            children: [
              /// Quick Order Card
              Expanded(
                child: OrderTypeCard(
                  isSelected: selectedType == 0,
                  image: AppImages.ser1,
                  title: mainAppBloc.isArabic ? 'تحميل' : 'Loading ',
                  subtitle: mainAppBloc.isArabic
                      ? 'أسرع طريقة لإرسال شحنتك الآن'
                      : 'The fastest way to send your shipment now',
                  onTap: () {
                    setState(() {
                      selectedType = 0;
                    });
                  },
                ),
              ),

              const SizedBox(width: 12),

              /// Regular Order Card
              Expanded(
                child: OrderTypeCard(
                  isSelected: selectedType == 1,
                  image: AppImages.ser2,
                  title: mainAppBloc.isArabic ? 'تركيب' : 'Installation',
                  subtitle: mainAppBloc.isArabic
                      ? "جدول شحنتك لوقت لاحق"
                      : 'Schedule your shipment for a later time',
                  onTap: () {
                    setState(() {
                      selectedType = 1;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// Confirm Button
          DefaultButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final serviceType = selectedType == 0 ? 'loading' : 'installation';
                    final result = await NegotiationOffersRepository.addService(
                      orderId: widget.orderId,
                      serviceType: serviceType,
                    );
                    
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                      result.fold(
                        (error) => ToastService.showError(error.message, context),
                        (success) => CustomNavigator.pop(),
                      );
                    }
                  },
            borderRadius: BorderRadius.circular(44),
            width: double.infinity,
            height: 56,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      mainAppBloc.isArabic ? 'التالى' : 'Next',
                      style: AppTextStyles.ibmPlexSansSize18w600White,
                    ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BottomChoiceServicesTypeBottomSheet {
  static void show(BuildContext context, {required int orderId}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BottomChoiceServicesType(orderId: orderId),
    );
  }
}
