class AbsensiModel {
  AbsensiModel({
    required this.absensi,
  });

  final Absensi? absensi;

  factory AbsensiModel.fromJson(Map<String, dynamic> json) {
    return AbsensiModel(
      absensi:
          json["Absensi"] == null ? null : Absensi.fromJson(json["Absensi"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "Absensi": absensi?.toJson(),
      };
}

class Absensi {
  Absensi({
    required this.idAbsensi,
    required this.idUser,
    required this.kodeShift,
    required this.tanggalAbsensi,
    required this.waktuMasuk,
    required this.waktuPulang,
    required this.telatMasuk,
    required this.telatPulang,
    required this.latitudeMasuk,
    required this.longitudeMasuk,
    required this.latitudePulang,
    required this.longitudePulang,
    required this.fotoMasuk,
    required this.statusHadir,
  });

  final int? idAbsensi;
  final String? idUser;
  final String? kodeShift;
  final DateTime? tanggalAbsensi;
  final String? waktuMasuk;
  final String? waktuPulang;
  final String? telatMasuk;
  final dynamic telatPulang;
  final String? latitudeMasuk;
  final String? longitudeMasuk;
  final String? latitudePulang;
  final String? longitudePulang;
  final String? fotoMasuk;
  final String? statusHadir;

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      idAbsensi: json["id_absensi"],
      idUser: json["id_user"],
      kodeShift: json["kode_shift"],
      tanggalAbsensi: DateTime.tryParse(json["tanggal_absensi"] ?? ""),
      waktuMasuk: json["waktu_masuk"],
      waktuPulang: json["waktu_pulang"],
      telatMasuk: json["telat_masuk"],
      telatPulang: json["telat_pulang"],
      latitudeMasuk: json["latitude_masuk"],
      longitudeMasuk: json["longitude_masuk"],
      latitudePulang: json["latitude_pulang"],
      longitudePulang: json["longitude_pulang"],
      fotoMasuk: json["foto_masuk"],
      statusHadir: json["status_hadir"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "id_user": idUser,
        "kode_shift": kodeShift,
        "tanggal_absensi": tanggalAbsensi?.toIso8601String(),
        "waktu_masuk": waktuMasuk,
        "waktu_pulang": waktuPulang,
        "telat_masuk": telatMasuk,
        "telat_pulang": telatPulang,
        "latitude_masuk": latitudeMasuk,
        "longitude_masuk": longitudeMasuk,
        "latitude_pulang": latitudePulang,
        "longitude_pulang": longitudePulang,
        "foto_masuk": fotoMasuk,
        "status_hadir": statusHadir,
      };
}
