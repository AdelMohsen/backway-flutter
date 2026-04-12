import 'package:flutter/material.dart';

import 'package:greenhub/features/choice_type_order/ui/pages/chice_type_order.dart';

class ChoiceTypeOrderBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ChoiceTypeOrderContent(),
    );
  }
}
