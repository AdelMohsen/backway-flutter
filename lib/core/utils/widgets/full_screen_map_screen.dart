import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/helpers/map_style_helper.dart';
import 'package:greenhub/core/utils/widgets/reusable_map_widget.dart';

class FullScreenMapScreen extends StatefulWidget {
  final BitmapDescriptor? driverMarker;
  final BitmapDescriptor? destinationMarker;
  final LatLng driverPosition;
  final LatLng destinationPosition;

  const FullScreenMapScreen({
    super.key,
    this.driverMarker,
    this.destinationMarker,
    required this.driverPosition,
    required this.destinationPosition,
  });

  @override
  State<FullScreenMapScreen> createState() => _FullScreenMapScreenState();
}

class _FullScreenMapScreenState extends State<FullScreenMapScreen> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Shipment Map",
          style: Styles.urbanistSize16w600White.copyWith(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ReusableMapWidget(
        onMapCreated: (controller) {
          _mapController = controller;
          _mapController?.setMapStyle(MapStyleHelper.silverStyle);
        },
        initialTarget: const LatLng(51.1760, -115.5710),
        initialZoom: 14.5,
        height: double.infinity,
        markers: {
          if (widget.driverMarker != null)
            Marker(
              markerId: const MarkerId("driver"),
              position: widget.driverPosition,
              icon: widget.driverMarker!,
              anchor: const Offset(0.5, 0.8),
            ),
          if (widget.destinationMarker != null)
            Marker(
              markerId: const MarkerId("destination"),
              position: widget.destinationPosition,
              icon: widget.destinationMarker!,
              anchor: const Offset(0.5, 0.5),
            ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            color: const Color(0xFFFF6B47),
            width: 4,
            points: [widget.driverPosition, widget.destinationPosition],
          ),
        },
        circles: {
          Circle(
            circleId: const CircleId("dest_circle"),
            center: widget.destinationPosition,
            radius: 200,
            fillColor: const Color(0xFFFF6B47).withOpacity(0.15),
            strokeWidth: 0,
          ),
        },
        floatingWidgetRight: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 16),
            child: GestureDetector(
              onTap: () {
                _mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: widget.destinationPosition,
                      zoom: 17.0,
                    ),
                  ),
                );
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
            ),
          ),
        ),
      ),
    );
  }
}
