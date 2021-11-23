// To parse this JSON data, do
//
//     final shuttleCheckInModel = shuttleCheckInModelFromJson(jsonString);

import 'dart:convert';

ShuttleDetailModel shuttleCheckInModelFromJson(String str) =>
    ShuttleDetailModel.fromJson(json.decode(str));

String shuttleCheckInModelToJson(ShuttleDetailModel data) =>
    json.encode(data.toJson());

class ShuttleDetailModel {
  ShuttleDetailModel({
    required this.id,
    required this.code,
    required this.uuid,
    required this.qrImage,
    required this.capacity,
    required this.quantity,
    required this.start,
    required this.destination,
    required this.departureTime,
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

  factory ShuttleDetailModel.fromJson(Map<String, dynamic> json) =>
      ShuttleDetailModel(
        id: json["id"],
        code: json["code"],
        uuid: json["uuid"],
        qrImage: json["qr_image"],
        capacity: json["capacity"],
        quantity: json["quantity"],
        start: json["start"],
        destination: json["destination"],
        departureTime: json["departure_time"],
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
      };
}
