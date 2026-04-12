import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../utils/utility.dart';

/// Location service result
class LocationResult {
  final bool success;
  final String? locationName;
  final String? city;
  final String? country;
  final double? latitude;
  final double? longitude;
  final LocationErrorType? errorType;
  final String? errorMessage;

  const LocationResult({
    required this.success,
    this.locationName,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.errorType,
    this.errorMessage,
  });

  factory LocationResult.success({
    required String locationName,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
  }) {
    return LocationResult(
      success: true,
      locationName: locationName,
      city: city,
      country: country,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory LocationResult.error({
    required LocationErrorType errorType,
    String? errorMessage,
  }) {
    return LocationResult(
      success: false,
      errorType: errorType,
      errorMessage: errorMessage,
    );
  }
}

/// Location error types
enum LocationErrorType {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  timeout,
  geocodingFailed,
  unknown,
}

/// Location service for handling geolocation
class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check current permission status
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Request location permission
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  /// Open location settings
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Open app settings (for permission denied forever)
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  /// Get current position with permission handling
  Future<LocationResult> getCurrentLocation({
    bool requestPermissionIfNeeded = true,
  }) async {
    try {
      cprint('📍 LocationService: Checking location service...');

      // Check if location services are enabled
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        cprint('❌ LocationService: Location services disabled');
        return LocationResult.error(
          errorType: LocationErrorType.serviceDisabled,
          errorMessage: 'Location services are disabled',
        );
      }

      // Check permission
      LocationPermission permission = await checkPermission();
      cprint('📍 LocationService: Current permission: $permission');

      if (permission == LocationPermission.denied) {
        if (requestPermissionIfNeeded) {
          cprint('📍 LocationService: Requesting permission...');
          permission = await requestPermission();
        }

        if (permission == LocationPermission.denied) {
          cprint('❌ LocationService: Permission denied');
          return LocationResult.error(
            errorType: LocationErrorType.permissionDenied,
            errorMessage: 'Location permission denied',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        cprint('❌ LocationService: Permission denied forever');
        return LocationResult.error(
          errorType: LocationErrorType.permissionDeniedForever,
          errorMessage: 'Location permission permanently denied',
        );
      }

      // Get current position
      cprint('📍 LocationService: Getting current position...');
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 15),
        ),
      );

      cprint(
        '✅ LocationService: Position: ${position.latitude}, ${position.longitude}',
      );

      // Get address from coordinates
      return await _getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
    } on TimeoutException {
      cprint('❌ LocationService: Timeout getting location');
      return LocationResult.error(
        errorType: LocationErrorType.timeout,
        errorMessage: 'Location request timed out',
      );
    } catch (e) {
      cprint('❌ LocationService: Error getting location: $e');
      return LocationResult.error(
        errorType: LocationErrorType.unknown,
        errorMessage: e.toString(),
      );
    }
  }

  /// Get address from coordinates using geocoding
  Future<LocationResult> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      cprint('📍 LocationService: Getting address from coordinates...');

      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        cprint('✅ LocationService: Place: ${place.toJson()}');

        // Build location name
        String locationName = _buildLocationName(place);

        return LocationResult.success(
          locationName: locationName,
          city: place.locality ?? place.subAdministrativeArea,
          country: place.country,
          latitude: latitude,
          longitude: longitude,
        );
      }

      // Fallback if no placemarks found
      cprint('⚠️ LocationService: No placemarks found, using coordinates');
      return LocationResult.success(
        locationName: '$latitude, $longitude',
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      cprint('❌ LocationService: Geocoding error: $e');
      // Return coordinates as fallback
      return LocationResult.success(
        locationName: '$latitude, $longitude',
        latitude: latitude,
        longitude: longitude,
      );
    }
  }

  /// Build a readable location name from placemark
  String _buildLocationName(Placemark place) {
    final parts = <String>[];

    // Add subLocality or neighborhood
    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      parts.add(place.subLocality!);
    }

    // Add locality (city)
    if (place.locality != null && place.locality!.isNotEmpty) {
      parts.add(place.locality!);
    } else if (place.subAdministrativeArea != null &&
        place.subAdministrativeArea!.isNotEmpty) {
      parts.add(place.subAdministrativeArea!);
    }

    // If no parts, use administrative area or country
    if (parts.isEmpty) {
      if (place.administrativeArea != null &&
          place.administrativeArea!.isNotEmpty) {
        parts.add(place.administrativeArea!);
      } else if (place.country != null && place.country!.isNotEmpty) {
        parts.add(place.country!);
      }
    }

    return parts.isNotEmpty ? parts.join(', ') : 'Unknown Location';
  }
}
