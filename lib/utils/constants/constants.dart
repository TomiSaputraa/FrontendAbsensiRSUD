import 'package:google_fonts/google_fonts.dart';

// Font
final kTextStyle = GoogleFonts.poppins();

// Koordinat RSUD
const kRsudLatitude = -1.602936418177061;
const kRsudLongitude = 103.58022258385294;
const krangeInMeters = 100.0;

// endpoint api
// const apiUrl = "https://fond-greatly-lion.ngrok-free.app/";
const apiUrl = "http://192.168.43.77:3000/";

// user
const userApiUrl = '${apiUrl}api/users/';
const loginUrl = '${userApiUrl}login';

// absen
const absensiUrl = '${apiUrl}api/absensi/';
const createAbsensiUrl = '${absensiUrl}create';
const checkLastAbsensi = "${absensiUrl}checkAbsesiToday";

// Izin
const izinUrl = '${apiUrl}api/izin/';
const createIzinUrl = '${izinUrl}create';

// Cuti
const cutiUrl = '${apiUrl}api/cuti/';
const createCutiUrl = '${cutiUrl}create';

// Sakit
const sakitUrl = '${apiUrl}api/sakit/';
const createSakitUrl = '${sakitUrl}create';

// Remote config
const remoteUrl = '${apiUrl}api/admin/config';
