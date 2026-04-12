import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../model/login_model.dart';
import '../params/login_params.dart';

abstract class LoginRepo {
  const LoginRepo();

  static Future<Either<ErrorEntity, LoginModel>> sendOtp(
    LoginParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.sendOtp,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(LoginModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
