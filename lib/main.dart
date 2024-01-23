import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

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
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
