import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/messages_model.dart';
import '../params/messages_params.dart';

class MessagesRepository {
  static Future<Either<ErrorEntity, MessagesModel>> getChats(
      MessagesParams params) async {
    try {
      final response = await Network().request(
        Endpoints.chat,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      return Right(MessagesModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
