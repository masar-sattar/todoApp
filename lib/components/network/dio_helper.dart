import 'package:dio/dio.dart';
import 'app_interceptor.dart';

class DioHelper {
  static Dio? _dio;
  static String? token;

  /// إعداد Dio حسب وجود التوكن والهيدرز المخصصة
  static Dio _dioInstance({Map<String, dynamic>? customHeaders}) {
    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      ...?customHeaders,
    };

    _dio = Dio(
      BaseOptions(
        baseUrl: "https://todo.iraqsapp.com",
        headers: headers,
        // يمكنك إضافة timeouts لو أردت:
        // connectTimeout: const Duration(seconds: 15),
        // receiveTimeout: const Duration(seconds: 15),
      ),
    )..interceptors.add(AppInterceptor());

    return _dio!;
  }

  /// POST request
  static Future<Response> postData({
    required String endPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool sendAuth = true,
  }) async {
    try {
      final dio = _dioInstance(customHeaders: sendAuth ? headers : {});
      final response = await dio.post(
        endPoint,
        queryParameters: query,
        data: body,
      );
      return response;
    } catch (error) {
      print('POST error: $error');
      throw Exception('POST request failed: $error');
    }
  }

  /// GET request
  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool sendAuth = true,
  }) async {
    try {
      final dio = _dioInstance(customHeaders: sendAuth ? headers : {});
      final response = await dio.get(
        endPoint,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      print('GET error: $error');
      throw Exception('GET request failed: $error');
    }
  }

  /// PUT request
  static Future<Response> putData({
    required String endPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool sendAuth = true,
  }) async {
    try {
      final dio = _dioInstance(customHeaders: sendAuth ? headers : {});
      final response = await dio.put(
        endPoint,
        queryParameters: query,
        data: body,
      );
      return response;
    } catch (error) {
      print('PUT error: $error');
      throw Exception('PUT request failed: $error');
    }
  }

  /// DELETE request
  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? headers,
    bool sendAuth = true,
  }) async {
    try {
      final dio = _dioInstance(customHeaders: sendAuth ? headers : {});
      final response = await dio.delete(endPoint);
      return response;
    } catch (error) {
      print('DELETE error: $error');
      throw Exception('DELETE request failed: $error');
    }
  }

  /// تعيين التوكن بعد تسجيل الدخول
  static void setToken(String newToken) {
    token = newToken;
  }

  /// حذف التوكن (عند تسجيل الخروج مثلاً)
  static void clearToken() {
    token = null;
  }
}
