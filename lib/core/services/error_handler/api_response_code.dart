class ResponseCode {
  static const int success = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int internalServerError = 500;
  static const int notFound = 404;
  static const int apiLogicError = 422;
  static const int badGatway = 502;
  static const int badCertificate = 495;
  static const int clientClosedResponse = 499;

  static const int unknown = 0;

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receieveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int connectionError = -7;
  static const int userCancelledSignIn = -10;
  static const int validationError = -11;
  static const int jsonValidationError = -12;

  // ignore: constant_identifier_names
  static const int DEFAULT = -8;
}

enum ApiStatusEnum {
  success,
  created,
  badRequest,
  unauthorized,
  badGateway,
  forbidden,
  notFound,
  internalServerError,
  connectionError,
  jsonValidationError,
  unknown,
}

class ApiInternalStatus {
  static const bool success = true;
  static const bool faliure = false;
}
