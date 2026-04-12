import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/orders/data/models/orders_model.dart';
import 'package:greenhub/features/orders/data/params/orders_params.dart';

class OrdersRepository {
  static Future<Either<ErrorEntity, OrdersResponseModel>> getOrders(
      OrdersParams params) async {
    try {
      final response = await Network().request(
        Endpoints.getOrders,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
        needToSendFcmTokenInHeader: false,
      );
      return Right(OrdersResponseModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
