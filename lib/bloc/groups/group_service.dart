import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/group.dart';
import '../services/dio_service.dart';

class GroupAPI {
  GroupAPI._singleton();

  static final GroupAPI instance = GroupAPI._singleton();

  Future<GroupModel> fetchGroupList() async {
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');

    try {
      Response response = await APIService.instance.request(
        '/users/${userId}/groups/', // Your login endpoint
        DioMethod.get,
      );
      return GroupModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GroupModel.withError("Data not found / check your Connection");
    }
  }

  Future<GroupModel> addGroup(String groupName) async {
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'user_id');

    try {
      Response response = await APIService.instance.request(
        '/users/$userId/groups/',
        DioMethod.post,
        param: {'name': groupName},
      );
      return GroupModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GroupModel.withError(
          "Failed to add group / check your Connection");
    }
  }
}

class NetworkError extends Error {}
