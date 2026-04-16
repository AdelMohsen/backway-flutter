import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReusableMapWidget extends StatefulWidget {
  final LatLng initialTarget;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final Set<Circle>? circles;
  final double initialZoom;
  final Widget? floatingWidgetLeft;
  final Widget? floatingWidgetRight;
  final void Function(GoogleMapController)? onMapCreated;
  final double height;

  const ReusableMapWidget({
    Key? key,
    required this.initialTarget,
    this.markers,
    this.polylines,
    this.circles,
    this.initialZoom = 14.0,
    this.floatingWidgetLeft,
    this.floatingWidgetRight,
    this.onMapCreated,
    this.height = 200,
  }) : super(key: key);

  @override
  State<ReusableMapWidget> createState() => _ReusableMapWidgetState();
}

class _ReusableMapWidgetState extends State<ReusableMapWidget> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.initialTarget,
                zoom: widget.initialZoom,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                widget.onMapCreated?.call(controller);
              },
              markers: widget.markers ?? const <Marker>{},
              polylines: widget.polylines ?? const <Polyline>{},
              circles: widget.circles ?? const <Circle>{},
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
            ),
            if (widget.floatingWidgetLeft != null)
              Positioned(
                bottom: 16,
                left: 16,
                child: widget.floatingWidgetLeft!,
              ),
            if (widget.floatingWidgetRight != null)
              Positioned(
                bottom: 16,
                right: 16,
                child: widget.floatingWidgetRight!,
              ),
          ],
        ),
      ),
    );
  }
}
