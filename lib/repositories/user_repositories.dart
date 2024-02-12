import 'package:absensi_mattaher/model/user_profile.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:absensi_mattaher/services/database_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepositories {
  final secureStorage = const FlutterSecureStorage();
  final Dio dio = Dio();

  Future login({required String idUser, required String password}) async {
    final response = await dio.post(
      loginUrl,
      data: <String, dynamic>{
        'id_user': idUser,
        'password_hash': password,
      },
    );

    if (response.statusCode == 200) {
      // print(response.data);
      return response.data;
    } else {
      print('Ada kesalahan login');
    }
  }

  Future<dynamic> userProfileInfo() async {
    String? token = await DataBase().storageGetString('token');
    String? idUser = await DataBase().storageGetString('id_user');
    Uri url = Uri.parse(userApiUrl + idUser!);

    var response = await dio.get(url.toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    // print('response data : ${response.data}');

    if (response.statusCode == 200) {
      // print(response.data);
      return UserProfile.fromJson(response.data);
    } else {
      print('Ada kesalahan saat mendapatkan informasi user');
    }
  }
}
