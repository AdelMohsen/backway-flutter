import 'package:flutter/material.dart';

class StepTwoDetails extends StatelessWidget {
  const StepTwoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "Step 2: Delivery Info Placeholder",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
