import 'dart:io';

import 'package:absensi_mattaher/model/absensi_model.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:dio/dio.dart';

import '../services/database_services.dart';

class AbsensiRepositories {
  final Dio dio = Dio();

  Future createAbsensi({
    required String kodeShift,
    String? telatMasuk,
    String? telatPulang,
    required String latitudeMasuk,
    required String longitudeMasuk,
    String? latitudePulang,
    String? longitudePulang,
    required File fotoMasuk,
  }) async {
    var token = await DataBase().storageGetString('token');
    var idUser = await DataBase().storageGetString('id_user');
    Uri url = Uri.parse(createAbsensiUrl);

    try {
      // cek sumber foto
      // print('foto masuk dari repo : ' + fotoMasuk!.path);
      FormData formData = FormData.fromMap(
        {
          "id_user": idUser,
          "kode_shift": kodeShift,
          "telat_masuk": telatMasuk,
          "telat_pulang": telatPulang,
          "latitude_masuk": latitudeMasuk,
          "longitude_masuk": longitudeMasuk,
          "latitude_pulang": latitudePulang,
          "longtitude_pulang": longitudePulang,
          'file': await MultipartFile.fromFile(
            fotoMasuk.path, // Sumber foto
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
        print("Absensi berhasil: ${response.data}");
      } else {
        print("Absensi gagal: ${response.statusCode}");
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

  Future<AbsensiModel> getLastAbsensi() async {
    String? token = await DataBase().storageGetString('token');
    Uri url = Uri.parse(checkLastAbsensi);

    var response = await dio.get(url.toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    // print("response absensi : ${response.data}");

    if (response.statusCode == 200) {
      return AbsensiModel.fromJson(response.data);
    } else {
      throw Exception("Gagal mendapatkan data absensi");
    }
  }
}
