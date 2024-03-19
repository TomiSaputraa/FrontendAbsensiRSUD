class UserProfile {
  UserProfile({
    required this.idUser,
    required this.passwordHash,
    required this.namaLengkap,
    required this.jabatan,
    required this.ruangan,
    required this.grup,
    required this.jenisKelamin,
    required this.email,
    required this.noHp,
    required this.fotoProfil,
    required this.bergabungSejak,
    required this.role,
  });

  final String? idUser;
  final String? passwordHash;
  final String namaLengkap;
  final String? jabatan;
  final String? ruangan;
  final String? grup;
  final String? jenisKelamin;
  final String email;
  final String noHp;
  final String? fotoProfil;
  final DateTime? bergabungSejak;
  final String? role;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      idUser: json["id_user"],
      passwordHash: json["password_hash"],
      namaLengkap: json["nama_lengkap"],
      jabatan: json["jabatan"],
      ruangan: json["ruangan"],
      grup: json["grup"],
      jenisKelamin: json["jenis_kelamin"],
      email: json["email"],
      noHp: json["no_hp"],
      fotoProfil: json["foto_profil"],
      bergabungSejak: DateTime.tryParse(json["bergabung_sejak"] ?? ""),
      role: json["role"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "password_hash": passwordHash,
        "nama_lengkap": namaLengkap,
        "jabatan": jabatan,
        "ruangan": ruangan,
        "grup": grup,
        "jenis_kelamin": jenisKelamin,
        "email": email,
        "no_hp": noHp,
        "foto_profil": fotoProfil,
        "bergabung_sejak": bergabungSejak?.toIso8601String(),
        "role": role,
      };
}
