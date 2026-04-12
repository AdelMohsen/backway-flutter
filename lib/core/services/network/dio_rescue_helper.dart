import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:greenhub/core/app_config/app_config.dart';
import 'package:greenhub/core/services/network/network.dart';
import 'package:greenhub/core/services/network/network_helper.dart';
import 'package:greenhub/core/shared/cache/cache_methods.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/utils/utility.dart';

class DioRescueHelper {
  /// دالة عالمية تقوم بعمل الطلب وتصحيح الاستجابة تلقائياً إذا كانت "dirty"
  static Future<dio.Response> request(
    String endpoint, {
    required ServerMethods method,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // 1. المحاولة العادية باستخدام Network() الأصلي
      return await Network().request(
        endpoint,
        method: method,
        body: body,
        queryParameters: queryParameters,
      );
    } catch (error) {
      // 2. إذا فشل الطلب بسبب FormatException (نصوص زائدة من السيرفر)
      if (error.toString().contains("FormatException") || 
         (error is dio.DioException && error.type == dio.DioExceptionType.unknown)) {
        
        cprint("--- RESCUE MODE ACTIVATED ---", label: "RescueHelper");

        try {
          // جلب الإعدادات والتوكن بنفس طريقة المشروع
          final token = await CacheMethods.getToken();
          final rescueDio = dio.Dio(dio.BaseOptions(
            baseUrl: AppConfig.BASE_URL,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ));

          // طلب البيانات كنص بسيط Plain لتجنب الـ FormatException
          final response = await rescueDio.request(
            endpoint,
            data: body,
            queryParameters: queryParameters,
            options: dio.Options(
              method: method.name,
              responseType: dio.ResponseType.plain, 
              headers: {
                'Authorization': token != null ? 'Bearer $token' : '',
                'Accept': 'application/json',
                'Accept-Language': mainAppBloc.globalLang,
              },
            ),
          );

          String rawData = response.data.toString();
          
          if (rawData.contains('{')) {
            // استخراج وتدقيق الـ JSON
            String cleanedJson = rawData.substring(rawData.indexOf('{'));
            if (cleanedJson.contains('}')) {
              cleanedJson = cleanedJson.substring(0, cleanedJson.lastIndexOf('}') + 1);
            }
            
            // تحديث البيانات بالـ JSON المنظف
            response.data = jsonDecode(cleanedJson);
            cprint("--- RESCUE SUCCESSFUL ---", label: "RescueHelper");
            return response;
          }
        } catch (rescueError) {
          cprint("--- RESCUE FAILED: $rescueError ---", label: "RescueHelper");
        }
      }
      
      // إذا فشل كل شيء، ارمِ الخطأ الأصلي
      rethrow;
    }
  }
}
