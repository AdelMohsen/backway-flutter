import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

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

      const double carSize =
          100; // Increased size slightly for better visibility
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
    final double badgeY =
        centerY + circleR - badgeH / 2; // overlaps bottom of arc
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
    final starPaint = Paint()..color = ColorsApp.KorangePrimary;
    final Path starPath = _createStarPath(badgeX + 8, badgeY + 10, starSize);
    canvas.drawPath(starPath, starPaint);

    // Rating text
    final textPainter = TextPainter(
      text: TextSpan(
        text: rating.toString(),
        style: const TextStyle(
          color: ColorsApp.KorangePrimary,
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

  /// Paints a circular orange navigation marker with a white arrow SVG
  static Future<BitmapDescriptor> buildNavigationMarkerBitmap(
    String arrowSvgAsset,
  ) async {
    const double size = 180;
    const double centerX = size / 2;
    const double centerY = size / 2;
    const double circleR = 40;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // 1) Orange circle background with shadow
    final paint = Paint()
      ..color = const Color(0xFFFF6F47)
      ..style = PaintingStyle.fill;

    // Draw shadow
    canvas.drawCircle(
      const Offset(centerX, centerY),
      circleR + 3,
      Paint()
        ..color = const Color(0xFFFF6F47).withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    canvas.drawCircle(Offset(centerX, centerY), circleR, paint);

    // 2) Navigation arrow SVG
    try {
      final String svgString = await rootBundle.loadString(arrowSvgAsset);
      final svg.PictureInfo pictureInfo = await svg.vg.loadPicture(
        svg.SvgStringLoader(svgString),
        null,
      );

      const double iconSize = 250;
      final double scale = min(
        iconSize / pictureInfo.size.width,
        iconSize / pictureInfo.size.height,
      );
      final double scaledWidth = pictureInfo.size.width * scale;
      final double scaledHeight = pictureInfo.size.height * scale;

      canvas.save();
      canvas.translate(centerX - scaledWidth / 2, centerY - scaledHeight / 2);
      canvas.scale(scale, scale);
      canvas.drawPicture(pictureInfo.picture);
      canvas.restore();
    } catch (_) {}

    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(size.toInt(), size.toInt());
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  /// Paints a destination marker: orange dot + halo + arrival label (on the left)
  static Future<BitmapDescriptor> buildArrivalMarkerBitmap(
    String labelText,
  ) async {
    const double canvasW = 500;
    const double canvasH = 200;
    const double dotX = 400; // Position dot on the right
    const double dotY = 100;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // 1) Arrival Label (White box with shadow)
    final textPainter = TextPainter(
      text: TextSpan(
        text: labelText,
        style: const TextStyle(
          color: Color.fromRGBO(31, 31, 31, 1),
          fontSize: 38, // Larger font
          fontWeight: FontWeight.w700,
          fontFamily: 'Urbanist',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final double labelW = textPainter.width + 60;
    final double labelH = textPainter.height + 40;
    final double labelX = dotX - labelW - 35; // 35px gap to the left
    final double labelY = dotY - labelH / 2;

    // Draw label shadow
    final RRect labelRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(labelX, labelY, labelW, labelH),
      const Radius.circular(20),
    );
    canvas.drawRRect(
      labelRect.shift(const Offset(0, 6)),
      Paint()
        ..color = Colors.black.withOpacity(0.06)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
    );

    // Draw label background
    canvas.drawRRect(labelRect, Paint()..color = Colors.white);

    // Draw label text
    textPainter.paint(canvas, Offset(labelX + 30, labelY + 20));

    // 2) Orange dot with halo
    final dotColor = ColorsApp.KorangePrimary;

    // Halo
    canvas.drawCircle(
      const Offset(dotX, dotY),
      35,
      Paint()..color = dotColor.withOpacity(0.2),
    );

    // Inner Dot
    canvas.drawCircle(const Offset(dotX, dotY), 16, Paint()..color = dotColor);

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
}
