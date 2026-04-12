import 'package:flutter/material.dart';

class TrackingMapBackButton extends StatelessWidget {
  const TrackingMapBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 30,
      start: 20,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(255, 255, 255, 0.8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}
