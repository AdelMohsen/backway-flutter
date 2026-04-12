import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../model/register_model.dart';
import '../params/register_params.dart';

abstract class RegisterRepo {
  const RegisterRepo();

  static Future<Either<ErrorEntity, RegisterModel>> register(
    RegisterParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.register,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(RegisterModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
