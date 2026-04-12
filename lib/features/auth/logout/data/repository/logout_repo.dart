import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/logout_model.dart';
import '../params/logout_params.dart';

abstract class LogoutRepo {
  const LogoutRepo();

  static Future<Either<ErrorEntity, LogoutModel>> logout(
    LogoutParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.logout,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(LogoutModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
