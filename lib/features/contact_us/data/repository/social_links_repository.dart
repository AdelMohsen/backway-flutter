import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/social_links_model.dart';
import '../params/social_links_params.dart';

abstract class SocialLinksRepository {
  static Future<Either<ErrorEntity, SocialLinksModel>> getSocialLinks(
    SocialLinksParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.socialLinks,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(SocialLinksModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
