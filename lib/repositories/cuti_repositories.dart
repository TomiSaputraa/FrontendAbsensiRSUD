import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:dio/dio.dart';

import '../services/database_services.dart';

class CutiRepositories {
  final Dio dio = Dio();

  Future createCuti({
    required String tanggalMulai,
    required String tanggalSelesai,
    required String alasan,
    required int totalHari,
  }) async {
    var token = await DataBase().storageGetString('token');
    Uri url = Uri.parse(createCutiUrl);

    try {
      Map<String, dynamic> form = <String, dynamic>{
        "tanggal_mulai_cuti": tanggalMulai,
        "tanggal_selesai_cuti": tanggalSelesai,
        "alasan_cuti": alasan,
        "total_hari_cuti": totalHari,
      };

      final response = await dio.post(
        url.toString(),
        data: form,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 201) {
        print("Cuti berhasil : ${response.data}");
      } else {
        print("Cuti gagal: ${response}");
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
