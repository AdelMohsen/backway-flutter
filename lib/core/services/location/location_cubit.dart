import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greenhub/core/shared/cache/secure_storage.dart';

import '../../utils/utility.dart';
import 'location_service.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final LocationService _locationService = LocationService();

  // Cache keys
  static const String _locationNameKey = 'cached_location_name';
  static const String _locationCityKey = 'cached_location_city';
  static const String _locationLatKey = 'cached_location_lat';
  static const String _locationLngKey = 'cached_location_lng';

  /// Initialize location - try to load from cache first, then fetch
  Future<void> initLocation() async {
    // Try to load cached location first
    final cachedLocation = await _loadCachedLocation();
    if (cachedLocation != null) {
      emit(cachedLocation);
    }

    // Then try to get fresh location
    await getCurrentLocation(showLoadingIfCached: cachedLocation == null);
  }

  /// Get current location
  Future<void> getCurrentLocation({bool showLoadingIfCached = true}) async {
    if (showLoadingIfCached) {
      emit(LocationLoading());
    }

    final result = await _locationService.getCurrentLocation();

    if (result.success) {
      final loadedState = LocationLoaded(
        locationName: result.locationName!,
        city: result.city,
        country: result.country,
        latitude: result.latitude,
        longitude: result.longitude,
      );

      // Cache the location
      await _cacheLocation(loadedState);

      emit(loadedState);
    } else {
      _handleLocationError(result);
    }
  }

  /// Handle location error
  void _handleLocationError(LocationResult result) {
    switch (result.errorType) {
      case LocationErrorType.serviceDisabled:
        emit(LocationServiceDisabled());
        break;
      case LocationErrorType.permissionDenied:
        emit(LocationPermissionDenied(isPermanent: false));
        break;
      case LocationErrorType.permissionDeniedForever:
        emit(LocationPermissionDenied(isPermanent: true));
        break;
      default:
        emit(
          LocationError(
            errorType: result.errorType!,
            message: result.errorMessage ?? 'Unknown error',
          ),
        );
    }
  }

  /// Request permission and get location
  Future<void> requestPermissionAndGetLocation() async {
    emit(LocationLoading());

    final permission = await _locationService.requestPermission();
    cprint('📍 LocationCubit: Permission result: $permission');

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await getCurrentLocation();
    } else if (permission == LocationPermission.deniedForever) {
      emit(LocationPermissionDenied(isPermanent: true));
    } else {
      emit(LocationPermissionDenied(isPermanent: false));
    }
  }

  /// Open location settings
  Future<void> openLocationSettings() async {
    await _locationService.openLocationSettings();
  }

  /// Open app settings (for permanent denial)
  Future<void> openAppSettings() async {
    await _locationService.openAppSettings();
  }

  /// Retry getting location
  Future<void> retry() async {
    await getCurrentLocation();
  }

  final SecureStorageService _storage = SecureStorageService();

  /// Cache location data
  Future<void> _cacheLocation(LocationLoaded state) async {
    try {
      await _storage.write(key: _locationNameKey, value: state.locationName);
      if (state.city != null) {
        await _storage.write(key: _locationCityKey, value: state.city!);
      }
      if (state.latitude != null) {
        await _storage.writeDouble(
          key: _locationLatKey,
          value: state.latitude!,
        );
      }
      if (state.longitude != null) {
        await _storage.writeDouble(
          key: _locationLngKey,
          value: state.longitude!,
        );
      }
      cprint('✅ LocationCubit: Location cached');
    } catch (e) {
      cprint('❌ LocationCubit: Failed to cache location: $e');
    }
  }

  /// Load cached location
  Future<LocationLoaded?> _loadCachedLocation() async {
    try {
      final locationName = await _storage.read(key: _locationNameKey);
      if (locationName != null && locationName.isNotEmpty) {
        final city = await _storage.read(key: _locationCityKey);
        final lat = await _storage.readDouble(key: _locationLatKey);
        final lng = await _storage.readDouble(key: _locationLngKey);

        cprint('📍 LocationCubit: Loaded cached location: $locationName');

        return LocationLoaded(
          locationName: locationName,
          city: city,
          latitude: lat,
          longitude: lng,
        );
      }
    } catch (e) {
      cprint('❌ LocationCubit: Failed to load cached location: $e');
    }
    return null;
  }

  /// Clear cached location
  Future<void> clearCache() async {
    try {
      await _storage.delete(key: _locationNameKey);
      await _storage.delete(key: _locationCityKey);
      await _storage.delete(key: _locationLatKey);
      await _storage.delete(key: _locationLngKey);
    } catch (e) {
      cprint('❌ LocationCubit: Failed to clear cache: $e');
    }
  }
}
