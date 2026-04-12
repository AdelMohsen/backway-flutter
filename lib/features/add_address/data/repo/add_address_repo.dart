import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/add_address_model.dart';
import '../models/city_model.dart';
import '../models/region_model.dart';
import '../params/add_address_params.dart';

abstract class AddAddressRepo {
  const AddAddressRepo();

  /// Save new address inside the backend
  static Future<Either<ErrorEntity, AddAddressModel>> addAddress(
    AddAddressParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.addAddress,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(AddAddressModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  /// Get the list of all available regions in the specified language
  static Future<Either<ErrorEntity, RegionResponseModel>> getRegions() async {
    try {
      final lang = mainAppBloc.isArabic ? 'ar' : 'en';
      final response = await Network().request(
        '${Endpoints.regions}?lang=$lang',
        method: ServerMethods.GET,
      );
      return Right(RegionResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  /// Get the list of cities contained within a specific region ID
  static Future<Either<ErrorEntity, CityResponseModel>> getCities(
    int regionId,
  ) async {
    try {
      final lang = mainAppBloc.isArabic ? 'ar' : 'en';
      final response = await Network().request(
        '${Endpoints.regionCities}/$regionId/cities?lang=$lang',
        method: ServerMethods.GET,
      );
      return Right(CityResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
