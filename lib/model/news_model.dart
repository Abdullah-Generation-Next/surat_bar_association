import 'dart:convert';

LegalNewsModel legalNewsModelFromJson(String str) => LegalNewsModel.fromJson(json.decode(str));

String legalNewsModelToJson(LegalNewsModel data) => json.encode(data.toJson());

class LegalNewsModel {
  List<dynamic> listRecords;
  List<newsDatum?> data;
  int totalRecords;
  int flag;
  String message;

  LegalNewsModel({
    required this.listRecords,
    required this.data,
    required this.totalRecords,
    required this.flag,
    required this.message,
  });

  factory LegalNewsModel.fromJson(Map<String, dynamic> json) => LegalNewsModel(
    listRecords: List<dynamic>.from(json["list_records"].map((x) => x)),
    data: List<newsDatum>.from(json["data"].map((x) => newsDatum.fromJson(x))),
    totalRecords: json["total_records"],
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "list_records": List<dynamic>.from(listRecords.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "total_records": totalRecords,
    "flag": flag,
    "message": message,
  };
}

class newsDatum {
  String id;
  String title;
  String link;
  String sortDesc;
  String photo;
  String photoUrl;
  String userId;
  String createdAt;
  String isActive;
  String isDelete;
  String createdBy;
  String updatedBy;
  String updatedAt;
  String firstName;
  String lastName;

  newsDatum({
    required this.id,
    required this.title,
    required this.link,
    required this.sortDesc,
    required this.photo,
    required this.photoUrl,
    required this.userId,
    required this.createdAt,
    required this.isActive,
    required this.isDelete,
    required this.createdBy,
    required this.updatedBy,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
  });

  factory newsDatum.fromJson(Map<String, dynamic> json) => newsDatum(
    id: json["id"].toString(),
    title: json["title"].toString(),
    link: json["link"].toString(),
    sortDesc: json["sort_desc"].toString(),
    photo: json["photo"].toString(),
    photoUrl: json["photo_url"].toString(),
    userId: json["user_id"].toString(),
    createdAt: json["created_at"].toString(),
    isActive: json["is_active"].toString(),
    isDelete: json["is_delete"].toString(),
    createdBy: json["created_by"].toString(),
    updatedBy: json["updated_by"].toString(),
    updatedAt: json["updated_at"].toString(),
    firstName: json["first_name"].toString(),
    lastName: json["last_name"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "sort_desc": sortDesc,
    "photo": photo,
    "photo_url": photoUrl,
    "user_id": userId,
    "created_at": createdAt,
    "is_active": isActive,
    "is_delete": isDelete,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "updated_at": updatedAt,
    "first_name": firstName,
    "last_name": lastName,
  };
}
