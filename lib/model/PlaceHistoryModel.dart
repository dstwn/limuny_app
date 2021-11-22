// To parse this JSON data, do
//
//     final placeHistory = placeHistoryFromJson(jsonString);

import 'dart:convert';

PlaceHistory placeHistoryFromJson(String str) =>
    PlaceHistory.fromJson(json.decode(str));

String placeHistoryToJson(PlaceHistory data) => json.encode(data.toJson());

class PlaceHistory {
  PlaceHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory PlaceHistory.fromJson(Map<String, dynamic> json) => PlaceHistory(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.type,
    required this.checkInTime,
    this.checkOutTime,
    required this.user,
  });

  int id;
  String name;
  String type;
  DateTime checkInTime;
  dynamic checkOutTime;
  String user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        checkInTime: DateTime.parse(json["check_in_time"]),
        checkOutTime: json["check_out_time"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "check_in_time": checkInTime.toIso8601String(),
        "check_out_time": checkOutTime,
        "user": user,
      };
}
