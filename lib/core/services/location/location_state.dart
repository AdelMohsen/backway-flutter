import 'location_service.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String locationName;
  final String? city;
  final String? country;
  final double? latitude;
  final double? longitude;

  LocationLoaded({
    required this.locationName,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
  });
}

class LocationError extends LocationState {
  final LocationErrorType errorType;
  final String message;

  LocationError({required this.errorType, required this.message});
}

class LocationPermissionDenied extends LocationState {
  final bool isPermanent;

  LocationPermissionDenied({required this.isPermanent});
}

class LocationServiceDisabled extends LocationState {}

class LocationForcePermission extends LocationState {}
