import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/cache/cache_methods.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../user/model/user_model.dart';
import '../../../login/data/model/login_model.dart';
import '../../../login/data/params/login_params.dart';
import '../model/verify_otp_then_login_model.dart';
import '../params/verify_otp_then_login_params.dart';

abstract class VerifyCodeRepo {
  const VerifyCodeRepo();

  /// Verify OTP and login - saves token and user data on success
  static Future<Either<ErrorEntity, VerifyOtpThenLoginModel>>
  verifyOtpThenLogin(VerifyOtpThenLoginParams params) async {
    try {
      final response = await Network().request(
        Endpoints.verifyOtpThenLogin,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      final model = VerifyOtpThenLoginModel.fromJson(response.data);

      // Save token to cache
      await CacheMethods.saveToken(model.token);

      // Save user data to cache - convert UserDataModel to UserModel format
      final userModel = UserModel.fromJson({
        'data': model.user.toJson(),
      }, token: model.token);
      await CacheMethods.saveUser(userModel);

      return Right(model);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  /// Verify Registration OTP and login - saves token and user data on success
  static Future<Either<ErrorEntity, VerifyOtpThenLoginModel>> verifyRegisterOtp(
    VerifyOtpThenLoginParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.verifyRegisterOtp,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      final model = VerifyOtpThenLoginModel.fromJson(response.data);

      // Save token to cache
      await CacheMethods.saveToken(model.token);

      // Save user data to cache - convert UserDataModel to UserModel format
      final userModel = UserModel.fromJson({
        'data': model.user.toJson(),
      }, token: model.token);
      await CacheMethods.saveUser(userModel);

      return Right(model);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  /// Resend OTP - same as LoginRepo.sendOtp
  static Future<Either<ErrorEntity, LoginModel>> resendOtp(
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
