import 'package:absensi_mattaher/config_users.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserAPI {
  // final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final secureStorage = new FlutterSecureStorage();
  final Dio dio = Dio();

  Future login(String id_user, String password) async {
    final response = await dio.post(ConfigUser.serverUrl + ConfigUser.loginPath,
        data: <String, dynamic>{
          'id_user': id_user,
          'password': password,
        });
    // print('response data : $response');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('Ada kesalahan login');
    }
  }
}
