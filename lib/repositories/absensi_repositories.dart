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

      // simpan waktu masuk kedalam token
      var waktuMasuk = response.data['result']['waktu_masuk'];
      DataBase().prefSetString(waktuMasuk, "waktu_masuk");
      print("waktuMasuk $waktuMasuk");

      if (response.statusCode == 201) {
        print("Absensi berhasil: ${response.data}");
      } else {
        print("Absensi gagal: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        throw Exception(e.response!.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        throw Exception(e.response!.statusCode);
      }
    }
  }

  Future<AbsensiModel> getLastAbsensi() async {
    try {
      String? token = await DataBase().storageGetString('token');
      Uri url = Uri.parse(checkLastAbsensi);

      var response = await dio.get(url.toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // print("response absensi : ${response.data}");

      if (response.statusCode == 200) {
        // print(response.data);
        return AbsensiModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load absensi data');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future updateAbsensi({
    int? idAbsen,
    String? kodeShift,
    String? waktuPulang,
    String? latPulang,
    String? longPulang,
  }) async {
    String? token = await DataBase().storageGetString('token');
    Uri url = Uri.parse(absensiUrl + idAbsen.toString());

    Map<String, dynamic> data = <String, dynamic>{
      "kode_shift": kodeShift,
      "waktu_pulang": waktuPulang,
      "latitude_pulang": latPulang,
      "longitude_pulang": longPulang,
    };

    var response = await dio.put(
      url.toString(),
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("Update Absensi berhasil: ${response.data}");
    } else {
      print("Absensi gagal: ${response.statusCode}");
    }
  }
}
