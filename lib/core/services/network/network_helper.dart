import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:greenhub/core/shared/cache/cache_methods.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app_config/app_config.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../utils/utility.dart';
import '../fcm_notification/fcm_integration_helper.dart';

enum ServerMethods { GET, POST, UPDATE, DELETE, PUT, PATCH, DOWNLOAD }

class Network {
  // Private instance for singleton behavior
  static final Network _instance = Network._internal();

  // Dio instance
  final Dio _dio;

  // Private constructor
  Network._internal()
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.BASE_URL,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
        ),
      ) {
    _configureInterceptors();
  }

  // Factory constructor to return the same instance
  factory Network() => _instance;

  // Interceptor configuration
  void _configureInterceptors() {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
          error: true,
          maxWidth: 120,
        ),
      );
    }
    _dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.request,
          hitCacheOnErrorCodes: [401, 403],
          hitCacheOnNetworkFailure: true,
          maxStale: const Duration(days: 5),
          priority: CachePriority.high,
          cipher: null,
          // keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          allowPostMethod: false,
        ),
      ),
    );
  }

  static Future<Map<String, dynamic>> _getHeaders({
    bool? needToSendFcmTokenInHeader = false,
  }) async {
    String? token = await CacheMethods.getToken();
    String? deviceToken;

    if (needToSendFcmTokenInHeader == true) {
      // Use async method for reliable token retrieval
      deviceToken = await FCMIntegrationHelper.getFCMTokenAsync();
      cprint(
        '[Network] FCM Token for header: ${deviceToken != null ? 'OK' : 'NULL'}',
      );
    }

    Map<String, dynamic> map = {
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Authorization': token != null ? 'Bearer $token' : '',
      'X-Firebase-Token': deviceToken,
      'Accept-Language': mainAppBloc.globalLang,
    };
    map.removeWhere((key, value) => value == null || value == '');
    return map;
  }

  // Request method
  Future<Response> request(
    String endpoint, {
    required ServerMethods method,
    final Object? body,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
    final String? downloadPath,
    Function(int recived, int total)? onProgress,
    final String? baseUrl,
    final Duration? timoutDuration,
    final bool removeToken = false,
    final String? tempToken,
    final bool needToSendFcmTokenInHeader = false,
  }) async {
    // ─── Stateless Request Configuration ───
    // We avoid mutating _dio.options globally because it's a singleton.
    // Instead, we construct the full URL and use per-request Options.

    // 1. Determine the base URL
    final String effectiveBaseUrl = baseUrl ?? AppConfig.BASE_URL;

    // 2. Construct the full URL
    // We sanitize both ends to ensure exactly one slash between base and endpoint.
    final String fullUrl =
        endpoint.startsWith('http')
            ? endpoint
            : '${effectiveBaseUrl.replaceAll(RegExp(r'/$'), '')}/${endpoint.replaceAll(RegExp(r'^/'), '')}';

    // 3. Resolve Headers
    Map<String, dynamic> requestHeaders =
        headers ??
        await _getHeaders(
          needToSendFcmTokenInHeader: needToSendFcmTokenInHeader,
        );

    if (removeToken) {
      requestHeaders.remove('Authorization');
    }
    if (tempToken != null && tempToken.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $tempToken';
    }

    // 4. Per-request Options
    final options = Options(
      headers: requestHeaders,
      sendTimeout: timoutDuration,
      receiveTimeout: timoutDuration,
      // We don't need to set baseUrl in Options as we pass fullUrl
    );

    Response response;
    switch (method) {
      case ServerMethods.GET:
        response = await _dio.get(
          fullUrl,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case ServerMethods.POST:
        response = await _dio.post(
          fullUrl,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case ServerMethods.UPDATE:
      case ServerMethods.PATCH:
        response = await _dio.patch(
          fullUrl,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case ServerMethods.PUT:
        response = await _dio.put(
          fullUrl,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case ServerMethods.DELETE:
        response = await _dio.delete(
          fullUrl,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case ServerMethods.DOWNLOAD:
        if (downloadPath == null) {
          throw ArgumentError(
            'Download path cannot be null for DOWNLOAD method',
          );
        }
        response = await _dio.download(
          fullUrl,
          downloadPath,
          onReceiveProgress: onProgress,
          options: options,
        );
        break;
    }

    return response;
  }

}
