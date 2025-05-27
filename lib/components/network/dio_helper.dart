import 'package:dio/dio.dart';
import 'app_interceptor.dart';

class DioHelper {
  static Dio? _dio;
  static String? token;

  /// إنشاء أو إرجاع نسخة موجودة من Dio
  static Dio _dioInstance() {
    // if (_dio == null)
    //  {
    _dio = Dio(
      BaseOptions(
          baseUrl: "https://todo.iraqsapp.com",
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Authorization': "Bearer $token"}),
    )..interceptors.add(AppInterceptor());
    // }
    return _dio!;
  }

  /// POST request
  static Future<Response> postData({
    required String endPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final dio = _dioInstance();
      // dio.options.headers = headers ?? {};
      final response = await dio.post(
        endPoint,
        queryParameters: query,
        data: body,
      );
      return response;
    } catch (error) {
      print('Post error: $error');
      throw Exception('Post request failed: $error');
    }
  }

  /// DELETE request
  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? headers,
  }) async {
    try {
      // _dioInstance().options.headers = headers ?? {};
      final response = await _dioInstance().delete(endPoint);
      return response;
    } catch (error) {
      print('Delete error: $error');
      throw Exception('Delete request failed: $error');
    }
  }

  //get requset
  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final dio = _dioInstance();
      // dio.options.headers = headers ?? {};
      final response = await dio.get(
        endPoint,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      print('Post error: $error');
      throw Exception('Post request failed: $error');
    }
  }

  /// PUT request
  static Future<Response> putData({
    required String endPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      _dioInstance().options.headers = headers ?? {};
      final response = await _dioInstance().put(
        endPoint,
        queryParameters: query,
        data: body,
      );
      return response;
    } catch (error) {
      throw Exception('Put request failed: $error');
    }
  }
}
