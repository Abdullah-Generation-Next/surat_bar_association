import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  List<blogDatum> data;
  int flag;
  String message;

  BlogModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    data: List<blogDatum>.from(json["data"].map((x) => blogDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "flag": flag,
    "message": message,
  };
}

class blogDatum {
  String blogId;
  String userId;
  String title;
  String categoryId;
  String subCategoryId;
  String catName;
  String subCatName;
  String imageUrl;
  String description;
  String authorName;
  String blogDate;
  String isDelete;
  int totalComment;
  int totalLike;
  int totalDislike;
  int islikeDislike;

  blogDatum({
    required this.blogId,
    required this.userId,
    required this.title,
    required this.categoryId,
    required this.subCategoryId,
    required this.catName,
    required this.subCatName,
    required this.imageUrl,
    required this.description,
    required this.authorName,
    required this.blogDate,
    required this.isDelete,
    required this.totalComment,
    required this.totalLike,
    required this.totalDislike,
    required this.islikeDislike,
  });

  factory blogDatum.fromJson(Map<String, dynamic> json) => blogDatum(
    blogId: json["blog_id"].toString(),
    userId: json["user_id"].toString(),
    title: json["title"].toString(),
    categoryId: json["category_id"].toString(),
    subCategoryId: json["sub_category_id"].toString(),
    catName: json["cat_name"].toString(),
    subCatName: json["sub_cat_name"].toString(),
    imageUrl: json["image_url"].toString(),
    description: json["description"].toString(),
    authorName: json["author_name"].toString(),
    blogDate: json["blog_date"].toString(),
    isDelete: json["is_delete"].toString(),
    totalComment: json["total_comment"],
    totalLike: json["total_like"],
    totalDislike: json["total_dislike"],
    islikeDislike: json["islike/dislike"],
  );

  Map<String, dynamic> toJson() => {
    "blog_id": blogId,
    "user_id": userId,
    "title": title,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "cat_name": catName,
    "sub_cat_name": subCatName,
    "image_url": imageUrl,
    "description": description,
    "author_name": authorName,
    "blog_date": blogDate,
    "is_delete": isDelete,
    "total_comment": totalComment,
    "total_like": totalLike,
    "total_dislike": totalDislike,
    "islike/dislike": islikeDislike,
  };
}
