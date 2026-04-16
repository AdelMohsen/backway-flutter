import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerUtils {
  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    String assetName, {
    Size size = const Size(48, 48),
  }) async {
    final String svgString = await rootBundle.loadString(assetName);
    final svg.PictureInfo pictureInfo = await svg.vg.loadPicture(
      svg.SvgStringLoader(svgString),
      null,
    );

    double width = size.width;
    double height = size.height;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final double scale = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );
    final double scaledWidth = pictureInfo.size.width * scale;
    final double scaledHeight = pictureInfo.size.height * scale;

    canvas.save();
    canvas.translate((width - scaledWidth) / 2, (height - scaledHeight) / 2);
    canvas.scale(scale, scale);
    canvas.drawPicture(pictureInfo.picture);
    canvas.restore();

    final ui.Picture picture = pictureRecorder.endRecording();
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  /// Paints a custom driver marker: circular arc border + car icon + star rating
  static Future<BitmapDescriptor> buildDriverMarkerBitmap(
    String carSvgAsset, {
    required bool available,
    required double rating,
  }) async {
    const double canvasW = 220;
    const double canvasH = 280;
    const double circleR = 80;
    const double centerX = canvasW / 2;
    const double centerY = 100;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // 1) Draw the arc border (green or grey)
    final arcPaint = Paint()
      ..color = available ? const Color(0xFF4CAF50) : Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    // Draw a ~270 degree arc (open at bottom)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: circleR),
      -3.92699,
      4.71239,
      false,
      arcPaint,
    );

    // 2) Draw white circle background inside
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(centerX, centerY), circleR - 8, bgPaint);

    // 3) Draw the car SVG inside the circle
    try {
      final String svgString = await rootBundle.loadString(carSvgAsset);
      final svg.PictureInfo pictureInfo = await svg.vg.loadPicture(
        svg.SvgStringLoader(svgString),
        null,
      );

      const double carSize = 100; // Increased size slightly for better visibility
      final double scale = min(
        carSize / pictureInfo.size.width,
        carSize / pictureInfo.size.height,
      );
      final double scaledWidth = pictureInfo.size.width * scale;
      final double scaledHeight = pictureInfo.size.height * scale;

      canvas.save();
      canvas.translate(centerX - scaledWidth / 2, centerY - scaledHeight / 2);
      canvas.scale(scale, scale);
      canvas.drawPicture(pictureInfo.picture);
      canvas.restore();
    } catch (_) {}

    // 4) Draw rating badge: cream pill background + star + text
    const double badgeH = 42;
    const double badgeW = 110;
    final double badgeY = centerY + circleR - badgeH / 2; // overlaps bottom of arc
    final double badgeX = centerX - badgeW / 2;

    // Cream rounded rect background
    final pillPaint = Paint()..color = const Color(0xFFFFF8E1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(badgeX, badgeY, badgeW, badgeH),
        const Radius.circular(20),
      ),
      pillPaint,
    );

    // Star icon
    const double starSize = 22;
    final starPaint = Paint()..color = const Color(0xFFFF9800);
    final Path starPath = _createStarPath(badgeX + 8, badgeY + 10, starSize);
    canvas.drawPath(starPath, starPaint);

    // Rating text
    final textPainter = TextPainter(
      text: TextSpan(
        text: rating.toString(),
        style: const TextStyle(
          color: Color(0xFFFF9800),
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(badgeX + 40, badgeY + 6));

    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(
      canvasW.toInt(),
      canvasH.toInt(),
    );
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  /// Creates a 5-point star path
  static Path _createStarPath(double x, double y, double size) {
    final path = Path();
    const int points = 5;
    final double halfSize = size / 2;
    final double innerRadius = halfSize * 0.4;

    for (int i = 0; i < points * 2; i++) {
      final double radius = i.isEven ? halfSize : innerRadius;
      final double angle = (i * 3.14159265 / points) - (3.14159265 / 2);
      final double px = x + halfSize + radius * cos(angle);
      final double py = y + halfSize + radius * sin(angle);
      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }
    path.close();
    return path;
  }
}
