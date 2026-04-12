import 'package:equatable/equatable.dart';

class ErrorMessages extends Equatable {
  static const String connectionerror = 'connection error';
  static const String maybeerrorinserver = 'maybe error in server';
  static const String maybeinternetconnectionislost =
      'maybe internet connection is lost';
  static const String userCancelledSignIn = 'User cancelled sign in';
  static const String sendTimeout =
      'Request took too long to send. Please check your internet connection and try again';
  static const String receiveTimeout =
      'Response took too long to receive. Please check your internet connection and try again';
  static const String internalServerError =
      'An unexpected error occurred on our servers. Please try again later or contact support if the issue persists';
  static const String responseReturnedHtml =
      'The server returned an invalid response format. Please try again later or contact support if the issue persists';
  static const String connectionTimeout =
      'Connection timed out. Please check your internet connection and try again';
  static const String badCertificate =
      'The server certificate is invalid. Please try again later or contact support if the issue persists';
  static const String cancelRequest =
      'Request cancelled by the user. Please try again if needed';

  @override
  List<Object?> get props => [
    connectionerror,
    maybeerrorinserver,
    maybeinternetconnectionislost,
    userCancelledSignIn,
    sendTimeout,
    receiveTimeout,
    internalServerError,
    responseReturnedHtml,
    connectionTimeout,
    badCertificate,
    cancelRequest,
  ];
}
