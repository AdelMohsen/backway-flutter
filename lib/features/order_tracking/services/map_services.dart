import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServices {
  static Future<void> animateToLocation(
    GoogleMapController? controller,
    LatLng location,
  ) async {
    if (controller == null) return;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15),
      ),
    );
  }

  static Future<void> fitBounds(
    GoogleMapController? controller,
    List<LatLng> points,
  ) async {
    if (controller == null || points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (var p in points) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100, // padding
      ),
    );
  }

  // static Set<Polyline> createPolyline(List<LatLng> points) {
  //   if (points.length < 2) return {};

  //   return {
  //     Polyline(
  //       polylineId: const PolylineId('route'),
  //       points: points,
  //       color: AppColors.primaryGreenHub,
  //       width: 4,
  //       patterns: [PatternItem.dash(20), PatternItem.gap(10)],
  //     ),
  //   };
  // }
}
