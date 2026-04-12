import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final Color color;

  const DottedLine({super.key, this.color = const Color(0xFFE0E0E0)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      width: double.infinity,
      child: CustomPaint(painter: _DottedLinePainter(color)),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  _DottedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const dashWidth = 2.0;
    const dashSpace = 3.0;
    const extraLength = 15.0; // 👈 يطوّل الخط من الطرفين

    double startX = -extraLength / 2;

    while (startX < size.width + extraLength / 2) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
