import 'package:absensi_mattaher/config_users.dart';
import 'package:absensi_mattaher/provider/database_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserAPI {
  final secureStorage = const FlutterSecureStorage();
  final Dio dio = Dio();

  Future login(String idUser, String password) async {
    final response = await dio.post(ConfigUser.serverUrl + ConfigUser.loginPath,
        data: <String, dynamic>{
          'id_user': idUser,
          'password': password,
        });

    if (response.statusCode == 200) {
      // print(response.data);
      return response.data;
    } else {
      print('Ada kesalahan login');
    }
  }

  Future userProfileInfo(String? idUser) async {
    Uri url = Uri.parse(ConfigUser.serverUrl + idUser!);
    String? token = await DataBase().getString('token');
    // print(token);
    var response = await dio.get(url.toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    // print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.data);
      return response.data;
    } else {
      print('Ada kesalahan saat mendapatkan informasi user');
    }
  }
}
