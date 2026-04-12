import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/add_address/data/models/add_address_model.dart';
import 'package:greenhub/features/add_address/data/models/city_model.dart';
import 'package:greenhub/features/add_address/data/models/region_model.dart';
import 'package:greenhub/features/edit_address/data/params/edit_address_params.dart';

class EditAddressRepo {
  static Future<Either<ErrorEntity, AddAddressModel>> updateAddress(
    int addressId,
    EditAddressParams params,
  ) async {
    try {
      final response = await Network().request(
        '${Endpoints.updateAddress}/$addressId',
        method: ServerMethods.PUT,
        body: params.returnedMap(),
      );

      final result = AddAddressModel.fromJson(response.data);
      if (result.success == true) {
        return Right(result);
      } else {
        return Left(
          ErrorEntity(
            statusCode: 400,
            errors: const [],
            message: 'Unknown error',
          ),
        );
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, List<RegionModel>>> getRegions() async {
    try {
      final response = await Network().request(
        Endpoints.regions,
        method: ServerMethods.GET,
        queryParameters: {'lang': 'ar'},
      );

      final result = RegionResponseModel.fromJson(response.data);
      if (result.success) {
        return Right(result.data);
      } else {
        return Left(
          ErrorEntity(
            statusCode: 400,
            errors: const [],
            message: 'Unknown error',
          ),
        );
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, List<CityModel>>> getCities(
    int regionId,
  ) async {
    try {
      final response = await Network().request(
        '${Endpoints.regionCities}/$regionId/cities',
        method: ServerMethods.GET,
      );

      final result = CityResponseModel.fromJson(response.data);
      if (result.success) {
        return Right(result.data);
      } else {
        return Left(
          ErrorEntity(
            statusCode: 400,
            errors: const [],
            message: 'Unknown error',
          ),
        );
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, String>> deleteAddress(
    int addressId,
  ) async {
    try {
      final response = await Network().request(
        '${Endpoints.updateAddress}/$addressId',
        method: ServerMethods.DELETE,
      );

      final isSuccess = response.data['success'] ?? false;
      if (isSuccess == true) {
        return Right(
          response.data['message'] ?? 'Address deleted successfully',
        );
      } else {
        return Left(
          ErrorEntity(
            statusCode: 400,
            errors: const [],
            message: response.data['message'] ?? 'Unknown error',
          ),
        );
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
