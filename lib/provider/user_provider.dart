import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limuny/model/PlaceHistoryModel.dart';
import 'package:limuny/model/UserModel.dart';
import 'package:limuny/model/UserStatusModel.dart';

class UserProvider {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "http://limuny.infiniteuny.id";
  var profileUrl = '$mainUrl/api/profile';

  Future<String?> getUserToken() async {
    String token = await storage.read(key: 'token');
    return token;
  }

  Future<User> fetchUser() async {
    String userToken = await storage.read(key: 'token');
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(profileUrl);
      return User.fromJson(response.data['data']);
    } catch (error, stacktrace) {
      print("User Token $userToken");
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return User("name", "email", "nim", "nik", "phone", "major");
    }
  }

  Future<UserStatusModel> getStatusUser() async {
    String userToken = await storage.read(key: 'token');
    var placeUrl = '$mainUrl/api/profile/status';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(placeUrl);
      print('Place URL :  $placeUrl');
      print("User Token : $userToken");
      print(response.data['data']['place']);
      return UserStatusModel.fromJson(response.data['data']['place']);
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return UserStatusModel(
          0, "name", "uuid", "activity_category", "checkin_date", 0, 0);
    }
  }

  Future<List<Datum>> getPlaceHistoryUser() async {
    String userToken = await storage.read(key: 'token');
    var placeUrl = '$mainUrl/api/history/places';
    try {
      _dio.options.headers["authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(placeUrl);
      print('Place URL :  $placeUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      // var data = ;
      List<Datum> histories = PlaceHistory.fromJson(response.data).data;
      return histories;
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error stackTrace: $stacktrace token : $userToken");
      return <Datum>[];
    }
  }
}
