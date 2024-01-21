import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                _loginForm(),
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
              validator: (value) {
                print(value);
              },
            ),
            TextFormField(
              // obscureText: true,
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
        Navigator.pushReplacementNamed(context, '/user/home');
      },
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 60, vertical: 14),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
