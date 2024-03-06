import 'dart:io';

import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:dio/dio.dart';

import '../services/database_services.dart';

class SakitRepositories {
  Dio dio = Dio();

  Future createSakit({
    required String tanggalMulai,
    required String tanggalSelesai,
    required String alasan,
    required File foto,
    required int totalHari,
  }) async {
    try {
      var token = await DataBase().storageGetString('token');
      Uri url = Uri.parse(createSakitUrl);

      FormData formData = FormData.fromMap({
        "tanggal_mulai_sakit": tanggalMulai,
        "tanggal_selesai_sakit": tanggalSelesai,
        "alasan_sakit": alasan,
        "bukti_foto": await MultipartFile.fromFile(
          foto.path,
          filename: foto.path.split('/').last,
        ),
        "total_hari_sakit": totalHari,
      });

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
        print("Sakit berhasil: ${response.data}");
      } else {
        print("Sakit gagal: ${response.statusCode}");
      }
    } on DioException catch (e) {
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
