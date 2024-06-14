class Profiles {
  bool? success;
  String? message;
  Data? data;
  String? error;

  Profiles({this.success, this.message, this.data});

  Profiles.withError(String errorMessage) {
    error = errorMessage;
  }
  Profiles.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  Null? phoneNumber;
  bool? isActive;
  Null? country;
  bool? isMember;

  Data(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.isActive,
      this.country,
      this.isMember});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    isActive = json['is_active'];
    country = json['country'];
    isMember = json['is_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    data['country'] = this.country;
    data['is_member'] = this.isMember;
    return data;
  }
}
