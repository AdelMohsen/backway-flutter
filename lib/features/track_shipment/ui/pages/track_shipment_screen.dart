import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/utils/helpers/map_marker_utils.dart';
import '../widgets/track_shipment_header.dart';
import '../widgets/track_shipment_info_card.dart';
import '../widgets/track_shipment_map.dart';

class TrackShipmentScreen extends StatefulWidget {
  const TrackShipmentScreen({super.key});

  @override
  State<TrackShipmentScreen> createState() => _TrackShipmentScreenState();
}

class _TrackShipmentScreenState extends State<TrackShipmentScreen> {
  BitmapDescriptor? _driverMarker;
  BitmapDescriptor? _destinationMarker;

  final LatLng _driverPosition = const LatLng(51.1730, -115.5710);
  final LatLng _destinationPosition = const LatLng(51.1784, -115.5708);

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final driverIcon = await MapMarkerUtils.buildNavigationMarkerBitmap(
      SvgImages.locationDriver,
    );

    final destIcon = await MapMarkerUtils.buildArrivalMarkerBitmap(
      "Arrival ( 2 mins )",
    );

    setState(() {
      _driverMarker = driverIcon;
      _destinationMarker = destIcon;
    });
  }

  List<LatLng> get _polylinePoints {
    if (_driverMarker == null || _destinationMarker == null) return [];

    // Calculate a slightly shortened line so it looks "between" the markers
    // and doesn't overlap the transparent halos.
    const double startOffsetRatio = 0.15; // Offset for the large navigation marker
    const double endOffsetRatio = 0.08;   // Offset for the destination dot

    double lat1 = _driverPosition.latitude;
    double lng1 = _driverPosition.longitude;
    double lat2 = _destinationPosition.latitude;
    double lng2 = _destinationPosition.longitude;

    double dLat = lat2 - lat1;
    double dLng = lng2 - lng1;

    LatLng startPoint = LatLng(
      lat1 + dLat * startOffsetRatio,
      lng1 + dLng * startOffsetRatio,
    );

    LatLng endPoint = LatLng(
      lat1 + dLat * (1 - endOffsetRatio),
      lng1 + dLng * (1 - endOffsetRatio),
    );

    return [startPoint, endPoint];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Map Part (Top)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                TrackShipmentMap(
                  initialTarget: _driverPosition,
                  onMapCreated: (controller) {},
                  markers: {
                    if (_driverMarker != null)
                      Marker(
                        markerId: const MarkerId("driver"),
                        position: _driverPosition,
                        icon: _driverMarker!,
                        anchor: const Offset(0.5, 0.5),
                        zIndex: 2,
                      ),
                    if (_destinationMarker != null)
                      Marker(
                        markerId: const MarkerId("destination"),
                        position: _destinationPosition,
                        icon: _destinationMarker!,
                        anchor: const Offset(0.8, 0.5),
                        zIndex: 2,
                      ),
                  },
                  polylines: {
                    if (_polylinePoints.isNotEmpty)
                      Polyline(
                        polylineId: const PolylineId("route"),
                        color: const Color(0xFFFF6F47),
                        width: 6,
                        jointType: JointType.round,
                        startCap: Cap.roundCap,
                        endCap: Cap.roundCap,
                        points: _polylinePoints,
                        zIndex: 1,
                      ),
                  },
                ),
                // Header
                const TrackShipmentHeader(),
              ],
            ),
          ),

          // Details Part (Bottom)
          const Expanded(
            child: TrackShipmentInfoCard(
              orderId: "28765543",
              vehicleType: "Cargo Van",
              fromAddress: "Toronto, ON · M5V 2H1",
              toAddress: "Vancouver, BC · V6B 3K9",
            ),
          ),
        ],
      ),
    );
  }
}
