import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/add_funds_model.dart';
import '../params/add_funds_params.dart';

abstract class AddFundsRepo {
  const AddFundsRepo();

  /// Add funds to wallet
  static Future<Either<ErrorEntity, AddFundsResponseModel>> addFunds(
    AddFundsParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.addFunds,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(AddFundsResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
