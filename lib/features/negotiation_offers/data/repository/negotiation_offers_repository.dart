import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/negotiation_offers_model.dart';
import '../params/negotiation_offers_params.dart';
import '../params/send_message_params.dart';

class NegotiationOffersRepository {
  static Future<Either<ErrorEntity, NegotiationOffersModel>> getOrderChat(
      {required int orderId, required NegotiationOffersParams params}) async {
    try {
      final response = await Network().request(
        Endpoints.orderChat(orderId),
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      return Right(NegotiationOffersModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, bool>> sendMessage(
      {required int orderId, required SendMessageParams params}) async {
    try {
      await Network().request(
        Endpoints.sendOrderChatMessage(orderId),
        method: ServerMethods.POST,
        body: FormData.fromMap(await params.returnedMap()),
      );
      return const Right(true);
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, bool>> addService({
    required int orderId,
    required String serviceType,
  }) async {
    try {
      await Network().request(
        Endpoints.addService(orderId),
        method: ServerMethods.POST,
        body: {'service_type': serviceType},
      );
      return const Right(true);
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
