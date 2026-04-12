import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/about_services_model.dart';
import '../params/about_services_params.dart';

abstract class AboutServicesRepository {
  static Future<Either<ErrorEntity, AboutServicesModel>> getServices(
    AboutServicesParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.services,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(AboutServicesModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
