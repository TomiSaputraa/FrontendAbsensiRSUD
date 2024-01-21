import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/login.dart';
import 'package:absensi_mattaher/pages/user/absen.dart';
import 'package:absensi_mattaher/pages/user/absensi.dart';
import 'package:absensi_mattaher/pages/user/home.dart';
import 'package:absensi_mattaher/pages/user/lokasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi RSUD Mattaher',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute:
      // secureStorage.read(key: 'token') != null ? '/user/home' : '/login',
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
