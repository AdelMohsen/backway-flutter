import 'package:dartz/dartz.dart';
import 'package:greenhub/core/app_config/api_names.dart';
import 'package:greenhub/core/services/error_handler/error_handler.dart';
import 'package:greenhub/core/services/network/network_helper.dart';
import 'package:greenhub/core/services/network/dio_rescue_helper.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import '../models/invoice_model.dart';
import '../params/download_invoice_params.dart';

class DownloadInvoiceRepository {
  static Future<Either<ErrorEntity, InvoiceModel>> getInvoice({
    required int orderId,
    required DownloadInvoiceParams params,
  }) async {
    try {
      // استخدام الـ Helper العالمي الذي يتعامل مع مشاكل السيرفر تلقائياً
      final response = await DioRescueHelper.request(
        Endpoints.getInvoice(orderId),
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      return Right(InvoiceModel.fromJson(response.data));
    } catch (error) {
      // إرسال الخطأ للمعالجة القياسية في المشروع
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
