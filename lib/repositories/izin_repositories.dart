import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:dio/dio.dart';

import '../services/database_services.dart';

class IzinRepositories {
  final Dio dio = Dio();

  Future createIzin({
    required String tanggalMulai,
    required String tanggalSelesai,
    required String alasan,
    required int totalHari,
  }) async {
    var token = await DataBase().storageGetString('token');
    Uri url = Uri.parse(createIzinUrl);

    try {
      Map<String, dynamic> form = <String, dynamic>{
        "tanggal_mulai_izin": tanggalMulai,
        "tanggal_selesai_izin": tanggalSelesai,
        "alasan_izin": alasan,
        "total_hari_izin": totalHari,
      };

      final response = await dio.post(
        url.toString(),
        data: form,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print("absensi berhasil : ${response.data}");
      } else {
        print("Absensi gagal: $response");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response);
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
