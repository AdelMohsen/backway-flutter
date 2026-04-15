import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class HomeMapWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final VoidCallback? onLocateMe;

  const HomeMapWidget({
    super.key,
    this.latitude,
    this.longitude,
    this.onLocateMe,
  });

  @override
  State<HomeMapWidget> createState() => _HomeMapWidgetState();
}

class _HomeMapWidgetState extends State<HomeMapWidget> {
  GoogleMapController? _mapController;
  BitmapDescriptor? _locationPinIcon;

  // Default fallback (Banff National Park)
  static const LatLng _defaultPosition = LatLng(51.1784, -115.5708);

  @override
  void initState() {
    super.initState();
    _loadAllIcons();
  }

  // Dummy driver data (temporary until real data)
  static const List<_DummyDriver> _dummyDrivers = [
    _DummyDriver(
      latOffset: 0.008,
      lngOffset: -0.012,
      carIndex: 0,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: 0.012,
      lngOffset: -0.005,
      carIndex: 1,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: 0.005,
      lngOffset: 0.010,
      carIndex: 2,
      rating: 4.5,
      available: false,
    ),
    _DummyDriver(
      latOffset: -0.006,
      lngOffset: -0.008,
      carIndex: 0,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: -0.004,
      lngOffset: 0.005,
      carIndex: 3,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: -0.010,
      lngOffset: -0.014,
      carIndex: 1,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: -0.012,
      lngOffset: 0.008,
      carIndex: 2,
      rating: 4.5,
      available: false,
    ),
    _DummyDriver(
      latOffset: 0.015,
      lngOffset: 0.002,
      carIndex: 3,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: -0.002,
      lngOffset: -0.018,
      carIndex: 0,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: -0.016,
      lngOffset: 0.000,
      carIndex: 1,
      rating: 4.5,
      available: true,
    ),
    _DummyDriver(
      latOffset: 0.003,
      lngOffset: 0.016,
      carIndex: 3,
      rating: 4.5,
      available: false,
    ),
  ];

  final List<String> _carAssets = [
    SvgImages.car1,
    SvgImages.car2,
    SvgImages.car3,
    SvgImages.car4,
  ];

  final Map<String, BitmapDescriptor> _driverIcons = {};

