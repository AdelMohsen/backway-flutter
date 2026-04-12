import 'package:dio/dio.dart';

import '../../app_config/api_names.dart';
import '../../utils/extensions/extensions.dart';
import '../../shared/entity/error_entity.dart';
import '../../shared/entity/invalid_json_exception.dart';
import '../../shared/models/error_model.dart';
import '../../utils/utility.dart';
import 'api_response_code.dart';
import 'error_messages.dart';

abstract class ErrorHandler implements Exception {
  ErrorEntity handleError(dynamic response);
}

class ApiErrorHandler implements ErrorHandler {
  @override
  ErrorEntity handleError(response) {
    if (response is InvalidJsonException) {
      return response.error;
    }

    if (response is DioException) {
      if (checkFromMap(response.response?.data)) {
        if (response.response?.statusCode == ResponseCode.unAuthorized) {
          // Check if from auth screens (send OTP or verify OTP)
          final requestUri = response.response?.realUri.toString() ?? '';
          bool isFromAuthScreen =
              requestUri.contains(Endpoints.sendOtp) ||
              requestUri.contains(Endpoints.verifyOtpThenLogin) ||
              requestUri.contains(Endpoints.register);
          if (!isFromAuthScreen) {
            Utility.logout();
          }
        }
        return ErrorModel.fromJson(
          response.response?.data,
          statusCode: response.response?.statusCode,
        );
      }
      if (response.response?.statusCode == ResponseCode.internalServerError) {
        return ErrorModel(
          statusCode: ResponseCode.unknown,
          message: ErrorMessages.internalServerError.tr,
          errors: [ErrorMessages.internalServerError.tr],
        );
      }
      if (response.type == DioExceptionType.connectionError) {
        return ErrorModel(
          statusCode: ResponseCode.connectionError,
          message: ErrorMessages.connectionerror.tr,
          errors: [
            '* ${ErrorMessages.maybeerrorinserver.tr}',
            '* ${ErrorMessages.maybeinternetconnectionislost.tr}',
          ],
        );
      }
      if (response.type == DioExceptionType.sendTimeout) {
        return ErrorModel(
          statusCode: ResponseCode.sendTimeOut,
          message: ErrorMessages.sendTimeout.tr,
          errors: [
            '* ${ErrorMessages.sendTimeout.tr}',
            '* ${ErrorMessages.maybeinternetconnectionislost.tr}',
          ],
        );
      }
      if (response.type == DioExceptionType.receiveTimeout) {
        return ErrorModel(
          statusCode: ResponseCode.receieveTimeOut,
          message: ErrorMessages.receiveTimeout.tr,
          errors: [
            '* ${ErrorMessages.receiveTimeout.tr}',
            '* ${ErrorMessages.maybeinternetconnectionislost.tr}',
          ],
        );
      }
      if (response.type == DioExceptionType.connectionTimeout) {
        return ErrorModel(
          statusCode: ResponseCode.connectTimeOut,
          message: ErrorMessages.connectionTimeout.tr,
          errors: ['* ${ErrorMessages.connectionTimeout.tr}'],
        );
      }
      if (response.type == DioExceptionType.badCertificate) {
        return ErrorModel(
          statusCode: ResponseCode.badCertificate,
          message: ErrorMessages.badCertificate.tr,
          errors: ['* ${ErrorMessages.badCertificate.tr}'],
        );
      }
      if (response.type == DioExceptionType.cancel) {
        return ErrorModel(
          statusCode: ResponseCode.clientClosedResponse,
          message: ErrorMessages.cancelRequest.tr,
          errors: ['* ${ErrorMessages.cancelRequest.tr}'],
        );
      }
      if (response.type == DioExceptionType.unknown) {
        return const ErrorModel(
          statusCode: ResponseCode.unknown,
          message: 'unknown error',
          errors: [],
        );
      }
      return const ErrorModel(
        statusCode: ResponseCode.unknown,
        message: 'unknown error',
        errors: [],
      );
    }

    if (response is TypeError) {
      // if (response is String &&
      //     response.toString().toLowerCase().contains('<!doctype html>')) {
      //   return ErrorModel(
      //     statusCode: ResponseCode.unknown,
      //     message: ErrorMessages.responseReturnedHtml.tr,
      //     errors: [
      //       ErrorMessages.responseReturnedHtml.tr,
      //     ],
      //   );
      // }
      return ErrorModel(
        statusCode: ResponseCode.unknown,
        message: 'something changed in returned data',
        errors: [(response.toString())],
      );
    }
    if (response is NoSuchMethodError) {
      return ErrorModel(
        statusCode: ResponseCode.unknown,
        message: 'something changed in returned data',
        errors: [(response.toString())],
      );
    }
    return const ErrorModel(
      statusCode: ResponseCode.unknown,
      message: 'unknown error',
      errors: [],
    );
  }
}

class LocalErrorHandler implements ErrorHandler {
  @override
  ErrorEntity handleError(response) {
    return ErrorModel(
      statusCode: ResponseCode.unknown,
      message: response,
      errors: [response],
    );
  }
}
