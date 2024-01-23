import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/user/home.dart';
import 'package:absensi_mattaher/provider/database_provider.dart';
import 'package:absensi_mattaher/repositories/login_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = const FlutterSecureStorage();

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
        print('object');
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

            await DataBase().saveString('token', response!['accessToken']);
            await DataBase().saveString('id_user', response!['id_user']);

            try {
              String? idUser = await DataBase().getString('id_user');
              var responseProfile = await UserAPI().userProfileInfo(idUser!);
              if (mounted) {
                UserHome(
                  response: responseProfile,
                ).launch(context);
              }
            } catch (e) {
              if (e is DioException) {
                if (e.response != null) {
                  print('DioError response: ${e.response!.data['title']}');
                  print('DioError response: ${e.response!.data['message']}');
                } else {
                  print('DioError request: ${e.requestOptions}');
                }
              }
            }

            // print(response);
            // fungsi pengecekan apakah token sudah disimpan
            Map<String, String> allValues = await storage.readAll();
            print('all value : $allValues');

            // String? value = await storage.read(key: 'id_user');
            // print('key dari secure : $value');

            // String? value = await DataBase().getString('token');
            // print(value);
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
