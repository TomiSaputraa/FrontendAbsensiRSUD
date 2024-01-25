import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/model/user_profile.dart';
import 'package:absensi_mattaher/pages/user/home.dart';
import 'package:absensi_mattaher/services/database_services.dart';
import 'package:absensi_mattaher/repositories/user_repositories.dart';
import 'package:absensi_mattaher/utils/logging_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = const FlutterSecureStorage();

  final UserRepositories userAPI = UserRepositories();

  final _formKey = GlobalKey<FormState>();
  final idUserController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _textArea(
                  text: 'Selamat datang',
                  fSize: 20,
                  fWeight: FontWeight.w700,
                ),
                _logoRs(),
                _textArea(
                  text: 'Silahkan login menggunakan akun yang telah terdaftar',
                  fSize: 16,
                  fWeight: FontWeight.w500,
                ),
                const SizedBox(height: 20),
                _loginForm(),
                const SizedBox(height: 50),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // text
  Widget _textArea({String? text, double? fSize, FontWeight? fWeight}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fSize,
          fontWeight: fWeight,
        ),
      ),
    );
  }

  // Logo
  Widget _logoRs() {
    return SizedBox(
      height: 220,
      width: 220,
      child: SvgPicture.asset(
        'assets/logo rs.svg',
        fit: BoxFit.cover,
      ),
    );
  }

// Form login
  Widget _loginForm() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Id User'),
              controller: idUserController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
            ),
          ],
        ),
      ),
    );
  }

  // login button
  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (idUserController.text.isEmpty) {
          printWarning('id user kosong');
        } else if (passwordController.text.isEmpty) {
          printWarning('Password tidak boleh kosong');
        } else {
          try {
            var response = await UserRepositories().login(
              idUserController.text,
              passwordController.text,
            );

            await DataBase()
                .storageSaveString('token', response!['accessToken']);
            await DataBase().storageSaveString('id_user', response!['id_user']);

            try {
              UserProfile userProfile =
                  await UserRepositories().userProfileInfo();
              // print('model : ${userProfile.namaLengkap}');
              if (mounted) {
                // UserHome(
                //   response: responseProfile,
                // ).launch(context);
                const Home().launch(context);
              }
            } catch (e) {
              if (e is DioException) {
                if (e.response != null) {
                  printError('DioError response: ${e.response!.data['title']}');
                  printError(
                      'DioError response: ${e.response!.data['message']}');
                } else {
                  printError('DioError request: ${e.requestOptions}');
                }
              }
            }

            // fungsi pengecekan apakah token sudah disimpan
            Map<String, String> allValues = await storage.readAll();
            log('all storage : $allValues');

            // String? value = await DataBase().getString('token');
            // log(value);
          } catch (e) {
            if (e is DioException) {
              if (e.response != null) {
                log('DioError response: ${e.response!.data}');
              } else {
                log('DioError request: ${e.requestOptions}');
              }
            }
          }
        }
      },
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 60, vertical: 14),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
