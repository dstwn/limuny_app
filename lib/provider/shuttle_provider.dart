import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limuny/model/ShuttleHistoryModel.dart';
import 'package:limuny/model/ShuttleModel.dart';

class ShuttleProvider {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "http://limuny.infiniteuny.id";

  Future<List<Bus>> getShuttleFiltered(String start, String destination) async {
    String userToken = await storage.read(key: 'token');
    var shuttleUrl = '$mainUrl/api/buses/search';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio
          .post(shuttleUrl, data: {"start": start, "destination": destination});

      print("Data Response : ${response.data}");
      List<Bus> shuttles = Shuttles.fromJson(response.data).data;
      print("Data object : ${shuttles}");
      return shuttles;
    } catch (error, stacktrace) {
      print("Error : ${error} stacktrace ${stacktrace}");
      return <Bus>[];
    }
  }

  Future<List<BusItem>> getHistoryShuttle() async {
    String userToken = await storage.read(key: 'token');
    var placeUrl = '$mainUrl/api/history/buses';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(placeUrl);
      print('Place URL :  $placeUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      // var data = ;
      List<BusItem> histories = BusModel.fromJson(response.data).data;
      return histories;
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return <BusItem>[];
    }
  }
}
