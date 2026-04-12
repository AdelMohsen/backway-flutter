import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/about_model.dart';
import '../params/about_params.dart';

abstract class AboutRepository {
  static Future<Either<ErrorEntity, AboutModel>> getAbout(
    AboutParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.about,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(AboutModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
