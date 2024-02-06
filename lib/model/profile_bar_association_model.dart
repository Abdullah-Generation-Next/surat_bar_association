import 'dart:convert';

ProfileBarAssociationModel profileBarAssociationModelFromJson(String str) => ProfileBarAssociationModel.fromJson(json.decode(str));

String profileBarAssociationModelToJson(ProfileBarAssociationModel data) => json.encode(data.toJson());

class ProfileBarAssociationModel {
  final int flag;
  final String message;
  final List<profileBarAssciationDatum?> data;

  ProfileBarAssociationModel({
    required this.flag,
    required this.message,
    required this.data,
  });

  factory ProfileBarAssociationModel.fromJson(Map<String, dynamic> json) => ProfileBarAssociationModel(
    flag: json["flag"],
    message: json["message"],
    data: List<profileBarAssciationDatum?>.from(json["data"].map((x) => profileBarAssciationDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "flag": flag,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
  };
}

class profileBarAssciationDatum {
  final String barAssociationId;
  final String barAssociationName;

  profileBarAssciationDatum({
    required this.barAssociationId,
    required this.barAssociationName,
  });

  factory profileBarAssciationDatum.fromJson(Map<String, dynamic> json) => profileBarAssciationDatum(
    barAssociationId: json["bar_association_id"],
    barAssociationName: json["bar_association_name"],
  );

  Map<String, dynamic> toJson() => {
    "bar_association_id": barAssociationId,
    "bar_association_name": barAssociationName,
  };
}
