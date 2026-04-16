import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/helpers/map_marker_utils.dart';
import 'package:greenhub/core/utils/helpers/map_style_helper.dart';
import 'package:greenhub/core/utils/widgets/reusable_map_widget.dart';
import 'package:greenhub/core/utils/widgets/full_screen_map_screen.dart';

class DriverDetailsCard extends StatefulWidget {
  const DriverDetailsCard({Key? key}) : super(key: key);

  @override
  State<DriverDetailsCard> createState() => _DriverDetailsCardState();
}

class _DriverDetailsCardState extends State<DriverDetailsCard> {
  BitmapDescriptor? _driverMarker;
  BitmapDescriptor? _destinationMarker;
  GoogleMapController? _mapController;

  final LatLng _driverPosition = const LatLng(51.1730, -115.5710);
  final LatLng _destinationPosition = const LatLng(51.1784, -115.5708);

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final driverIcon = await MapMarkerUtils.buildDriverMarkerBitmap(
      SvgImages.car4,
      available: true,
      rating: 4.5,
    );

    final destIcon = await MapMarkerUtils.bitmapDescriptorFromSvgAsset(
      SvgImages.locationPin,
      size: const Size(220, 220),
    );

    setState(() {
      _driverMarker = driverIcon;
      _destinationMarker = destIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(249, 250, 251, 1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Driver details",
                style: Styles.urbanistSize14w600White.copyWith(
                  color: const Color.fromRGBO(64, 64, 64, 1),
                ),
              ),
              SvgPicture.asset(
                SvgImages.arrowDown,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(130, 134, 171, 1),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 16),

          // Profile Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image with Verification Badge
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    child: ClipOval(
                      child: Image.asset(ImagesApp.driver1, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: -9,
                    child: SvgPicture.asset(
                      SvgImages.verify,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name and Badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Jaskson Oliver",
                          style: Styles.urbanistSize16w600White.copyWith(
                            color: ColorsApp.kPrimary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Rating Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8ED),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                ImagesApp.star,
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "4.5",
                                style: Styles.urbanistSize12w600Orange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Car Type
                  ],
                ),
              ),
              // Availability Status
              Container(
                padding: const EdgeInsetsDirectional.only(
                  start: 12,
                  end: 12,
                  top: 9,
                  bottom: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(232, 245, 233, 1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  "Available",
                  style: Styles.urbanistSize12w600Orange.copyWith(
                    color: Color.fromRGBO(46, 125, 50, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Distance", "1.8 km", SvgImages.distance),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem(
                  "Shipments",
                  "121",
                  SvgImages.truckUnActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Map
          SizedBox(
            height: 220,
            child: ReusableMapWidget(
              onMapCreated: (controller) {
                _mapController = controller;
                _mapController?.setMapStyle(MapStyleHelper.silverStyle);
              },
              initialTarget: const LatLng(51.1760, -115.5710),
              initialZoom: 14.5,
              markers: {
                if (_driverMarker != null)
                  Marker(
                    markerId: const MarkerId("driver"),
                    position: _driverPosition,
                    icon: _driverMarker!,
                    anchor: const Offset(0.5, 0.8),
                  ),
                if (_destinationMarker != null)
                  Marker(
                    markerId: const MarkerId("destination"),
                    position: _destinationPosition,
                    icon: _destinationMarker!,
                    anchor: const Offset(0.5, 0.5),
                  ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  color: const Color(0xFFFF6B47),
                  width: 4,
                  points: [_driverPosition, _destinationPosition],
                ),
              },
              circles: {
                Circle(
                  circleId: const CircleId("dest_circle"),
                  center: _destinationPosition,
                  radius: 200,
                  fillColor: const Color(0xFFFF6B47).withOpacity(0.15),
                  strokeWidth: 0,
                ),
              },
              floatingWidgetLeft: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FullScreenMapScreen(
                        driverMarker: _driverMarker,
                        destinationMarker: _destinationMarker,
                        driverPosition: _driverPosition,
                        destinationPosition: _destinationPosition,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "View larger map",
                    style: Styles.urbanistSize10w500Orange.copyWith(
                      color: ColorsApp.kPrimary,
                    ),
                  ),
                ),
              ),
              floatingWidgetRight: GestureDetector(
                onTap: () {
                  _mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: _destinationPosition, zoom: 17.0),
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
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String icon) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF8E92AE),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: Styles.urbanistSize14w500Orange.copyWith(
                  color: const Color.fromRGBO(163, 163, 163, 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Styles.urbanistSize14w500Orange.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
