import 'package:dio/dio.dart';
import 'package:sports_app/models/tournament.dart';

import '../services/dio_service.dart';

class TournamentAPI {
  TournamentAPI._singleton();

  // Static instance of the class
  static final TournamentAPI instance = TournamentAPI._singleton();

  Future<Tournament> fetchTournaments() async {
    try {
      Response response = await APIService.instance.request(
        '/tournaments/', // Your login endpoint
        DioMethod.get,
      );
      return Tournament.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Tournament.withError("Data not found / check your Connection");
    }
  }
}

class NetworkError extends Error {}
