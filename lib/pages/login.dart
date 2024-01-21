import 'dart:math';

import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/repositories/login_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = new FlutterSecureStorage();

  final UserAPI userAPI = UserAPI();

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
          print('Id user kosong');
        } else if (passwordController.text.isEmpty) {
          print('Password tidak boleh kosong');
        } else {
          try {
            var response = await UserAPI().login(
              idUserController.text,
              passwordController.text,
            );
            await storage.write(key: 'token', value: response!['accessToken']);
            await storage.write(key: 'id_user', value: response!['id_user']);

            if (mounted) {
              Navigator.pushReplacementNamed(context, '/user/home');
            }

            // print(response);
            // fungsi pengecekan apakah token sudah disimpan
            // String? value = await storage.read(key: 'id_user');
            // print('key dari secure : $value');
          } catch (e) {
            if (e is DioException) {
              if (e.response != null) {
                print('DioError response: ${e.response!.data}');
              } else {
                print('DioError request: ${e.requestOptions}');
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
