// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sports_app/utils/urls.dart';

// Enum to represent different HTTP methods
enum DioMethod { post, get, put, delete }

class APIService {
  // Private constructor for the singleton pattern
  APIService._singleton();

  // Static instance of the class
  static final APIService instance = APIService._singleton();

  // Getter for the base URL based on the environment (debug or production)
  String baseUrl = Urls.APP_URL;

  // Method to make HTTP requests
  Future<Response> request(
    String endpoint, // Endpoint to which the request will be made
    DioMethod method, // HTTP method (post, get, put, delete)
    {
    Map<String, dynamic>?
        param, // Parameters for the request (query params or request body)
    String? contentType, // Content type for the request
    formData,
    // Map<String, String> headers, // Form data for the request
  }) async {
    // Create an instance of Dio with the base URL
    // const storage = FlutterSecureStorage();
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.jsonContentType,
      ),
    );

    if (method == DioMethod.get) {
      // Add token to the headers only for GET requests
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        // Token not found, refresh the token or throw an exception
        throw Exception('Token not found');
      }
    }
    try {
      // Validate the API endpoint URL
      if (!Uri.parse(endpoint).hasAbsolutePath) {
        throw Exception('Invalid API endpoint URL');
      }

      // Switch statement based on the HTTP method
      switch (method) {
        case DioMethod.post:
          // Make a POST request
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.get:
          // Make a GET request
          return dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          // Make a PUT request
          return dio.put(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.delete:
          // Make a DELETE request
          return dio.delete(
            endpoint,
            data: param ?? formData,
          );
        default:
          // If the method is not recognized, make a default POST request
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
      }
    } catch (e) {
      // Log the error for debugging purposes
      print('Error: $e');
      rethrow; // Rethrow the original exception
    }
  }
}
