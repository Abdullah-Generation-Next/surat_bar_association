import 'dart:convert';

ProfileCategoryModel profileCategoryModelFromJson(String str) => ProfileCategoryModel.fromJson(json.decode(str));

String profileCategoryModelToJson(ProfileCategoryModel data) => json.encode(data.toJson());

class ProfileCategoryModel {
  final List<profileCategoryDatum?> data;
  final int flag;
  final String message;

  ProfileCategoryModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory ProfileCategoryModel.fromJson(Map<String, dynamic> json) => ProfileCategoryModel(
    data: List<profileCategoryDatum?>.from(json["data"].map((x) => profileCategoryDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class profileCategoryDatum {
  final String catId;
  final String catName;

  profileCategoryDatum({
    required this.catId,
    required this.catName,
  });

  factory profileCategoryDatum.fromJson(Map<String, dynamic> json) => profileCategoryDatum(
    catId: json["cat_id"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
  };
}
