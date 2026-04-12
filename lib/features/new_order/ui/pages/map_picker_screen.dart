import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/location_dialogs.dart';

class MapPickerScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;

  const MapPickerScreen({Key? key, this.initialLat, this.initialLng})
    : super(key: key);

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final TextEditingController _searchController = TextEditingController();

  LatLng? _selectedLocation;
  String _selectedAddress = '';
  Set<Marker> _markers = {};
  bool _isLoading = false;

  // Default to Riyadh, Saudi Arabia
  static const LatLng _defaultLocation = LatLng(24.7136, 46.6753);

  @override
  void initState() {
    super.initState();
    if (widget.initialLat != null && widget.initialLng != null) {
      _selectedLocation = LatLng(widget.initialLat!, widget.initialLng!);
      _updateMarker(_selectedLocation!);
      _getAddressFromLatLng(_selectedLocation!);
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          await LocationDialogs.showLocationDisabledDialog(context);
        }
        _setDefaultLocation();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setDefaultLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _setDefaultLocation();
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final location = LatLng(position.latitude, position.longitude);
      _selectedLocation = location;
      _updateMarker(location);
      _getAddressFromLatLng(location);
      _moveCamera(location);
    } catch (e) {
      _setDefaultLocation();
    }
    setState(() => _isLoading = false);
  }

  void _setDefaultLocation() {
    _selectedLocation = _defaultLocation;
    _updateMarker(_defaultLocation);
    _getAddressFromLatLng(_defaultLocation);
    setState(() => _isLoading = false);
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final parts = <String>[
          if (place.street != null && place.street!.isNotEmpty) place.street!,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality!,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality!,
          if (place.administrativeArea != null &&
              place.administrativeArea!.isNotEmpty)
            place.administrativeArea!,
        ];
        setState(() {
          _selectedAddress = parts.isNotEmpty
              ? parts.join(', ')
              : '${latLng.latitude}, ${latLng.longitude}';
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = '${latLng.latitude}, ${latLng.longitude}';
      });
    }
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );
        _selectedLocation = location;
        _updateMarker(location);
        _getAddressFromLatLng(location);
        _moveCamera(location);
      }
    } catch (e) {
      debugPrint('Search location error: $e');
    }
    setState(() => _isLoading = false);
  }

  void _updateMarker(LatLng location) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('selected'),
          position: location,
          infoWindow: InfoWindow(title: AppStrings.selectDestination.tr),
        ),
      };
    });
  }

  Future<void> _moveCamera(LatLng location) async {
    final controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15),
      ),
    );
  }

  void _onMapTapped(LatLng latLng) {
    _selectedLocation = latLng;
    _updateMarker(latLng);
    _getAddressFromLatLng(latLng);
  }

  void _confirmLocation() {
    if (_selectedLocation != null) {
      Navigator.pop(context, {
        'lat': _selectedLocation!.latitude,
        'lng': _selectedLocation!.longitude,
        'address': _selectedAddress,
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation ?? _defaultLocation,
              zoom: 14,
            ),
            markers: _markers,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
            onTap: _onMapTapped,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Search Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
          ),

          // Loading indicator
          if (_isLoading) const Center(child: CircularProgressIndicator()),

          // Selected address & Confirm button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedAddress.isNotEmpty) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.primaryGreenHub,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _selectedAddress,
                            style: AppTextStyles.ibmPlexSansSize12w500Title
                                .copyWith(color: Colors.black87),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  DefaultButton(
                    onPressed: _confirmLocation,
                    borderRadius: BorderRadius.circular(44),
                    width: double.infinity,
                    height: 52,
                    child: Center(
                      child: Text(
                        AppStrings.confirm.tr,
                        style: AppTextStyles.ibmPlexSansSize18w600White,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // My Location FAB
          Positioned(
            bottom: 140,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.my_location,
                color: AppColors.primaryGreenHub,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
