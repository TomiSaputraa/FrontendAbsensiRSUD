import 'package:absensi_mattaher/pages/login.dart';
import 'package:absensi_mattaher/pages/user/cubits/user_details_cubit.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  SharedPreferences.getInstance();
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailsCubit>(
      create: (context) => UserDetailsCubit(),
      child: MaterialApp(
        title: 'Absensi RSUD Mattaher',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: GoogleFonts.poppinsTextTheme(),
          primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
