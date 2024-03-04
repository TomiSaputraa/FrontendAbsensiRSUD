import 'package:google_fonts/google_fonts.dart';

// Font
final kTextStyle = GoogleFonts.poppins();

// endpoint api
const apiUrl = "http://10.0.2.2:3000/";
const userApiUrl = 'http://10.0.2.2:3000/api/users/';
const loginUrl = '${userApiUrl}login';

// absensi
const absensiUrl = '${apiUrl}api/absensi/';
const createAbsensiUrl = '${absensiUrl}create';
const checkLastAbsensi = "${absensiUrl}checkAbsesiToday";
