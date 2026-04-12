import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/create_order_model.dart';
import '../models/package_type_model.dart';
import '../models/vehicle_type_model.dart';
import '../params/create_order_params.dart';

abstract class CreateOrderRepo {
  const CreateOrderRepo();

  /// Create a new order
  static Future<Either<ErrorEntity, CreateOrderResponseModel>> createOrder(
    CreateOrderParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.createOrder,
        method: ServerMethods.POST,
        body: FormData.fromMap(await params.returnedMap()),
        queryParameters: {'lang': mainAppBloc.globalLang},
      );
      return Right(CreateOrderResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  /// Get available vehicle types
  static Future<Either<ErrorEntity, List<VehicleTypeModel>>>
  getVehicleTypes() async {
    try {
      final lang = mainAppBloc.isArabic ? 'ar' : 'en';
      final response = await Network().request(
        '${Endpoints.vehicleTypes}?lang=$lang',
        method: ServerMethods.GET,
      );
      final List<dynamic> data = response.data['data'] ?? [];
      final vehicleTypes = data
          .map((e) => VehicleTypeModel.fromJson(e))
          .toList();
      return Right(vehicleTypes);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  /// Get available package types
  static Future<Either<ErrorEntity, List<PackageTypeModel>>>
  getPackageTypes() async {
    try {
      final lang = mainAppBloc.isArabic ? 'ar' : 'en';
      final response = await Network().request(
        '${Endpoints.packageTypes}?lang=$lang',
        method: ServerMethods.GET,
      );
      final List<dynamic> data = response.data['data'] ?? [];
      final packageTypes = data
          .map((e) => PackageTypeModel.fromJson(e))
          .toList();
      return Right(packageTypes);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
