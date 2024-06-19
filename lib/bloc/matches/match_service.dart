import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/active_matches.dart';
import '../services/dio_service.dart';

class MatchAPI {
  MatchAPI._singleton();

  // Static instance of the class
  static final MatchAPI instance = MatchAPI._singleton();

  Future<ActiveMatches> fetchMatchList() async {
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');

    try {
      Response response = await APIService.instance.request(
        '/users/$userId/matches/', // Your login endpoint
        DioMethod.get,
      );
      return ActiveMatches.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ActiveMatches.withError("Data not found / check your Connection");
    }
  }
}

class NetworkError extends Error {}
