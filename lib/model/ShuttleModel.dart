// To parse this JSON data, do
//
//     final shuttles = shuttlesFromJson(jsonString);

import 'dart:convert';

Shuttles shuttlesFromJson(String str) => Shuttles.fromJson(json.decode(str));

String shuttlesToJson(Shuttles data) => json.encode(data.toJson());

class Shuttles {
  Shuttles({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Bus> data;

  factory Shuttles.fromJson(Map<String, dynamic> json) => Shuttles(
        status: json["status"],
        message: json["message"],
        data: List<Bus>.from(json["data"].map((x) => Bus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bus {
  Bus({
    required this.id,
    required this.code,
    required this.uuid,
    required this.qrImage,
    required this.capacity,
    required this.quantity,
    required this.start,
    required this.destination,
    required this.departureTime,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String code;
  String uuid;
  String qrImage;
  int capacity;
  int quantity;
  String start;
  String destination;
  String departureTime;
  DateTime createdAt;
  DateTime updatedAt;

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        code: json["code"],
        uuid: json["uuid"],
        qrImage: json["qr_image"],
        capacity: json["capacity"],
        quantity: json["quantity"],
        start: json["start"],
        destination: json["destination"],
        departureTime: json["departure_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "uuid": uuid,
        "qr_image": qrImage,
        "capacity": capacity,
        "quantity": quantity,
        "start": start,
        "destination": destination,
        "departure_time": departureTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
