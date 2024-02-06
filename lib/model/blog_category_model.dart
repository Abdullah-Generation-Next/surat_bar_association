import 'dart:convert';

BlogCategoryModel blogCategoryModelFromJson(String str) => BlogCategoryModel.fromJson(json.decode(str));

String blogCategoryModelToJson(BlogCategoryModel data) => json.encode(data.toJson());

class BlogCategoryModel {
  List<blogCategoryDatum?> data;
  int flag;
  String message;

  BlogCategoryModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) => BlogCategoryModel(
    data: List<blogCategoryDatum?>.from(json["data"].map((x) => blogCategoryDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class blogCategoryDatum {
  String catId;
  String catName;

  blogCategoryDatum({
    required this.catId,
    required this.catName,
  });

  factory blogCategoryDatum.fromJson(Map<String, dynamic> json) => blogCategoryDatum(
    catId: json["cat_id"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
  };
}
