import 'dart:convert';

UserAboutModel userAboutModelFromJson(String str) => UserAboutModel.fromJson(json.decode(str));

String userAboutModelToJson(UserAboutModel data) => json.encode(data.toJson());

class UserAboutModel {
  final List<UserAboutDatum?> data;
  final String fullName;
  final int flag;
  final String message;

  UserAboutModel({
    required this.data,
    required this.fullName,
    required this.flag,
    required this.message,
  });

  factory UserAboutModel.fromJson(Map<String, dynamic> json) => UserAboutModel(
    data: List<UserAboutDatum?>.from(json["data"].map((x) => UserAboutDatum.fromJson(x))),
    fullName: json["fullName"]??"",
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "fullName": fullName,
    "flag": flag,
    "message": message,
  };
}

class UserAboutDatum {
  final int isProfileLock;
  final String userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String isDisplayWeb;
  final String profilePic;
  final String dateOfBirth;
  final String gender;
  final String username;
  final String countryId;
  final String stateId;
  final String cityId;
  final String sanadRegNo;
  final String sanadRegDate;
  final String welfareNo;
  final String welfareDate;
  final String isPhysicalChal;
  final String biodata;
  final String biodataName;
  final String address;
  final String officeAddress;
  final String companyMobile;
  final String aboutUser;
  final String websiteUrl;
  final String bloodGroup;
  final String bloodGroupId;
  final String distCourtRegiNo;
  final String distCourtRegiDate;
  final String qualification;
  final String assoMemberNo;
  final String assoMemberType;
  final String assoMemberDate;
  final String experience;
  final String notaryNo;
  final String deathDate;
  final String isAdvisory;
  final String categoryId;
  final String categoryName;
  final String lawFirmCollege;
  final String firmName;
  final String councilId;
  final String councilName;
  final String associationId;
  final String associationName;

  UserAboutDatum({
    required this.isProfileLock,
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.isDisplayWeb,
    required this.profilePic,
    required this.dateOfBirth,
    required this.gender,
    required this.username,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.sanadRegNo,
    required this.sanadRegDate,
    required this.welfareNo,
    required this.welfareDate,
    required this.isPhysicalChal,
    required this.biodata,
    required this.biodataName,
    required this.address,
    required this.officeAddress,
    required this.companyMobile,
    required this.aboutUser,
    required this.websiteUrl,
    required this.bloodGroup,
    required this.bloodGroupId,
    required this.distCourtRegiNo,
    required this.distCourtRegiDate,
    required this.qualification,
    required this.assoMemberNo,
    required this.assoMemberType,
    required this.assoMemberDate,
    required this.experience,
    required this.notaryNo,
    required this.deathDate,
    required this.isAdvisory,
    required this.categoryId,
    required this.categoryName,
    required this.lawFirmCollege,
    required this.firmName,
    required this.councilId,
    required this.councilName,
    required this.associationId,
    required this.associationName,
  });

  factory UserAboutDatum.fromJson(Map<String, dynamic> json) => UserAboutDatum(
    isProfileLock: json["is_profile_lock"],
    userId: json["user_id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobile: json["mobile"],
    isDisplayWeb: json["is_display_web"],
    profilePic: json["profile_pic"],
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    username: json["username"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    sanadRegNo: json["sanad_reg_no"],
    sanadRegDate: json["sanad_reg_date"],
    welfareNo: json["welfare_no"],
    welfareDate: json["welfare_date"],
    isPhysicalChal: json["is_physical_chal"],
    biodata: json["biodata"],
    biodataName: json["biodata_name"],
    address: json["address"],
    officeAddress: json["office_address"],
    companyMobile: json["company_mobile"],
    aboutUser: json["about_user"],
    websiteUrl: json["website_url"],
    bloodGroup: json["blood_group"].toString(),
    bloodGroupId: json["blood_group_id"].toString(),
    distCourtRegiNo: json["dist_court_regi_no"],
    distCourtRegiDate: json["dist_court_regi_date"],
    qualification: json["qualification"],
    assoMemberNo: json["asso_member_no"],
    assoMemberType: json["asso_member_type"],
    assoMemberDate: json["asso_member_date"],
    experience: json["experience"],
    notaryNo: json["notary_no"],
    deathDate: json["death_date"],
    isAdvisory: json["is_advisory"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    lawFirmCollege: json["law_firm_college"],
    firmName: json["firm_name"],
    councilId: json["council_id"],
    councilName: json["council_name"],
    associationId: json["association_id"],
    associationName: json["association_name"],
  );

  Map<String, dynamic> toJson() => {
    "is_profile_lock": isProfileLock,
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
    "welfare_no": welfareNo,
    "welfare_date": welfareDate,
    "is_physical_chal": isPhysicalChal,
    "biodata": biodata,
    "biodata_name": biodataName,
    "address": address,
    "office_address": officeAddress,
    "company_mobile": companyMobile,
    "about_user": aboutUser,
    "website_url": websiteUrl,
    "blood_group": bloodGroup,
    "blood_group_id": bloodGroupId,
    "dist_court_regi_no": distCourtRegiNo,
    "dist_court_regi_date": distCourtRegiDate,
    "qualification": qualification,
    "asso_member_no": assoMemberNo,
    "asso_member_type": assoMemberType,
    "asso_member_date": assoMemberDate,
    "experience": experience,
    "notary_no": notaryNo,
    "death_date": deathDate,
    "is_advisory": isAdvisory,
    "category_id": categoryId,
    "category_name": categoryName,
    "law_firm_college": lawFirmCollege,
    "firm_name": firmName,
    "council_id": councilId,
    "council_name": councilName,
    "association_id": associationId,
    "association_name": associationName,
  };
}
