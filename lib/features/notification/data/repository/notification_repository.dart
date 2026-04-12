import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/notification_model.dart';
import '../params/notification_params.dart';

class NotificationRepository {
  static Future<Either<ErrorEntity, NotificationModel>> getNotifications(
      NotificationParams params) async {
    try {
      final response = await Network().request(
        Endpoints.notifications,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      return Right(NotificationModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, Map<String, dynamic>>>
      readAllNotifications() async {
    try {
      final response = await Network().request(
        Endpoints.readAllNotifications,
        method: ServerMethods.POST,
      );

      return Right(response.data);
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
