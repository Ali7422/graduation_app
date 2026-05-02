import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj),
    ));
    
    _dio.options.headers = {
      'X-ListenAPI-Key': ApiConstants.apiKey,
    };
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Please check your API key.');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found.');
      } else {
        throw Exception('Server Error: ${e.response?.statusMessage}');
      }
    } else {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection Timeout: Please check your internet connection.');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    }
  }
}
