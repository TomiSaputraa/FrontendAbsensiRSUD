import 'package:meta/meta.dart';
import 'dart:convert';

class AbsensiModel {
  int idAbsensi;
  String idUser;
  String kodeShift;
  String tanggalAbsensi;
  String waktuMasuk;
  String waktuPulang;
  String telatMasuk;
  String? telatPulang;
  String latitudeMasuk;
  String? longitudeMasuk;
  String? latitudePulang;
  dynamic longitudePulang;
  String fotoMasuk;
  String statusHadir;

  AbsensiModel({
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

  factory AbsensiModel.fromRawJson(String str) =>
      AbsensiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AbsensiModel.fromJson(Map<String, dynamic> json) => AbsensiModel(
        idAbsensi: json["id_absensi"],
        idUser: json["id_user"],
        kodeShift: json["kode_shift"],
        tanggalAbsensi: json["tanggal_absensi"],
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

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "id_user": idUser,
        "kode_shift": kodeShift,
        "tanggal_absensi": tanggalAbsensi,
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
