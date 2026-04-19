import 'package:flutter/material.dart';
import '../widgets/step_one/driver_details_card.dart';
import '../widgets/step_one/package_details_card.dart';

class StepOneDetails extends StatelessWidget {
  const StepOneDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          DriverDetailsCard(),
          SizedBox(height: 16),
          PackageDetailsCard(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
