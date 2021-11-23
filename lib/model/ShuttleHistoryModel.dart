// To parse this JSON data, do
//
//     final busModel = busModelFromJson(jsonString);

import 'dart:convert';

BusModel busModelFromJson(String str) => BusModel.fromJson(json.decode(str));

String busModelToJson(BusModel data) => json.encode(data.toJson());

class BusModel {
  BusModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<BusItem> data;

  factory BusModel.fromJson(Map<String, dynamic> json) => BusModel(
        status: json["status"],
        message: json["message"],
        data: List<BusItem>.from(json["data"].map((x) => BusItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BusItem {
  BusItem({
    required this.id,
    required this.code,
    required this.start,
    required this.destination,
    this.departureTime,
    required this.checkInTime,
    this.checkOutTime,
    required this.user,
  });

  int id;
  String code;
  String start;
  String destination;
  dynamic departureTime;
  DateTime checkInTime;
  dynamic checkOutTime;
  String user;

  factory BusItem.fromJson(Map<String, dynamic> json) => BusItem(
        id: json["id"],
        code: json["code"],
        start: json["start"],
        destination: json["destination"],
        departureTime: json["departure_time"],
        checkInTime: DateTime.parse(json["check_in_time"]),
        checkOutTime: json["check_out_time"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "start": start,
        "destination": destination,
        "departure_time": departureTime,
        "check_in_time": checkInTime.toIso8601String(),
        "check_out_time": checkOutTime,
        "user": user,
      };
}
