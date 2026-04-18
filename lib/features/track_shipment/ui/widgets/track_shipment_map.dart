import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/helpers/map_style_helper.dart';
import 'package:greenhub/core/utils/widgets/reusable_map_widget.dart';

class TrackShipmentMap extends StatefulWidget {
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final LatLng initialTarget;
  final Function(GoogleMapController) onMapCreated;

  const TrackShipmentMap({
    super.key,
    required this.markers,
    required this.polylines,
    required this.initialTarget,
    required this.onMapCreated,
  });

  @override
  State<TrackShipmentMap> createState() => _TrackShipmentMapState();
}

class _TrackShipmentMapState extends State<TrackShipmentMap> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return ReusableMapWidget(
      initialTarget: widget.initialTarget,
      initialZoom: 14.5,
      height: double.infinity,
      markers: widget.markers,
      polylines: widget.polylines,
      onMapCreated: (controller) {
        _controller = controller;
        _controller?.setMapStyle(MapStyleHelper.silverStyle);
        widget.onMapCreated(controller);
      },
    );
  }
}
