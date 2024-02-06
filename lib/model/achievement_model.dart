import 'dart:convert';

AchievementModel achievementModelFromJson(String str) => AchievementModel.fromJson(json.decode(str));

String achievementModelToJson(AchievementModel data) => json.encode(data.toJson());

class AchievementModel {
  final List<achievementDatum?> data;
  final int flag;
  final String message;

  AchievementModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) => AchievementModel(
    data: List<achievementDatum?>.from(json["data"].map((x) => achievementDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class achievementDatum {
  final String id;
  final String monthDigit;
  final String monthText;
  final String year;
  final String detail;
  final String body;
  final String coverImage;

  achievementDatum({
    required this.id,
    required this.monthDigit,
    required this.monthText,
    required this.year,
    required this.detail,
    required this.body,
    required this.coverImage,
  });

  factory achievementDatum.fromJson(Map<String, dynamic> json) => achievementDatum(
    id: json["id"],
    monthDigit: json["month_digit"],
    monthText: json["month_text"],
    year: json["year"],
    detail: json["detail"],
    body: json["body"],
    coverImage: json["cover_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "month_digit": monthDigit,
    "month_text": monthText,
    "year": year,
    "detail": detail,
    "body": body,
    "cover_image": coverImage,
  };
}
