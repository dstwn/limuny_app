import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limuny/bloc/place/place_event.dart';
import 'package:limuny/model/CheckInModel.dart';
import 'package:limuny/model/CheckOutModel.dart';
import 'package:limuny/model/PlaceModel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PlaceProvider {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "http://limuny.infiniteuny.id";

  Future<Place> fecthPlace(String uuid) async {
    String userToken = await storage.read(key: 'token');
    var placeUrl = '$mainUrl/api/checkin/place/$uuid';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(placeUrl);
      print('Place URL :  $placeUrl');
      print("User Token : $userToken");
      print("Data : $response.data");
      return Place.fromJson(response.data['data']);
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return Place(
          1, "name", "uuid", "place_image", "type", "qr_image", 00, 00);
    }
  }

  Future<CheckInModel> checkIn(String uuid) async {
    String userToken = await storage.read(key: 'token');
    var placeUrl = '$mainUrl/api/checkin/place/$uuid';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.post(placeUrl);
      print('Place URL :  $placeUrl');
      print("User Token : $userToken");
      print("Data : $response.data");
      return CheckInModel.fromJson(response.data['data']['place']);
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return CheckInModel(
          0, "name", "uuid", "activity_category", "checkin_date", 0, 0);
    }
  }

  Future<CheckOutModel> checkOut() async {
    String userToken = await storage.read(key: 'token');
    var placeUrl = '$mainUrl/api/checkout/place';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.post(placeUrl);
      print('Place URL :  $placeUrl');
      print("User Token : $userToken");
      print("Data : $response.data");
      return CheckOutModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return CheckOutModel("status", "message", "data");
    }
  }
}
