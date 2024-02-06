import 'dart:convert';

BlogSubCategoryModel blogSubCategoryModelFromJson(String str) => BlogSubCategoryModel.fromJson(json.decode(str));

String blogSubCategoryModelToJson(BlogSubCategoryModel data) => json.encode(data.toJson());

class BlogSubCategoryModel {
  final List<blogSubCategoryDatum?> data;
  final int flag;
  final String message;

  BlogSubCategoryModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory BlogSubCategoryModel.fromJson(Map<String, dynamic> json) => BlogSubCategoryModel(
    data: List<blogSubCategoryDatum?>.from(json["data"].map((x) => blogSubCategoryDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class blogSubCategoryDatum {
  final String catId;
  final String catName;

  blogSubCategoryDatum({
    required this.catId,
    required this.catName,
  });

  factory blogSubCategoryDatum.fromJson(Map<String, dynamic> json) => blogSubCategoryDatum(
    catId: json["cat_id"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
  };
}
