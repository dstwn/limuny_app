import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limuny/model/ShuttleModel.dart';

class ShuttleProvider {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "http://limuny.infiniteuny.id";

  Future<List<Bus>> getShuttle(String start, String destination) async {
    String userToken = await storage.read(key: 'token');
    var shuttleUrl = '$mainUrl/api/buses/search';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio
          .post(shuttleUrl, data: {"start": start, "destination": destination});
      List<Bus> shuttles = Shuttles.fromJson(response.data).data;
      return shuttles;
    } catch (error, stacktrace) {
      print("Error : ${error} stacktrace ${stacktrace}");
      return <Bus>[];
    }
  }
}
