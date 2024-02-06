import 'dart:convert';

CommitteeDetailModel committeeDetailModelFromJson(String str) => CommitteeDetailModel.fromJson(json.decode(str));

String committeeDetailModelToJson(CommitteeDetailModel data) => json.encode(data.toJson());

class CommitteeDetailModel {
  List<committeeDetailDatum?> data;
  int flag;
  String message;

  CommitteeDetailModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory CommitteeDetailModel.fromJson(Map<String, dynamic> json) => CommitteeDetailModel(
    data: List<committeeDetailDatum?>.from(json["data"].map((x) => committeeDetailDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class committeeDetailDatum {
  String committeeMemberId;
  String committeeId;
  String memberUserId;
  String name;
  String designationId;
  String designationName;
  String status;
  String joiningDate;
  String validityPeriod;
  String discontinueDate;
  String remarks;
  String createdDatetime;

  committeeDetailDatum({
    required this.committeeMemberId,
    required this.committeeId,
    required this.memberUserId,
    required this.name,
    required this.designationId,
    required this.designationName,
    required this.status,
    required this.joiningDate,
    required this.validityPeriod,
    required this.discontinueDate,
    required this.remarks,
    required this.createdDatetime,
  });

  factory committeeDetailDatum.fromJson(Map<String, dynamic> json) => committeeDetailDatum(
    committeeMemberId: json["committee_member_id"] ?? "",
    committeeId: json["committee_id"] ?? "",
    memberUserId: json["member_user_id"] ?? "",
    name: json["name"] ?? "",
    designationId: json["designation_id"] ?? "",
    designationName: json["designation_name"] ?? "",
    status: json["status"] ?? "",
    joiningDate: json["joining_date"] ?? "",
    validityPeriod: json["validity_period"] ?? "",
    discontinueDate: json["discontinue_date"] ?? "",
    remarks: json["remarks"] ?? "",
    // createdDatetime: json["created_datetime"] ?? "",
    createdDatetime: _parseCustomDateFormat(json["created_datetime"] ?? ""),
  );

  Map<String, dynamic> toJson() => {
    "committee_member_id": committeeMemberId,
    "committee_id": committeeId,
    "member_user_id": memberUserId,
    "name": name,
    "designation_id": designationId,
    "designation_name": designationName,
    "status": status,
    "joining_date": joiningDate,
    "validity_period": validityPeriod,
    "discontinue_date": discontinueDate,
    "remarks": remarks,
    "created_datetime": createdDatetime,
  };
}

String _parseCustomDateFormat(String dateString) {
  List<String> parts = dateString.split("/");
  if (parts.length != 3) {
    throw FormatException("Invalid date format: $dateString");
  }

  String isoDate = "${parts[2]}-${parts[1]}-${parts[0]}";

  return isoDate;
}

enum CreatedDatetime {
  THE_28072021
}

final createdDatetimeValues = EnumValues({
  "28/07/2021":CreatedDatetime.THE_28072021
});

enum DesignationName {
  MEMBER
}

final designationNameValues = EnumValues({
  "Member": DesignationName.MEMBER
});

enum DiscontinueDate {
  THE_12312019
}

final discontinueDateValues = EnumValues({
  "12/31/2019": DiscontinueDate.THE_12312019
});

enum JoiningDate {
  THE_01012019
}

final joiningDateValues = EnumValues({
  "01/01/2019": JoiningDate.THE_01012019
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
