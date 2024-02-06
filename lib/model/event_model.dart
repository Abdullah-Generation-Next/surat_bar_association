import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  List<eventDatum?> data;
  int flag;
  String message;

  EventModel({
    required this.data,
    required this.flag,
    required this.message,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        data: List<eventDatum?>.from(json["data"].map((x) => eventDatum.fromJson(x))),
        flag: json["flag"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x?.toJson())),
        "flag": flag,
        "message": message,
      };
}

class eventDatum {
  String eventId;
  String userId;
  String eventTitle;
  String description;
  String fromDate;
  String toDate;
  String imageUrl;
  String fromTime;
  String toTime;
  String registrationRequired;
  String registrationFees;
  String location;
  String contactNumber;
  String eventTypeId;
  String eventTypeTitle;
  String createdBy;
  String totalParticipant;
  String isAttended;

  eventDatum({
    required this.eventId,
    required this.userId,
    required this.eventTitle,
    required this.description,
    required this.fromDate,
    required this.toDate,
    required this.imageUrl,
    required this.fromTime,
    required this.toTime,
    required this.registrationRequired,
    required this.registrationFees,
    required this.location,
    required this.contactNumber,
    required this.eventTypeId,
    required this.eventTypeTitle,
    required this.createdBy,
    required this.totalParticipant,
    required this.isAttended,
  });

  factory eventDatum.fromJson(Map<String, dynamic> json) => eventDatum(
        eventId: json["event_id"].toString(),
        userId: json["user_id"].toString(),
        eventTitle: json["event_title"].toString(),
        description: json["description"].toString(),
        fromDate: json["from_date"].toString(),
        toDate: json["to_date"].toString(),
        imageUrl: json["image_url"].toString(),
        fromTime: json["from_time"].toString(),
        toTime: json["to_time"].toString(),
        registrationRequired: json["registration_required"].toString(),
        registrationFees: json["registration_fees"].toString(),
        location: json["location"].toString(),
        contactNumber: json["contact_number"].toString(),
        eventTypeId: json["event_type_id"].toString(),
        eventTypeTitle: json["event_type_title"].toString(),
        createdBy: json["created_by"].toString(),
        totalParticipant: json["total_participant"].toString(),
        isAttended: json["is_attended"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "user_id": userId,
        "event_title": eventTitle,
        "description": description,
        "from_date": fromDate,
        "to_date": toDate,
        "image_url": imageUrl,
        "from_time": fromTime,
        "to_time": toTime,
        "registration_required": registrationRequired,
        "registration_fees": registrationFees,
        "location": location,
        "contact_number": contactNumber,
        "event_type_id": eventTypeId,
        "event_type_title": eventTypeTitle,
        "created_by": createdBy,
        "total_participant": totalParticipant,
        "is_attended": isAttended,
      };
}

// getdata(){
//   return message!.isNotEmpty ? message : "vfsvef";
// }
