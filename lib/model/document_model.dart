// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
  List<documentDatum>? data;
  int? flag;
  String? message;

  DocumentModel({
    this.data,
    this.flag,
    this.message,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
    data: json["data"] == null ? [] : List<documentDatum>.from(json["data"]!.map((x) => documentDatum.fromJson(x))),
    flag: json["flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "flag": flag,
    "message": message,
  };
}

class documentDatum {
  String? documentId;
  String? documentMasterId;
  String? documentTitle;
  String? documentUploadId;
  String? documentName;
  String? documentUrl;
  String? isDelete;
  String? isPublish;

  documentDatum({
    this.documentId,
    this.documentMasterId,
    this.documentTitle,
    this.documentUploadId,
    this.documentName,
    this.documentUrl,
    this.isDelete,
    this.isPublish,
  });

  factory documentDatum.fromJson(Map<String, dynamic> json) => documentDatum(
    documentId: json["document_id"],
    documentMasterId: json["document_master_id"],
    documentTitle: json["document_title"],
    documentUploadId: json["document_upload_id"],
    documentName: json["document_name"],
    documentUrl: json["document_url"],
    isDelete: json["is_delete"],
    isPublish: json["is_publish"],
  );

  Map<String, dynamic> toJson() => {
    "document_id": documentId,
    "document_master_id": documentMasterId,
    "document_title": documentTitle,
    "document_upload_id": documentUploadId,
    "document_name": documentName,
    "document_url": documentUrl,
    "is_delete": isDelete,
    "is_publish": isPublish,
  };
}
