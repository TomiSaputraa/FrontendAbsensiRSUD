class UserProfile {
  UserProfile({
    required this.idUser,
    required this.password,
    required this.role,
    required this.namaLengkap,
    required this.bergabungSejak,
    required this.absensi,
    required this.count,
  });

  final String? idUser;
  final String? password;
  final String? role;
  final String? namaLengkap;
  final DateTime? bergabungSejak;
  final List<Absensi> absensi;
  final Count? count;

  UserProfile copyWith({
    String? idUser,
    String? password,
    String? role,
    String? namaLengkap,
    DateTime? bergabungSejak,
    List<Absensi>? absensi,
    Count? count,
  }) {
    return UserProfile(
      idUser: idUser ?? this.idUser,
      password: password ?? this.password,
      role: role ?? this.role,
      namaLengkap: namaLengkap ?? this.namaLengkap,
      bergabungSejak: bergabungSejak ?? this.bergabungSejak,
      absensi: absensi ?? this.absensi,
      count: count ?? this.count,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      idUser: json["id_user"],
      password: json["password"],
      role: json["role"],
      namaLengkap: json["nama_lengkap"],
      bergabungSejak: DateTime.tryParse(json["bergabung_sejak"] ?? ""),
      absensi: json["Absensi"] == null
          ? []
          : List<Absensi>.from(
              json["Absensi"]!.map((x) => Absensi.fromJson(x))),
      count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "password": password,
        "role": role,
        "nama_lengkap": namaLengkap,
        "bergabung_sejak": bergabungSejak?.toIso8601String(),
        "Absensi": absensi.map((x) => x?.toJson()).toList(),
        "_count": count?.toJson(),
      };
}

class Absensi {
  Absensi({
    required this.idAbsensi,
    required this.idUser,
    required this.jamMasukAbsesi,
    required this.tanggalAbsensi,
    required this.latitudeMasuk,
    required this.longtitudeMasuk,
    required this.fotoMasuk,
    required this.statusHadir,
  });

  final int? idAbsensi;
  final String? idUser;
  final DateTime? jamMasukAbsesi;
  final DateTime? tanggalAbsensi;
  final String? latitudeMasuk;
  final String? longtitudeMasuk;
  final String? fotoMasuk;
  final String? statusHadir;

  Absensi copyWith({
    int? idAbsensi,
    String? idUser,
    DateTime? jamMasukAbsesi,
    DateTime? tanggalAbsensi,
    String? latitudeMasuk,
    String? longtitudeMasuk,
    String? fotoMasuk,
    String? statusHadir,
  }) {
    return Absensi(
      idAbsensi: idAbsensi ?? this.idAbsensi,
      idUser: idUser ?? this.idUser,
      jamMasukAbsesi: jamMasukAbsesi ?? this.jamMasukAbsesi,
      tanggalAbsensi: tanggalAbsensi ?? this.tanggalAbsensi,
      latitudeMasuk: latitudeMasuk ?? this.latitudeMasuk,
      longtitudeMasuk: longtitudeMasuk ?? this.longtitudeMasuk,
      fotoMasuk: fotoMasuk ?? this.fotoMasuk,
      statusHadir: statusHadir ?? this.statusHadir,
    );
  }

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
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

class Count {
  Count({
    required this.absensi,
  });

  final int? absensi;

  Count copyWith({
    int? absensi,
  }) {
    return Count(
      absensi: absensi ?? this.absensi,
    );
  }

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      absensi: json["Absensi"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Absensi": absensi,
      };
}
