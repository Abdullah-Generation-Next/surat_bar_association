import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final List<userDatum?>? data;
  final String? fullName;
  final int? flag;
  final String? message;

  UserModel({
    this.data,
    this.fullName,
    this.flag,
    this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: List<userDatum?>.from(json["data"].map((x) => userDatum.fromJson(x))),
    fullName: json["fullName"] == null ? "" : json["fullName"],
    flag: json["flag"] == null ? 0 : json["flag"],
    message: json["message"] == null ? "" : json["message"],
  );



  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x?.toJson())),
    "fullName": fullName,
    "flag": flag,
    "message": message,
  };
}

class userDatum {
  final String? userId;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? isDisplayWeb;
  final String? profilePic;
  final String? dateOfBirth;
  final String? gender;
  final String? username;
  final String? countryId;
  final String? stateId;
  final String? cityId;
  final String? sanadRegNo;
  final String? sanadRegDate;
  final String? biodata;
  final String? biodataName;
  final String? address;
  final String? officeAddress;
  final String? officeMobile;
  final String? aboutUser;
  final String? websiteUrl;
  final String? isAdvisory;
  final String? catId;
  final String? catName;
  final String? lawFirmCollege;
  final String? firmName;
  final String? utName;
  final String? welfareNo;
  final String? welfareDate;
  String? bloodGroup;
  final dynamic bloodGroupId;
  final String? distCourtRegiNo;
  final String? qualification;
  final String? distCourtRegiDate;
  final String? assoMemberNo;
  final String? assoMemberType;
  final String? assoMemberDate;
  final String? experience;
  final String? notaryNo;
  final String? deathDate;

  userDatum({
    this.userId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.mobile,
    this.isDisplayWeb,
    this.profilePic,
    this.dateOfBirth,
    this.gender,
    this.username,
    this.countryId,
    this.stateId,
    this.cityId,
    this.sanadRegNo,
    this.sanadRegDate,
    this.biodata,
    this.biodataName,
    this.address,
    this.officeAddress,
    this.officeMobile,
    this.aboutUser,
    this.websiteUrl,
    this.isAdvisory,
    this.catId,
    this.catName,
    this.lawFirmCollege,
    this.firmName,
    this.utName,
    this.welfareNo,
    this.welfareDate,
    this.bloodGroup,
    this.bloodGroupId,
    this.distCourtRegiNo,
    this.qualification,
    this.distCourtRegiDate,
    this.assoMemberNo,
    this.assoMemberType,
    this.assoMemberDate,
    this.experience,
    this.notaryNo,
    this.deathDate,
  });

  factory userDatum.fromJson(Map<String, dynamic> json) => userDatum(
    userId: json["user_id"] == null ? "" : json["user_id"],
    firstName: json["first_name"] == null ? "" : json["first_name"],
    middleName: json["middle_name"] == null ? "" : json["middle_name"],
    lastName: json["last_name"] == null ? "" : json["last_name"],
    email: json["email"] == null ? "" : json["email"],
    mobile: json["mobile"] == null ? "" : json["mobile"],
    isDisplayWeb: json["is_display_web"] == null ? "" : json["is_display_web"],
    profilePic: json["profile_pic"] == null ? "" : json["profile_pic"],
    dateOfBirth: json["date_of_birth"] == null ? "" : json["date_of_birth"],
    gender: json["gender"] == null ? "" : json["gender"],
    username: json["username"] == null ? "" : json["username"],
    countryId: json["country_id"] == null ? "" : json["country_id"],
    stateId: json["state_id"] == null ? "" : json["state_id"],
    cityId: json["city_id"] == null ? "" : json["city_id"],
    sanadRegNo: json["sanad_reg_no"] == null ? "" : json["sanad_reg_no"],
    sanadRegDate: json["sanad_reg_date"] == null ? "" : json["sanad_reg_date"],
    biodata: json["biodata"] == null ? "" : json["biodata"],
    biodataName: json["biodata_name"] == null ? "" : json["biodata_name"],
    address: json["address"] == null ? "" : json["address"],
    officeAddress: json["office_address"] == null ? "" : json["office_address"],
    officeMobile: json["office_mobile"] == null ? "" : json["office_mobile"],
    aboutUser: json["about_user"] == null ? "" : json["about_user"],
    websiteUrl: json["website_url"] == null ? "" : json["website_url"],
    isAdvisory: json["is_advisory"] == null ? "" : json["is_advisory"],
    catId: json["cat_id"] == null ? "" : json["cat_id"],
    catName: json["cat_name"] == null ? "" : json["cat_name"],
    lawFirmCollege: json["law_firm_college"] == null ? "" : json["law_firm_college"],
    firmName: json["firm_name"] == null ? "" : json["firm_name"],
    utName: json["ut_name"] == null ? "" : json["ut_name"],
    welfareNo: json["welfare_no"] == null ? "" : json["welfare_no"],
    welfareDate: json["welfare_date"] == null ? "" : json["welfare_date"],
    bloodGroup: json["blood_group"] == null ? "" : json["blood_group"],
    bloodGroupId: json["blood_group_id"] == null ? 0 : json["blood_group_id"],
    distCourtRegiNo: json["dist_court_regi_no"] == null ? "" : json["dist_court_regi_no"],
    qualification: json["qualification"] == null ? "" : json["qualification"],
    distCourtRegiDate: json["dist_court_regi_date"] == null ? "" : json["dist_court_regi_date"],
    assoMemberNo: json["asso_member_no"] == null ? "" : json["asso_member_no"],
    assoMemberType: json["asso_member_type"] == null ? "" : json["asso_member_type"],
    assoMemberDate: json["asso_member_date"] == null ? "" : json["asso_member_date"],
    experience: json["experience"] == null ? "" : json["experience"],
    notaryNo: json["notary_no"] == null ? "" : json["notary_no"],
    deathDate: json["death_date"] == null ? "" : json["death_date"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
    "is_display_web": isDisplayWeb,
    "profile_pic": profilePic,
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "username": username,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "sanad_reg_no": sanadRegNo,
    "sanad_reg_date": sanadRegDate,
    "biodata": biodata,
    "biodata_name": biodataName,
    "address": address,
    "office_address": officeAddress,
    "office_mobile": officeMobile,
    "about_user": aboutUser,
    "website_url": websiteUrl,
    "is_advisory": isAdvisory,
    "cat_id": catId,
    "cat_name": catName,
    "law_firm_college": lawFirmCollege,
    "firm_name": firmName,
    "ut_name": utName,
    "welfare_no": welfareNo,
    "welfare_date": welfareDate,
    "blood_group": bloodGroup,
    "blood_group_id": bloodGroupId,
    "dist_court_regi_no": distCourtRegiNo,
    "qualification": qualification,
    "dist_court_regi_date": distCourtRegiDate,
    "asso_member_no": assoMemberNo,
    "asso_member_type": assoMemberType,
    "asso_member_date": assoMemberDate,
    "experience": experience,
    "notary_no": notaryNo,
    "death_date": deathDate,
  };
}
