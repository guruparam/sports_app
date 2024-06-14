class GroupModel {
  bool? success;
  String? message;
  List<Group>? data;
  String? error;

  GroupModel({this.success, this.message, this.data});

  GroupModel.withError(String errorMessage) {
    error = errorMessage;
  }

  GroupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Group>[];
      json['data'].forEach((v) {
        data!.add(Group.fromJson(v));
      });
    }
  }
}

class Group {
  String? id;
  String? name;
  String? description;
  int? members;

  Group({this.id, this.name, this.description, this.members});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    members = json['members'];
  }
}
