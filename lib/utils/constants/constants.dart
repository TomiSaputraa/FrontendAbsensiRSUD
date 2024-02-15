import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Font
final kTextStyle = GoogleFonts.poppins();

// endpoint api
const userApiUrl = 'http://10.0.2.2:3000/api/users';
const loginUrl = '$userApiUrl/login';

const absensiUrl = 'http://10.0.2.2:3000/api/absensi/';
const createAbsensiUrl = '${absensiUrl}create';
