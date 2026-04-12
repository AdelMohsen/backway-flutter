import 'package:dartz/dartz.dart';

import '../../../app_config/api_names.dart';
import '../../error_handler/error_handler.dart';
import '../../network/network_helper.dart';
import '../../../shared/entity/error_entity.dart';
import '../model/app_settings_model.dart';

abstract class AppSettingsRepo {
  const AppSettingsRepo();
  static Future<Either<ErrorEntity, AppSettingsModel>> appSettings() async {
    try {
      final response = await Network().request(
        Endpoints.appSettings,
        method: ServerMethods.GET,
      );
      return Right(AppSettingsModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
