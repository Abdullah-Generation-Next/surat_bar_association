import 'dart:convert';

CommitteeModel committeeModelFromJson(String str) => CommitteeModel.fromJson(json.decode(str));

String committeeModelToJson(CommitteeModel data) => json.encode(data.toJson());

class CommitteeModel {
  List<committeeDatum?> data;
  int flag;
  String message;

  CommitteeModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory CommitteeModel.fromJson(Map<String, dynamic> json) => CommitteeModel(
    data: List<committeeDatum?>.from(json["data"].map((x) => committeeDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class committeeDatum {
  String committeeId;
  String committeeOfUserId;
  String committeeName;
  String formationDate;
  // Purpose purpose;
  String purpose;
  String createdDatetime;
  int totalMember;

  committeeDatum({
    required this.committeeId,
    required this.committeeOfUserId,
    required this.committeeName,
    required this.formationDate,
    required this.purpose,
    required this.createdDatetime,
    required this.totalMember,
  });

  factory committeeDatum.fromJson(Map<String, dynamic> json) => committeeDatum(
    committeeId: json["committee_id"],
    committeeOfUserId: json["committee_of_user_id"],
    committeeName: json["committee_name"],
    formationDate: json["formation_date"],
    // purpose: purposeValues.map[json["purpose"]]!,
    purpose: json["purpose"] ?? "",
    createdDatetime: json["created_datetime"],
    totalMember: json["total_member"],
  );

  Map<String, dynamic> toJson() => {
    "committee_id": committeeId,
    "committee_of_user_id": committeeOfUserId,
    "committee_name": committeeName,
    "formation_date": formationDate,
    // "purpose": purposeValues.reverse[purpose],
    "purpose": purpose,
    "created_datetime": createdDatetime,
    "total_member": totalMember,
  };
}

// enum Purpose {
//   EMPTY,
//   P_BR_P
// }
//
// final purposeValues = EnumValues({
//   "": Purpose.EMPTY,
//   "<p><br></p>": Purpose.P_BR_P
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
