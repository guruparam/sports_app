import 'package:dio/dio.dart';
import 'package:sports_app/bloc/services/dio_service.dart';

class UserAPI {
  // Private constructor for the singleton pattern
  UserAPI._singleton();

  // Static instance of the class
  static final UserAPI instance = UserAPI._singleton();

  // Method to login
  Future<Response> login(String email, String password) async {
    return APIService.instance.request(
      '/login/', // Your login endpoint
      DioMethod.post,
      param: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> register(
      String firstname, String lastname, String email, String password) async {
    return APIService.instance.request(
      '/users/', // Your login endpoint
      DioMethod.post,
      param: {
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'password': password,
      },
    );
  }

  // Add other user-specific methods as needed
}
