import 'dart:convert';

ContactAdminModel contactAdminModelFromJson(String str) => ContactAdminModel.fromJson(json.decode(str));

String contactAdminModelToJson(ContactAdminModel data) => json.encode(data.toJson());

class ContactAdminModel {
  final int flag;
  final String message;

  ContactAdminModel({
    required this.flag,
    required this.message,
  });

  factory ContactAdminModel.fromJson(Map<String, dynamic> json) => ContactAdminModel(
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "flag": flag,
    "message": message,
  };
}
