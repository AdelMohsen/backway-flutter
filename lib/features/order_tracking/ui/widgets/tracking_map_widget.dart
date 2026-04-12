import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';
import 'package:greenhub/features/order_tracking/services/map_services.dart';
import 'package:greenhub/features/order_tracking/ui/widgets/order_success_rate_widget.dart';
import 'package:greenhub/features/order_tracking/ui/widgets/tracking_location_button.dart';
import 'package:greenhub/features/order_tracking/ui/widgets/tracking_map_back_button.dart';

class TrackingMapWidget extends StatefulWidget {
  final TrackingModel orderData;

  const TrackingMapWidget({Key? key, required this.orderData})
    : super(key: key);

  @override
  State<TrackingMapWidget> createState() => _TrackingMapWidgetState();
}

class _TrackingMapWidgetState extends State<TrackingMapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  BitmapDescriptor? _customIcon;
  BitmapDescriptor? _locationIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    _createMarkers();
    //  _createPolyline();
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
    String assetName, {
    Size size = const Size(48, 48),
  }) async {
    final String svgString = await rootBundle.loadString(assetName);

    // Create a PictureInfo from the SVG string
    final svg.PictureInfo pictureInfo = await svg.vg.loadPicture(
      svg.SvgStringLoader(svgString),
      null,
    );

    // Calculate scaling factor to fit the SVG into the desired size
    double width = size.width;
    double height = size.height;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Scale the canvas so the SVG fills the requested size
    final double scaleX = width / pictureInfo.size.width;
    final double scaleY = height / pictureInfo.size.height;

    // Apply scaling
    canvas.scale(scaleX, scaleY);

    // Draw the picture onto the scaled canvas
    canvas.drawPicture(pictureInfo.picture);

    // End recording to get the picture
    final ui.Picture picture = pictureRecorder.endRecording();

    // Convert to image with desired dimensions
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());

    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  Future<void> _loadCustomMarkers() async {
    // Driver Icon (SVG)
    BitmapDescriptor? icon;
    try {
      icon = await _bitmapDescriptorFromSvgAsset(
        AppSvg.marker1,
        size: const Size(60, 60),
      );
    } catch (e) {
      debugPrint("Error loading Driver SVG marker: $e");
      // Fallback to PNG if SVG fails
      icon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(50, 50)),
        AppImages.mark2,
        height: 50,
        width: 50,
      );
    }

    // Location Icon (SVG)
    BitmapDescriptor? locationIcon;
    try {
      locationIcon = await _bitmapDescriptorFromSvgAsset(
        AppSvg.location2,
        size: const Size(100, 100),
      );
    } catch (e) {
      debugPrint("Error loading Location SVG marker: $e");
      // Fallback to PNG if SVG fails
      locationIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(120, 120)),
        AppImages.mark1,
        height: 120,
        width: 120,
      );
    }

    setState(() {
      _customIcon = icon;
      _locationIcon = locationIcon;
      _createMarkers();
    });
  }

  void _createMarkers() {
    final pickupLat = widget.orderData.order.pickup.location?.lat ?? 0.0;
    final pickupLng = widget.orderData.order.pickup.location?.lng ?? 0.0;
    final deliveryLat = widget.orderData.order.delivery.location?.lat ?? 0.0;
    final deliveryLng = widget.orderData.order.delivery.location?.lng ?? 0.0;

    final driverLocation = widget.orderData.driverLocation;

    _markers = {
      // Pickup marker (yellow)
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(pickupLat, pickupLng),
        icon:
            _locationIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(
          title: 'نقطة الاستلام',
          snippet: widget.orderData.order.pickup.address ?? '',
        ),
      ),
      // Delivery marker (green)
      Marker(
        markerId: const MarkerId('delivery'),
        position: LatLng(deliveryLat, deliveryLng),
        icon:
            _locationIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'نقطة التسليم',
          snippet: widget.orderData.order.delivery.address ?? '',
        ),
      ),
      // Driver current location marker (custom or cyan)
      if (driverLocation != null)
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(driverLocation.lat, driverLocation.lng),
          icon:
              _customIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: const InfoWindow(title: 'موقع السائق الحالي'),
        ),
    };
  }

  // void _createPolyline() {
  //   // Create a simple polyline connecting the points
  //   List<LatLng> polylineCoordinates = [
  //     widget.orderData.pickupLocation,
  //     if (widget.orderData.currentDriverLocation != null)
  //       widget.orderData.currentDriverLocation!,
  //     widget.orderData.deliveryLocation,
  //   ];

  //   _polylines = MapServices.createPolyline(polylineCoordinates);
  // }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _fitMarkersInView();
  }

  void _fitMarkersInView() {
    final pickupLat = widget.orderData.order.pickup.location?.lat ?? 0.0;
    final pickupLng = widget.orderData.order.pickup.location?.lng ?? 0.0;
    final deliveryLat = widget.orderData.order.delivery.location?.lat ?? 0.0;
    final deliveryLng = widget.orderData.order.delivery.location?.lng ?? 0.0;
    final driverLocation = widget.orderData.driverLocation;

    List<LatLng> positions = [
      LatLng(pickupLat, pickupLng),
      LatLng(deliveryLat, deliveryLng),
      if (driverLocation != null)
        LatLng(driverLocation.lat, driverLocation.lng),
    ];

    MapServices.fitBounds(_mapController, positions);
  }

  @override
  Widget build(BuildContext context) {
    final pickupLat = widget.orderData.order.pickup.location?.lat ?? 0.0;
    final pickupLng = widget.orderData.order.pickup.location?.lng ?? 0.0;
    final driverLocation = widget.orderData.driverLocation;

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: driverLocation != null
                ? LatLng(driverLocation.lat, driverLocation.lng)
                : LatLng(pickupLat, pickupLng),
            zoom: 13,
          ),
          markers: _markers,
          polylines: _polylines,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          style: _mapStyle,
        ),
        // Back Button
        const TrackingMapBackButton(),
        // Current Location Button
        if (driverLocation != null)
          TrackingLocationButton(
            onTap: () {
              MapServices.animateToLocation(
                _mapController,
                LatLng(driverLocation.lat, driverLocation.lng),
              );
            },
          ),
      ],
    );
  }

  // Silver map style matching the user's request
  static const String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#f5f5f5"
        }
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#f5f5f5"
        }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#bdbdbd"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#eeeeee"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e5e5e5"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#ffffff"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#dadada"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e5e5e5"
        }
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#eeeeee"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#c9c9c9"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    }
  ]
  ''';
}
