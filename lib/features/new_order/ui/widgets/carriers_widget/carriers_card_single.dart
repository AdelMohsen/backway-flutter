import 'package:flutter/material.dart';
import 'package:greenhub/features/new_order/ui/widgets/List_carriers_widget.dart';
import 'package:greenhub/features/new_order/ui/widgets/carriers_widget/carrier_action_button.dart';

class CarrierCard extends StatelessWidget {
  const CarrierCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(2, 4),
            blurRadius: 4,
          ),
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadiusDirectional.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
            child: const CarrierInfoRow(
              name: 'معاذ خالد الحيطان',
              price: 100,
              rating: 4.5,
            ),
          ),
          const SizedBox(height: 16),
          const CarrierActionButtons(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
