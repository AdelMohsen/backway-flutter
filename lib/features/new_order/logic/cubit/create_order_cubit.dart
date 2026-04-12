import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/models/package_type_model.dart';
import '../../data/models/vehicle_type_model.dart';
import '../../data/params/create_order_params.dart';
import '../../data/repository/create_order_repo.dart';
import '../state/create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  // ─── Text Controllers ───────────────────────────────────────────────────────
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController scheduledAtController = TextEditingController();

  // ─── Form State ─────────────────────────────────────────────────────────────

  /// Order type: 0 = instant, 1 = scheduled
  int selectedType = 0;

  /// Vehicle type ID from API (as String for dropdown compatibility)
  String? selectedVehicleTypeId;

  /// Service type: 'transport' or 'installation'
  String? selectedServiceType = 'transport';

  /// Package type ID from API (as String for dropdown compatibility)
  String? selectedPackageTypeId;

  /// Number of vehicles
  int vehiclesCount = 1;

  /// Package size: 'small', 'medium', 'large'
  String? selectedPackageSize;

  // ─── Location Data ──────────────────────────────────────────────────────────
  double? pickupLat;
  double? pickupLng;
  String? pickupAddress;

  double? deliveryLat;
  double? deliveryLng;
  String? deliveryAddress;

  // ─── Images ─────────────────────────────────────────────────────────────────
  final List<File> packageImages = [];
  final ImagePicker _picker = ImagePicker();

  // ─── Data Lists ─────────────────────────────────────────────────────────────
  List<VehicleTypeModel> vehicleTypes = [];
  List<PackageTypeModel> packageTypes = [];

  // ═══════════════════════════════════════════════════════════════════════════
  // API CALLS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> loadVehicleTypes() async {
    emit(VehicleTypesLoading());
    final result = await CreateOrderRepo.getVehicleTypes();
    result.fold((error) => emit(VehicleTypesError(error)), (data) {
      vehicleTypes = data;
      emit(VehicleTypesLoaded(data));
    });
  }

  Future<void> loadPackageTypes() async {
    emit(PackageTypesLoading());
    final result = await CreateOrderRepo.getPackageTypes();
    result.fold((error) => emit(PackageTypesError(error)), (data) {
      packageTypes = data;
      emit(PackageTypesLoaded(data));
    });
  }

  bool validate() {
    emit(
      CreateOrderInitial(),
    ); // Reset state to ensure listener catches new error even if same message

    if (selectedVehicleTypeId == null) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.selectVehicleType.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }
    if (selectedPackageTypeId == null) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.selectPackageType.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }
    if (pickupLat == null || pickupLng == null) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.selectStartingPoint.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }
    if (deliveryLat == null || deliveryLng == null) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.selectDestination.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }
    if (phoneController.text.isEmpty) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.recipientPhoneNumber.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }
    if (selectedType == 1 && scheduledAtController.text.isEmpty) {
      emit(
        CreateOrderError(
          ErrorEntity(statusCode: -1, message: AppStrings.date.tr, errors: []),
        ),
      );
      return false;
    }

    // Forced image validation: Min 1 image, Max 8 images
    if (packageImages.isEmpty) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.atLeastOneImageIsRequired.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }

    if (packageImages.length > 8) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.maxImagesLimitReached.tr,
            errors: [],
          ),
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> createOrder() async {
    if (!validate()) return;

    emit(CreateOrderLoading());

    final typeString = selectedType == 0 ? 'instant' : 'scheduled';

    final params = CreateOrderParams(
      type: typeString,
      vehicleTypeId: selectedVehicleTypeId != null
          ? int.tryParse(selectedVehicleTypeId!)
          : null,
      serviceType: selectedServiceType,
      packageTypeId: selectedPackageTypeId != null
          ? int.tryParse(selectedPackageTypeId!)
          : null,
      vehiclesCount: vehiclesCount,
      packageSize: selectedPackageSize,
      packageWeight: weightController.text.isNotEmpty
          ? weightController.text
          : null,
      notes: notesController.text.isNotEmpty ? notesController.text : null,
      pickupLat: pickupLat,
      pickupLng: pickupLng,
      pickupAddress: pickupAddress,
      deliveryAddress: deliveryAddress,
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
      deliveryContactPhone: phoneController.text.isNotEmpty
          ? phoneController.text
          : null,
      scheduledAt: scheduledAtController.text.isNotEmpty
          ? '${scheduledAtController.text}T00:00:00.000000Z'
          : null,
      packageImages: packageImages.isNotEmpty ? packageImages : null,
    );

    final result = await CreateOrderRepo.createOrder(params);
    result.fold(
      (error) => emit(CreateOrderError(error)),
      (response) => emit(CreateOrderSuccess(response)),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FORM HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  void setOrderType(int type) {
    selectedType = type;
    emit(CreateOrderInitial());
  }

  void setVehicleType(String? id) {
    selectedVehicleTypeId = id;
    emit(CreateOrderInitial());
  }

  void setServiceType(String? type) {
    selectedServiceType = type;
    emit(CreateOrderInitial());
  }

  void setPackageType(String? id) {
    selectedPackageTypeId = id;
    emit(CreateOrderInitial());
  }

  void setPackageSize(String? size) {
    selectedPackageSize = size;
    emit(CreateOrderInitial());
  }

  void incrementVehiclesCount() {
    vehiclesCount++;
    emit(CreateOrderInitial());
  }

  void decrementVehiclesCount() {
    if (vehiclesCount > 1) {
      vehiclesCount--;
      emit(CreateOrderInitial());
    }
  }

  void setPickupLocation(double lat, double lng, String address) {
    pickupLat = lat;
    pickupLng = lng;
    pickupAddress = address;
    fromController.text = address;
    emit(CreateOrderInitial());
  }

  void setDeliveryLocation(double lat, double lng, String address) {
    deliveryLat = lat;
    deliveryLng = lng;
    deliveryAddress = address;
    toController.text = address;
    emit(CreateOrderInitial());
  }

  // ─── Image Handling ─────────────────────────────────────────────────────────

  Future<void> pickImages() async {
    final int remaining = 8 - packageImages.length;
    if (remaining <= 0) {
      emit(
        CreateOrderError(
          ErrorEntity(
            statusCode: -1,
            message: AppStrings.maxImagesLimitReached.tr,
            errors: [],
          ),
        ),
      );
      return;
    }

    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      if (images.length > remaining) {
        emit(
          CreateOrderError(
            ErrorEntity(
              statusCode: -1,
              message: AppStrings.maxImagesLimitReached.tr,
              errors: [],
            ),
          ),
        );
      }

      // Respect the limit of 8 images total
      final List<XFile> availableSlots = images.length > remaining
          ? images.sublist(0, remaining)
          : images;

      bool hasLargeImage = false;

      for (var xFile in availableSlots) {
        final File file = File(xFile.path);
        final int sizeInBytes = await file.length();
        final double sizeInMb = sizeInBytes / (1024 * 1024);

        if (sizeInMb <= 3) {
          // Avoid duplicates by checking path
          if (!packageImages.any((img) => img.path == file.path)) {
            packageImages.add(file);
          }
        } else {
          hasLargeImage = true;
        }
      }

      if (hasLargeImage) {
        emit(
          CreateOrderError(
            ErrorEntity(
              statusCode: -1,
              message: AppStrings.imageSizeTooBig.tr,
              errors: [],
            ),
          ),
        );
      }

      emit(CreateOrderInitial()); // Refresh UI
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < packageImages.length) {
      packageImages.removeAt(index);
      emit(CreateOrderInitial());
    }
  }

  void refresh() {
    emit(CreateOrderInitial());
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIFECYCLE
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Future<void> close() {
    weightController.dispose();
    notesController.dispose();
    phoneController.dispose();
    fromController.dispose();
    toController.dispose();
    scheduledAtController.dispose();
    return super.close();
  }
}
