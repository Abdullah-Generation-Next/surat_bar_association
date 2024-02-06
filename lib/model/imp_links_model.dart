import 'dart:convert';

ImpLinksModel impLinksModelFromJson(String str) => ImpLinksModel.fromJson(json.decode(str));

String impLinksModelToJson(ImpLinksModel data) => json.encode(data.toJson());

class ImpLinksModel {
  List<linkDatum?> data;
  int flag;
  String message;

  ImpLinksModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory ImpLinksModel.fromJson(Map<String, dynamic> json) => ImpLinksModel(
    data: List<linkDatum?>.from(json["data"].map((x) => linkDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x?.toJson())),
    "flag": flag,
    "message": message,
  };
}

class linkDatum {
  String linkId;
  String linkName;
  String htmlLink;

  linkDatum({
    required this.linkId,
    required this.linkName,
    required this.htmlLink,
  });

  factory linkDatum.fromJson(Map<String, dynamic> json) => linkDatum(
    linkId: json["link_id"],
    linkName: json["link_name"].toString(),
    htmlLink: json["html_link"],
  );

  Map<String, dynamic> toJson() => {
    "link_id": linkId,
    "link_name": linkName,
    "html_link": htmlLink,
  };
}
