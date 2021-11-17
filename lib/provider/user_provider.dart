import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:limuny/model/UserModel.dart';

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
}
