import 'dart:convert';

SearchSubCategoryModel searchSubCategoryModelFromJson(String str) => SearchSubCategoryModel.fromJson(json.decode(str));

String searchSubCategoryModelToJson(SearchSubCategoryModel data) => json.encode(data.toJson());

class SearchSubCategoryModel {
  List<searchSubCategoryDatum?> data;
  int flag;
  String message;

  SearchSubCategoryModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory SearchSubCategoryModel.fromJson(Map<String, dynamic> json) => SearchSubCategoryModel(
    data: List<searchSubCategoryDatum?>.from(json["data"].map((x) => searchSubCategoryDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class searchSubCategoryDatum {
  String catId;
  String catName;

  searchSubCategoryDatum({
    required this.catId,
    required this.catName,
  });

  factory searchSubCategoryDatum.fromJson(Map<String, dynamic> json) => searchSubCategoryDatum(
    catId: json["cat_id"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
  };
}
