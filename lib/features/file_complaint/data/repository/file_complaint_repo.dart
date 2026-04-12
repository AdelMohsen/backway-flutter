import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/complaint_model.dart';
import '../params/file_complaint_params.dart';

abstract class FileComplaintRepo {
  static Future<Either<ErrorEntity, ComplaintModel>> fileComplaint(
    FileComplaintParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.complaints,
        method: ServerMethods.POST,
        body: FormData.fromMap(await params.returnedMap()),
      );

      return Right(ComplaintModel.fromJson(response.data['data']));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
