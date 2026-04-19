import 'package:flutter/material.dart';

class StepThreeDetails extends StatelessWidget {
  const StepThreeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "Step 3: Summary Placeholder",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
