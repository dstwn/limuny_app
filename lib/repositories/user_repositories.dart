import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static String mainUrl = "http://limuny.infiniteuny.id";
  var loginUrl = '$mainUrl/api/login';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    String token = await storage.read(key: 'token');
    // ignore: unnecessary_null_comparison
    return token != null ? true : false;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.deleteAll();
  }

  Future<String?> login(String email, String password) async {
    Response response =
        await _dio.post(loginUrl, data: {"email": email, "password": password});
    log(response.data.toString());
    if (response.statusCode == 200) {
      persistToken(response.data['data']['token']);
      return response.data['data']['token'];
    } else {
      return null;
    }
  }
}
