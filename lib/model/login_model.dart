import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? success;
  String? message;
  String? paymentStatus;
  var flag;
  String? userId;
  String? fullName;
  String? fname;
  String? mname;
  String? lname;
  String? mobile;
  String? email;
  String? userTypeId;
  String? userMasterId;
  dynamic userTypeName;
  dynamic countryId;
  dynamic cityId;
  dynamic cityName;
  String? profilePic;
  String? parentId;
  String? bGroup;
  String? firmName;

  LoginModel({
    this.success,
    this.message,
    this.paymentStatus,
    this.flag,
    this.userId,
    this.fullName,
    this.fname,
    this.mname,
    this.lname,
    this.mobile,
    this.email,
    this.userTypeId,
    this.userMasterId,
    this.userTypeName,
    this.countryId,
    this.cityId,
    this.cityName,
    this.profilePic,
    this.parentId,
    this.bGroup,
    this.firmName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    paymentStatus: json["payment_status"],
    flag: json["flag"],
    userId: json["userId"],
    fullName: json["fullName"],
    fname: json["fname"],
    mname: json["mname"],
    lname: json["lname"],
    mobile: json["mobile"],
    email: json["email"],
    userTypeId: json["userTypeId"],
    userMasterId: json["userMasterId"],
    userTypeName: json["userTypeName"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    profilePic: json["profile_pic"],
    parentId: json["parent_id"],
    bGroup: json["b_group"],
    firmName: json["firm_name"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "payment_status": paymentStatus,
    "flag": flag,
    "userId": userId,
    "fullName": fullName,
    "fname": fname,
    "mname": mname,
    "lname": lname,
    "mobile": mobile,
    "email": email,
    "userTypeId": userTypeId,
    "userMasterId": userMasterId,
    "userTypeName": userTypeName,
    "country_id": countryId,
    "city_id": cityId,
    "city_name": cityName,
    "profile_pic": profilePic,
    "parent_id": parentId,
    "b_group": bGroup,
    "firm_name": firmName,
  };
}
