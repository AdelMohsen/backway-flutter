import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenhub/core/services/location/location_service.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:greenhub/core/utils/widgets/misc/location_dialogs.dart';

/// Result from the map picker
class MapPickerResult {
  final double latitude;
  final double longitude;
  final String address;

  const MapPickerResult({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

/// Full-screen map picker that zooms to current location
class LocationMapPickerScreen extends StatefulWidget {
  const LocationMapPickerScreen({super.key});

  @override
  State<LocationMapPickerScreen> createState() =>
      _LocationMapPickerScreenState();
}

class _LocationMapPickerScreenState extends State<LocationMapPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedPosition;
  String? _selectedAddress;
  bool _isLoading = true;
  bool _isResolvingAddress = false;

  // Default position (Riyadh, Saudi Arabia)
  static const LatLng _defaultPosition = LatLng(24.7136, 46.6753);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final result = await LocationService().getCurrentLocation();

    if (result.success && result.latitude != null && result.longitude != null) {
      final position = LatLng(result.latitude!, result.longitude!);
      if (!mounted) return;
      setState(() {
        _selectedPosition = position;
        _selectedAddress = result.locationName;
        _isLoading = false;
      });
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
    } else {
      if (!mounted) return;
      
      if (result.errorType == LocationErrorType.serviceDisabled) {
        await LocationDialogs.showLocationDisabledDialog(context);
      } else if (result.errorType == LocationErrorType.permissionDeniedForever) {
        await LocationDialogs.showPermissionDeniedDialog(context, isPermanent: true);
      }

      setState(() {
        _selectedPosition = _defaultPosition;
        _isLoading = false;
      });
    }
  }

  Future<void> _resolveAddress(LatLng position) async {
    if (!mounted) return;
    setState(() {
      _isResolvingAddress = true;
    });

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (!mounted) return;

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final resolvedName = _buildLocationName(place);

        setState(() {
          _selectedAddress = resolvedName;
          _isResolvingAddress = false;
        });
      } else {
        setState(() {
          _isResolvingAddress = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isResolvingAddress = false;
      });
    }
  }

  /// Build a readable location name from placemark
  /// (same logic as LocationService._buildLocationName)
  String _buildLocationName(Placemark place) {
    final parts = <String>[];

    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      parts.add(place.subLocality!);
    }

    if (place.locality != null && place.locality!.isNotEmpty) {
      parts.add(place.locality!);
    } else if (place.subAdministrativeArea != null &&
        place.subAdministrativeArea!.isNotEmpty) {
      parts.add(place.subAdministrativeArea!);
    }

    if (place.country != null && place.country!.isNotEmpty) {
      parts.add(place.country!);
    }

    if (parts.isEmpty) {
      if (place.administrativeArea != null &&
          place.administrativeArea!.isNotEmpty) {
        parts.add(place.administrativeArea!);
      }
    }

    return parts.isNotEmpty
        ? parts.join(', ')
        : AppStrings.tapToDetectLocation.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedPosition ?? _defaultPosition,
              zoom: 16,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              if (_selectedPosition != null) {
                controller.animateCamera(
                  CameraUpdate.newLatLngZoom(_selectedPosition!, 16),
                );
              }
            },
            onCameraMove: (position) {
              _selectedPosition = position.target;
            },
            onCameraIdle: () {
              if (_selectedPosition != null && !_isLoading) {
                _resolveAddress(_selectedPosition!);
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Center pin
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(Icons.location_pin, size: 48, color: Colors.red),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.white.withValues(alpha: 0.7),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.primaryGreenHub,
                    ),
                    const SizedBox(height: 16),
                    MainText(
                      text: AppStrings.detectingLocation.tr,
                      style: AppTextStyles.ibmPlexSansSize14w400Grey,
                    ),
                  ],
                ),
              ),
            ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          // My location button
          Positioned(
            bottom: 160,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.my_location,
                  color: AppColors.primaryGreenHub,
                ),
                onPressed: _getCurrentLocation,
              ),
            ),
          ),

          // Bottom card with address and confirm button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Address text
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primaryGreenHub,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _isResolvingAddress
                            ? MainText(
                                text: AppStrings.detectingLocation.tr,
                                style: AppTextStyles.ibmPlexSansSize14w400Grey,
                              )
                            : MainText(
                                text:
                                    _selectedAddress ??
                                    AppStrings.tapToDetectLocation.tr,
                                style: AppTextStyles.ibmPlexSansSize14w400Grey
                                    .copyWith(
                                      color: const Color.fromRGBO(
                                        51,
                                        51,
                                        51,
                                        1,
                                      ),
                                    ),
                                maxLines: 2,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Confirm button
                  DefaultButton(
                    borderRadius: BorderRadius.circular(44),
                    height: 56,
                    textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                        .copyWith(color: AppColors.kWhite),
                    text: AppStrings.confirm.tr,
                    onPressed:
                        (_selectedPosition == null || _isResolvingAddress)
                        ? null
                        : () {
                            Navigator.pop(
                              context,
                              MapPickerResult(
                                latitude: _selectedPosition!.latitude,
                                longitude: _selectedPosition!.longitude,
                                address: _selectedAddress ?? '',
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
