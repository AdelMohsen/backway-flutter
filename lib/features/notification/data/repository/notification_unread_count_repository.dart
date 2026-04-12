import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/notification/data/models/notification_unread_count_model.dart';
import 'package:greenhub/features/notification/data/params/notification_unread_count_params.dart';

class NotificationUnreadCountRepository {
  static Future<Either<ErrorEntity, NotificationUnreadCountModel>> getUnreadCount(
      NotificationUnreadCountParams params) async {
    try {
      final response = await Network().request(
        Endpoints.notificationUnreadCount,
        method: ServerMethods.GET,
      );

      return Right(NotificationUnreadCountModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiErrorHandler().handleError(e));
    }
  }
}
