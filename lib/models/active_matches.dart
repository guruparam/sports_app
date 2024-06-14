class ActiveMatches {
  bool? success;
  String? message;
  List<Data>? data;
  String? error;

  ActiveMatches({this.success, this.message, this.data});

  ActiveMatches.withError(String errorMessage) {
    error = errorMessage;
  }

  ActiveMatches.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? venue;
  String? sportId;
  String? tournament;
  String? startDate;
  String? startTime;
  String? city;
  String? result;
  MatchDetails? matchDetails;
  bool? isUserPlayed;
  bool? isTimeOut;

  Data(
      {this.id,
      this.venue,
      this.sportId,
      this.tournament,
      this.startDate,
      this.startTime,
      this.city,
      this.result,
      this.matchDetails,
      this.isUserPlayed,
      this.isTimeOut});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venue = json['venue'];
    sportId = json['sport_id'];
    tournament = json['tournament'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    city = json['city'];
    result = json['result'];
    matchDetails = json['match_details'] != null
        ? MatchDetails.fromJson(json['match_details'])
        : null;
    isUserPlayed = json['is_user_played'];
    isTimeOut = json['is_time_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['venue'] = venue;
    data['sport_id'] = sportId;
    data['tournament'] = tournament;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['city'] = city;
    data['result'] = result;
    if (matchDetails != null) {
      data['match_details'] = matchDetails!.toJson();
    }
    data['is_user_played'] = isUserPlayed;
    data['is_time_out'] = isTimeOut;
    return data;
  }
}

class MatchDetails {
  String? matchTypeName;
  String? team1;
  String? team2;
  String? team1_logo;
  String? team2_logo;
  String? shortNameTeam1;
  String? shortNameTeam2;
  String? toss;
  String? pom;

  MatchDetails(
      {this.matchTypeName,
      this.team1,
      this.team2,
      this.team1_logo,
      this.team2_logo,
      this.shortNameTeam1,
      this.shortNameTeam2,
      this.toss,
      this.pom});

  MatchDetails.fromJson(Map<String, dynamic> json) {
    matchTypeName = json['match_type_name'];
    team1 = json['team1'];
    team2 = json['team2'];
    team1_logo = json['team1_logo'];
    team2_logo = json['team2_logo'];
    shortNameTeam1 = json['short_name_team1'];
    shortNameTeam2 = json['short_name_team2'];
    toss = json['toss'];
    pom = json['pom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['match_type_name'] = matchTypeName;
    data['team1'] = team1;
    data['team2'] = team2;
    data['team1_logo'] = team1_logo;
    data['team2_logo'] = team2_logo;
    data['short_name_team1'] = shortNameTeam1;
    data['short_name_team2'] = shortNameTeam2;
    data['toss'] = toss;
    data['pom'] = pom;
    return data;
  }
}
