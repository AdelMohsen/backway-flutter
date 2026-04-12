import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/features/choice_type_order/ui/widgets/order_type_card.dart';

class ChoiceTypeOrderContent extends StatefulWidget {
  const ChoiceTypeOrderContent();

  @override
  State<ChoiceTypeOrderContent> createState() => _ChoiceTypeOrderContentState();
}

class _ChoiceTypeOrderContentState extends State<ChoiceTypeOrderContent> {
  int selectedType = 0; // 0 = Quick Order, 1 = Regular Order

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
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
            mainAppBloc.isArabic ? 'اختر نوع طلبك؟' : 'Choose your order type?',
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
                  image: AppImages.serviceDelivery,
                  title: mainAppBloc.isArabic ? 'طلب فورى' : 'Quick Order',
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
                  image: AppImages.serviceInstallation,
                  title: mainAppBloc.isArabic ? 'طلب بموعَد ' : 'Regular Order',
                  subtitle: mainAppBloc.isArabic
                      ? 'جدول شحنتك لوقت لاحق'
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
            onPressed: () async {
              final result = await CustomNavigator.push(
                Routes.CreateNewOrderScreen,
                extra: selectedType,
              );
              if (result == 'new') {
                CustomNavigator.pop();
              }
            },
            borderRadius: BorderRadius.circular(44),
            width: double.infinity,
            height: 56,
            child: Center(
              child: Text(
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
