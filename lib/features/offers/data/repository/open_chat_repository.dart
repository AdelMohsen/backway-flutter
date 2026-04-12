import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/open_chat_model.dart';
import '../params/open_chat_params.dart';

class OpenChatRepository {
  static Future<Either<ErrorEntity, OpenChatModel>> openChat({
    required int orderId,
    required OpenChatParams params,
  }) async {
    try {
      final response = await Network().request(
        Endpoints.openChat(orderId),
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Right(OpenChatModel.fromJson(response.data));
      } else {
        return Left(ApiErrorHandler().handleError(response));
      }
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
