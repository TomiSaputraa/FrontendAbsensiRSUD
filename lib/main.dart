import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/login.dart';
import 'package:absensi_mattaher/pages/user/absen.dart';
import 'package:absensi_mattaher/pages/user/absensi.dart';
import 'package:absensi_mattaher/pages/user/home.dart';
import 'package:absensi_mattaher/pages/user/lokasi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi RSUD Mattaher',
      theme: ThemeData(
        primaryColor: Constants.kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        // '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/user/home': (context) => const UserHome(),
        '/user/absensi': (context) => const AbsensiPage(),
        '/user/absen': (context) => const AbsenPage(),
        '/user/absen/lokasi': (context) => const LokasiScreen(),
      },
    );
  }
}
