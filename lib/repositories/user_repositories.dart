import 'package:absensi_mattaher/model/user_model.dart';
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

  Future<UserProfile> userProfileInfo() async {
    try {
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
        print(response.statusCode);
        throw Exception('Failed to load user');
      }
    } on DioException catch (e) {
      throw Exception(e.response!.statusCode);
    }
  }

  Future updateProfile(
      {String? namaLengkap,
      String? email,
      String? noHp,
      String? password}) async {
    String? token = await DataBase().storageGetString('token');
    String? idUser = await DataBase().storageGetString('id_user');
    Uri url = Uri.parse(userApiUrl + idUser!);

    Map<String, dynamic> data = <String, dynamic>{
      "nama_lengkap": namaLengkap,
      "email": email,
      "no_hp": noHp,
      "password_hash": password
    };

    var response = await dio.patch(
      url.toString(),
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      print("Update data user berhasil: ${response.data}");
    } else {
      print("update gagal: ${response.statusCode}");
    }
  }
}
