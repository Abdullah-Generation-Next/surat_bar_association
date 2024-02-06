import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  List<searchDatum?> data;
  int flag;
  String message;

  SearchModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    data: List<searchDatum?>.from(json["data"].map((x) => searchDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class searchDatum {
  String catName;
  dynamic userId;
  String firstName;
  String middleName;
  String lastName;
  String fullName;
  String aboutUser;
  String websiteUrl;
  String address;
  String profilePic;
  String profile;
  String lawFirmCollege;
  String utName;
  String cityName;
  dynamic cityId;
  String shortName;
  String mobile;
  dynamic isDisplayWeb;

  searchDatum({
    required this.catName,
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.aboutUser,
    required this.websiteUrl,
    required this.address,
    required this.profilePic,
    required this.profile,
    required this.lawFirmCollege,
    required this.utName,
    required this.cityName,
    required this.cityId,
    required this.shortName,
    required this.mobile,
    required this.isDisplayWeb,
  });

  factory searchDatum.fromJson(Map<String, dynamic> json) => searchDatum(
    catName: json["cat_name"].toString(),
    // userId: json["user_id"] ?? 0,
    userId: json["user_id"] is int ? json["user_id"] : int.tryParse(json["user_id"].toString()) ?? 0,
    firstName: json["first_name"].toString(),
    middleName: json["middle_name"].toString(),
    lastName: json["last_name"].toString(),
    fullName: json["full_name"].toString(),
    aboutUser: json["about_user"].toString(),
    websiteUrl: json["website_url"].toString(),
    address: json["address"].toString(),
    profilePic: json["profile_pic"].toString(),
    profile: json["profile"].toString(),
    lawFirmCollege: json["law_firm_college"].toString(),
    utName: json["ut_name"].toString(),
    cityName: json["city_name"].toString(),
    cityId: json["city_id"] is int ? json["city_id"] : int.tryParse(json["city_id"].toString()) ?? 0,
    shortName: json["short_name"].toString(),
    mobile: json["mobile"].toString(),
    // isDisplayWeb: json["is_display_web"] ?? 0,
    isDisplayWeb: json["is_display_web"] is int ? json["is_display_web"] : int.tryParse(json["is_display_web"].toString()) ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "cat_name": catName,
    "user_id": userId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "full_name": fullName,
    "about_user": aboutUser,
    "website_url": websiteUrl,
    "address": address,
    "profile_pic": profilePic,
    "profile": profile,
    "law_firm_college": lawFirmCollege,
    "ut_name": utName,
    "city_name": cityName,
    "city_id": cityId,
    "short_name": shortName,
    "mobile": mobile,
    "is_display_web": isDisplayWeb,
  };
}
