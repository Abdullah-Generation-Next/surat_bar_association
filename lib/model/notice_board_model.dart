import 'dart:convert';


NoticeModel noticeModelFromJson(String str) =>
    NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  List<noticeDatum?> data;
  int flag;
  String message;

  NoticeModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        data: List<noticeDatum?>.from(json["data"].map((x) => noticeDatum.fromJson(x))),
        flag: json["flag"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x?.toJson())),
        "flag": flag,
        "message": message,
      };
}

class noticeDatum {
  String id;
  String userId;
  String designationId;
  String type;
  String title;
  String image;
  String description;
  DateTime startDate;
  DateTime endDate;
  String isActive;
  String isDelete;
  String createdBy;
  String behalfOfId;
  String createdDatetime;
  String updatedBy;
  String updatedDatetime;
  String firstName;
  String lastName;
  String fullName;
  String designationName;

  noticeDatum({
    required this.id,
    required this.userId,
    required this.designationId,
    required this.type,
    required this.title,
    required this.image,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.isDelete,
    required this.createdBy,
    required this.behalfOfId,
    required this.createdDatetime,
    required this.updatedBy,
    required this.updatedDatetime,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.designationName,
  });

  factory noticeDatum.fromJson(Map<String, dynamic> json) => noticeDatum(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        designationId: json["designation_id"].toString(),
        type: json["type"].toString(),
        title: json["title"].toString(),
        image: json["image"].toString(),
        description: json["description"].toString(),
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        isActive: json["is_active"].toString(),
        isDelete: json["is_delete"].toString(),
        createdBy: json["created_by"].toString(),
        behalfOfId: json["behalf_of_id"].toString(),
        createdDatetime: json["created_datetime"].toString(),
        updatedBy: json["updated_by"].toString(),
        updatedDatetime: json["updated_datetime"].toString(),
        firstName: json["first_name"].toString(),
        lastName: json["last_name"].toString(),
        fullName: json["full_name"].toString(),
        designationName: json["designation_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "designation_id": designationId,
        "type": type,
        "title": title,
        "image": image,
        "description": description,
        "start_date":
            "${DateTime(startDate.year).toString().padLeft(4, '0')}-${DateTime(startDate.month).toString().padLeft(2, '0')}-${DateTime(startDate.day).toString().padLeft(2, '0')}",
        "end_date":
            "${DateTime(endDate.year).toString().padLeft(4, '0')}-${DateTime(endDate.month).toString().padLeft(2, '0')}-${DateTime(endDate.day).toString().padLeft(2, '0')}",
        "is_active": isActive,
        "is_delete": isDelete,
        "created_by": createdBy,
        "behalf_of_id": behalfOfId,
        "created_datetime": createdDatetime,
        "updated_by": updatedBy,
        "updated_datetime": updatedDatetime,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "designation_name": designationName,
      };
}
