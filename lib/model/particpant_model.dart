import 'dart:convert';

ParticipantModel participantModelFromJson(String str) => ParticipantModel.fromJson(json.decode(str));

String participantModelToJson(ParticipantModel data) => json.encode(data.toJson());

class ParticipantModel {
  final List<participantDatum?> data;
  final int flag;
  final String message;

  ParticipantModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) => ParticipantModel(
    data: List<participantDatum?>.from(json["data"].map((x) => participantDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class participantDatum {
  final String id;
  final String month;
  final String monthDigit;
  final String year;
  final String detail;
  final String body;
  final String coverImage;

  participantDatum({
    required this.id,
    required this.month,
    required this.monthDigit,
    required this.year,
    required this.detail,
    required this.body,
    required this.coverImage,
  });

  factory participantDatum.fromJson(Map<String, dynamic> json) => participantDatum(
    id: json["id"],
    month: json["month"],
    monthDigit: json["month_digit"],
    year: json["year"],
    detail: json["detail"],
    body: json["body"],
    coverImage: json["cover_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "month": month,
    "month_digit": monthDigit,
    "year": year,
    "detail": detail,
    "body": body,
    "cover_image": coverImage,
  };
}
