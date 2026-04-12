import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/offers_model.dart';
import '../params/offers_params.dart';

class OffersRepository {
  const OffersRepository();

  static Future<Either<ErrorEntity, OffersModel>> getOffers(
    OffersParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.appImages,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(OffersModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
