import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/services/network/network_helper.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/order_details/data/models/order_details_model.dart';
import 'package:greenhub/features/order_details/data/params/order_details_params.dart';

class OrderDetailsRepository {
  static Future<Either<ErrorEntity, OrderDetailsResponseModel>> getOrderDetails(
      OrderDetailsParams params) async {
    try {
      final response = await Network().request(
        Endpoints.getOrderDetails(params.orderId),
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      return Right(OrderDetailsResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
