import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
}
