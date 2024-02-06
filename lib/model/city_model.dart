import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final int status;
  final String message;
  final List<allCity?> cities;

  @override
  String toString() {
    return 'CityModel(status: $status, message: $message, cities: $cities)';
  }

  CityModel({
    required this.status,
    required this.message,
    required this.cities,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    status: json["status"],
    message: json["message"],
    cities: List<allCity?>.from(json["cities"].map((x) => allCity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "cities": List<dynamic>.from(cities.map((x) => x?.toJson())),
  };
}

class allCity {
  final String cityId;
  final String cityName;

  allCity({
    required this.cityId,
    required this.cityName,
  });

  factory allCity.fromJson(Map<String, dynamic> json) => allCity(
    cityId: json["city_id"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "city_name": cityName,
  };
}
