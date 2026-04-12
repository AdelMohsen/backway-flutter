import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/negotiation_model.dart';
import '../models/reject_negotiation_model.dart';
import '../models/accept_negotiation_model.dart';
import '../params/negotiations_params.dart';

class NegotiationsRepository {
  static Future<Either<ErrorEntity, List<NegotiationModel>>> getNegotiations(
      NegotiationsParams params) async {
    try {
      final response = await Network().request(
        Endpoints.customerNegotiations,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> dataList = response.data['data'] ?? [];
        final List<NegotiationModel> negotiations =
            dataList.map((e) => NegotiationModel.fromJson(e)).toList();
        return Right(negotiations);
      } else {
        return Left(ApiErrorHandler().handleError(response));
      }
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
  static Future<Either<ErrorEntity, RejectNegotiationModel>> rejectNegotiation({
    required int orderId,
    required int negotiationId,
  }) async {
    try {
      final response = await Network().request(
        Endpoints.rejectNegotiation(orderId, negotiationId),
        method: ServerMethods.POST,
      );

      if (response.statusCode == 200 && response.data != null) {
        return Right(RejectNegotiationModel.fromJson(response.data));
      } else {
        return Left(ApiErrorHandler().handleError(response));
      }
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }

  static Future<Either<ErrorEntity, AcceptNegotiationModel>> acceptNegotiation({
    required int orderId,
    required int negotiationId,
  }) async {
    try {
      final response = await Network().request(
        Endpoints.acceptNegotiation(orderId, negotiationId),
        method: ServerMethods.POST,
      );

      if (response.statusCode == 200 && response.data != null) {
        return Right(AcceptNegotiationModel.fromJson(response.data));
      } else {
        return Left(ApiErrorHandler().handleError(response));
      }
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
