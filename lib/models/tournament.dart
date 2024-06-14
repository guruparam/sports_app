class Tournament {
  bool? success;
  String? message;
  List<Data>? data;
  List<Data>? activeTournaments;
  List<Data>? upcomingTournaments;
  String? error;

  Tournament({
    this.success,
    this.message,
    this.data,
    this.activeTournaments,
    this.upcomingTournaments,
    this.error,
  });

  Tournament.withError(String errorMessage) {
    error = errorMessage;
  }

  factory Tournament.fromJson(Map<String, dynamic> json) {
    List<Data> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }

    return Tournament(
      success: json['success'],
      message: json['message'],
      data: data,
      activeTournaments: data.where((d) => d.state == 'active').toList(),
      upcomingTournaments: data.where((d) => d.state == 'upcoming').toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? sport;
  String? startDate;
  String? endDate;
  bool? isGroupParticipated;
  String? state;
  UserDetails? userDetails;

  Data({
    this.id,
    this.name,
    this.sport,
    this.startDate,
    this.endDate,
    this.isGroupParticipated,
    this.state,
    this.userDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      sport: json['sport'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      isGroupParticipated: json['is_group_participated'],
      state: json['state'],
      userDetails: json['user_details'] != null
          ? UserDetails.fromJson(json['user_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['sport'] = sport;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['is_group_participated'] = isGroupParticipated;
    data['state'] = state;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  bool? isParticipated;
  int? userPoints;
  int? userCoins;

  UserDetails({this.isParticipated, this.userPoints, this.userCoins});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      isParticipated: json['is_participated'],
      userPoints: json['user_points'],
      userCoins: json['user_coins'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['is_participated'] = isParticipated;
    data['user_points'] = userPoints;
    data['user_coins'] = userCoins;
    return data;
  }
}
