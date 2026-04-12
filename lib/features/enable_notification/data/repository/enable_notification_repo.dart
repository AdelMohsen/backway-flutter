import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/enable_notification_model.dart';
import '../params/enable_notification_params.dart';

abstract class EnableNotificationRepo {
  const EnableNotificationRepo();

  static Future<Either<ErrorEntity, EnableNotificationModel>> toggleNotification(
    EnableNotificationParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.enableNotification,
        method: ServerMethods.PUT,
        body: params.returnedMap(),
        needToSendFcmTokenInHeader: false,
      );
      return Right(EnableNotificationModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
