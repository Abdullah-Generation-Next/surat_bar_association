import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  int? flag;
  String? message;
  bool? isMailSent;

  ForgotPasswordModel({
    required this.flag,
    required this.message,
    this.isMailSent,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    flag: json["flag"],
    message: json["message"],
    isMailSent: json["is_mail_sent"],
  );

  Map<String, dynamic> toJson() => {
    "flag": flag,
    "message": message,
    "is_mail_sent": isMailSent,
  };
}