  Future<void> _loadAllIcons() async {
    // Load location pin
    try {
      final icon = await _bitmapDescriptorFromSvgAsset(
        SvgImages.locationPin,
        size: const Size(220, 220),
      );
      setState(() => _locationPinIcon = icon);
    } catch (e) {
      debugPrint('Error loading location pin SVG: $e');
    }

    // Load driver markers
    for (int i = 0; i < _dummyDrivers.length; i++) {
      final driver = _dummyDrivers[i];
      final key = 'driver_$i';
      try {
        final icon = await _buildDriverMarkerBitmap(
          _carAssets[driver.carIndex],
          available: driver.available,
          rating: driver.rating,
        );
        _driverIcons[key] = icon;
      } catch (e) {
        debugPrint('Error loading driver marker $i: $e');
      }
    }
    if (mounted) setState(() {});
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
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

    final double scaleX = width / pictureInfo.size.width;
    final double scaleY = height / pictureInfo.size.height;
    canvas.scale(scaleX, scaleY);
    canvas.drawPicture(pictureInfo.picture);

    final ui.Picture picture = pictureRecorder.endRecording();
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  /// Paints a custom driver marker: circular arc border + car icon + star rating
  Future<BitmapDescriptor> _buildDriverMarkerBitmap(
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

      const double carSize = 70;
      final double scaleX = carSize / pictureInfo.size.width;
      final double scaleY = carSize / pictureInfo.size.height;

      canvas.save();
      canvas.translate(centerX - carSize / 2, centerY - carSize / 2);
      canvas.scale(scaleX, scaleY);
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
  Path _createStarPath(double x, double y, double size) {
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

  Set<Marker> _buildMarkers() {
    final Set<Marker> markers = {};

    // Current location marker
    if (widget.latitude != null && widget.longitude != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(widget.latitude!, widget.longitude!),
          icon:
              _locationPinIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          anchor: const Offset(0.5, 0.5),
        ),
      );

      // Dummy driver markers
      for (int i = 0; i < _dummyDrivers.length; i++) {
        final driver = _dummyDrivers[i];
        final key = 'driver_$i';
        markers.add(
          Marker(
            markerId: MarkerId(key),
            position: LatLng(
              widget.latitude! + driver.latOffset,
              widget.longitude! + driver.lngOffset,
            ),
            icon:
                _driverIcons[key] ??
                BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
            anchor: const Offset(0.5, 0.8),
          ),
        );
      }
    }

    return markers;
  }

  LatLng get _targetPosition =>
      (widget.latitude != null && widget.longitude != null)
      ? LatLng(widget.latitude!, widget.longitude!)
      : _defaultPosition;

  @override
  void didUpdateWidget(covariant HomeMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.latitude != oldWidget.latitude ||
        widget.longitude != oldWidget.longitude) {
      if (widget.latitude != null && widget.longitude != null) {
        // Only animate automatically if it's the first time location is received
        // to avoid overriding manual zooms from the "Locate Me" button.
        if (oldWidget.latitude == null) {
          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(widget.latitude!, widget.longitude!),
                zoom: 15.0,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _targetPosition,
                  zoom: 14.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                markers: _buildMarkers(),
                circles: _buildCircles(),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: _buildFilterDriversCard(),
              ),
              Positioned(bottom: 30, left: 20, child: _buildLegendCard()),
              Positioned(bottom: 30, right: 20, child: _buildLocateMeButton()),
            ],
          ),
        ),
      ),
    );
  }

  Set<Circle> _buildCircles() {
    if (widget.latitude == null || widget.longitude == null) return {};
    return {
      Circle(
        circleId: const CircleId('current_location_radius'),
        center: LatLng(widget.latitude!, widget.longitude!),
        radius: 200, // ~200 meters radius
        fillColor: const Color(0xFFFF6B47).withOpacity(0.10),
        strokeColor: const Color(0xFFFF6B47).withOpacity(0.05),
        strokeWidth: 1,
      ),
    };
  }

  Widget _buildFilterDriversCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Dropdown Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                // Orange dots icon
                SvgPicture.asset(SvgImages.filter),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Filter Drivers",
                    style: Styles.urbanistSize14w400White.copyWith(
                      color: const Color.fromRGBO(130, 134, 171, 1),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  width: 15,
                  height: 15,
                  SvgImages.drop,
                  color: const Color.fromRGBO(130, 134, 171, 1),
                ),
                // Circle arrow button
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Scrollable Filter Chips with SVG icons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip("All Cars", isSelected: true),
                const SizedBox(width: 10),
                _buildFilterChip("Car", svgAsset: SvgImages.car1),
                const SizedBox(width: 10),
                _buildFilterChip("Cargo Van", svgAsset: SvgImages.car4),
                const SizedBox(width: 10),
                _buildFilterChip("Container", svgAsset: SvgImages.car2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label, {
    bool isSelected = false,
    String? svgAsset,
  }) {
    // Colors from design image
    final Color selectedBg = Color.fromRGBO(243, 245, 250, 1);
    final Color selectedBorder = ColorsApp.kPrimary;
    final Color selectedText = ColorsApp.kPrimary;

    final Color unselectedBg = Colors.white;
    final Color unselectedBorder = const Color(0xFFE9EEF4);
    final Color unselectedText = const Color(0xFF6D7B8A);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? selectedBg : unselectedBg,
        border: Border.all(
          color: isSelected ? selectedBorder : unselectedBorder,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (svgAsset != null) ...[
            SvgPicture.asset(svgAsset, width: 8, height: 11),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: Styles.urbanistSize16w500White.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? selectedText : unselectedText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLegendItem(Colors.green, "Available"),
          const SizedBox(height: 12),
          _buildLegendItem(Colors.grey, "Not available"),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Styles.urbanistSize14w400White.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildLocateMeButton() {
    return GestureDetector(
      onTap: () {
        widget.onLocateMe?.call();
        if (widget.latitude != null && widget.longitude != null) {
          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(widget.latitude!, widget.longitude!),
                zoom: 17.0,
              ),
            ),
          );
        }
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: ColorsApp.KorangePrimary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorsApp.KorangePrimary.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: SvgPicture.asset(SvgImages.gps)),
      ),
    );
  }
}

class _DummyDriver {
  final double latOffset;
  final double lngOffset;
  final int carIndex;
  final double rating;
  final bool available;

  const _DummyDriver({
    required this.latOffset,
    required this.lngOffset,
    required this.carIndex,
    required this.rating,
    required this.available,
  });
}
