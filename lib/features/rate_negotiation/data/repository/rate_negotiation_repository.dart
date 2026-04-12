import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network_helper.dart';
import 'package:greenhub/features/rate_negotiation/data/models/rate_negotiation_model.dart';
import 'package:greenhub/features/rate_negotiation/data/params/rate_negotiation_params.dart';

class RateNegotiationRepository {
  static Future<Either<ErrorEntity, RateNegotiationModel>> submitRating(
    int orderId,
    RateNegotiationParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.rateDriver(orderId),
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      
      return Right(RateNegotiationModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
