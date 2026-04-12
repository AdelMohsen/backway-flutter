import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/services/network/network_helper.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/order_details/data/models/cancel_order_model.dart';
import 'package:greenhub/features/order_details/data/params/cancel_order_params.dart';

class CancelOrderDetailsRepository {
  static Future<Either<ErrorEntity, CancelOrderResponseModel>> cancelOrder({
    required int orderId,
    required CancelOrderParams params,
  }) async {
    try {
      final response = await Network().request(
        Endpoints.cancelOrder(orderId),
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      return Right(CancelOrderResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
