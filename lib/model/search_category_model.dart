import 'dart:convert';

SearchCategoryModel searchCategoryModelFromJson(String str) => SearchCategoryModel.fromJson(json.decode(str));

String searchCategoryModelToJson(SearchCategoryModel data) => json.encode(data.toJson());

class SearchCategoryModel {
  List<searchCategoryDatum?> data;
  int flag;
  String message;

  SearchCategoryModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory SearchCategoryModel.fromJson(Map<String, dynamic> json) => SearchCategoryModel(
    data: List<searchCategoryDatum?>.from(json["data"].map((x) => searchCategoryDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class searchCategoryDatum {
  String catId;
  String catName;

  searchCategoryDatum({
    required this.catId,
    required this.catName,
  });

  factory searchCategoryDatum.fromJson(Map<String, dynamic> json) => searchCategoryDatum(
    catId: json["cat_id"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
  };
}
