import 'dart:io';

import 'package:absensi_mattaher/config_users.dart';
import 'package:dio/dio.dart';

class Absensi {
  final Dio dio = Dio();

  Future createAbsensi({
    String? idUser,
    String? jamMasuk,
    String? tanggalAbsensi,
    String? latitudeMasuk,
    String? longtitudeMasuk,
    File? fotoMasuk,
    String? token,
  }) async {
    Uri url = Uri.parse(ConfigUser.absensiUrl + ConfigUser.createAbsensiPath);
    print('url $url');

    try {
      // cek ambil foto dari mana
      // print('foto masuk dari repo : ' + fotoMasuk!.path);
      FormData formData = FormData.fromMap(
        {
          "id_user": idUser,
          "latitude_masuk": latitudeMasuk,
          "longtitude_masuk": longtitudeMasuk,
          'file': await MultipartFile.fromFile(
            fotoMasuk!.path, // Ambil file foto dari mana
            filename: fotoMasuk.path
                .split('/')
                .last, // setelah di ambil jika di upload ingin nama file nya jadi apa
          ),
        },
      );

      print('Form data : ${formData.fields}');

      final response = await dio.post(
        url.toString(),
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print("Pendaftaran berhasil: ${response.data}");
      } else {
        print("Pendaftaran gagal: ${response.statusCode}");
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}
