import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sports_app/utils/urls.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._(); // Private constructor for singleton pattern

  static final APIService instance = APIService._(); // Singleton instance

  String get baseUrl => Urls.appUrl;

  Future<Response<dynamic>> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    formData,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.jsonContentType,
      ),
    );

    try {
      if (!Uri.parse(endpoint).hasAbsolutePath) {
        throw Exception('Invalid API endpoint URL');
      }

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      if (token != null && method == DioMethod.get) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      switch (method) {
        case DioMethod.post:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.get:
          return dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          return dio.put(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.delete:
          return dio.delete(
            endpoint,
            data: param ?? formData,
          );
        default:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
