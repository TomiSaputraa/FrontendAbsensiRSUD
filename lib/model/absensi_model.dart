class AbsensiModel {
  AbsensiModel({
    required this.message,
    required this.result,
  });

  final String? message;
  final Result? result;

  factory AbsensiModel.fromJson(Map<String, dynamic> json) {
    return AbsensiModel(
      message: json["message"],
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  Result({
    this.idAbsensi,
    this.idUser,
    this.jamMasukAbsesi,
    this.tanggalAbsensi,
    required this.latitudeMasuk,
    required this.longtitudeMasuk,
    this.fotoMasuk,
    this.statusHadir,
  });

  final String? idAbsensi;
  final String? idUser;
  final DateTime? jamMasukAbsesi;
  final DateTime? tanggalAbsensi;
  final String? latitudeMasuk;
  final String? longtitudeMasuk;
  final String? fotoMasuk;
  final String? statusHadir;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      idAbsensi: json["id_absensi"],
      idUser: json["id_user"],
      jamMasukAbsesi: DateTime.tryParse(json["jam_masuk_absesi"] ?? ""),
      tanggalAbsensi: DateTime.tryParse(json["tanggal_absensi"] ?? ""),
      latitudeMasuk: json["latitude_masuk"],
      longtitudeMasuk: json["longtitude_masuk"],
      fotoMasuk: json["foto_masuk"],
      statusHadir: json["status_hadir"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "id_user": idUser,
        "jam_masuk_absesi": jamMasukAbsesi?.toIso8601String(),
        "tanggal_absensi": tanggalAbsensi?.toIso8601String(),
        "latitude_masuk": latitudeMasuk,
        "longtitude_masuk": longtitudeMasuk,
        "foto_masuk": fotoMasuk,
        "status_hadir": statusHadir,
      };
}
