import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/address/data/models/address_model.dart';

class AddressRepo {
  static Future<Either<ErrorEntity, List<AddressModel>>> getAddresses() async {
    try {
      final response = await Network().request(
        Endpoints.getAddresses,
        method: ServerMethods.GET,
      );

      final result = AddressResponseModel.fromJson(response.data);
      return Right(result.data);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
