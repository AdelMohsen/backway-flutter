import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';
import 'package:greenhub/features/order_tracking/data/params/tracking_params.dart';

class TrackOrderHomeRepository {
  static Future<Either<ErrorEntity, TrackingModel>> trackOrder(TrackingParams params) async {
    try {
      final response = await Network().request(
        Endpoints.trackOrderHome(params.orderNumber!),
        method: ServerMethods.GET,
      );

      final model = TrackingModel.fromJson(response.data);
      return Right(model);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
