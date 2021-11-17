import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/src/options.dart' as Opt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limuny/model/UserModel.dart';
import 'package:limuny/provider/user_provider.dart';

class UserRepository {
  static String mainUrl = "http://limuny.infiniteuny.id";
  var loginUrl = '$mainUrl/api/login';
  var profileUrl = '$mainUrl/api/profile';
  var registerUrl = '$mainUrl/api/register';
  final _userProvider = UserProvider();

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

  Future<String?> register(
    String name,
    String email,
    String password,
    String password_c,
    String nim,
    String nik,
    String major,
    String phone,
  ) async {
    Response response = await _dio.post(registerUrl,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password_c,
          "nim": nim,
          "nik": nik,
          "major": major,
          "phone": phone
        },
        options: Opt.Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }));
    log(response.data.toString());
    if (response.statusCode == 201) {
      persistToken(response.data['data']['token']);
      return response.data['data']['token'];
    } else {
      return null;
    }
  }

  Future<String> getUserToken() async {
    String token = await storage.read(key: 'token');
    return token;
  }

  Future<User>? getUser() {
    return _userProvider.fetchUser();
  }
}

class NetworkError extends Error {}
