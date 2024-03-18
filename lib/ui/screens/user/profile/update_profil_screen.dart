import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/ui/widgets/konfirmasi_button.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../model/user_model.dart';
import '../../../../repositories/user_repositories.dart';
import '../../../../utils/constants/constants.dart';
import '../../../styles/colors.dart';

class UpdateProfilScreen extends StatefulWidget {
  const UpdateProfilScreen({super.key});
  @override
  State<UpdateProfilScreen> createState() => _UpdateProfilScreenState();
}

class _UpdateProfilScreenState extends State<UpdateProfilScreen> {
  final UserRepositories _userRepositories = UserRepositories();
  Future<UserProfile>? _userProfile;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  String _previousEmail = '';
  String _previousPhone = '';

  @override
  void initState() {
    super.initState();
    _userProfile = _userRepositories.userProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: "Update"),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _userProfile,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    "Mendapatkan data...",
                    style:
                        kTextStyle.copyWith(fontSize: 16, color: kPrimaryColor),
                  ),
                );
              } else if (snapshot.hasError) {
                UiUtils.setSnackbar(context,
                    text: "Ada kesalahan saat proses data");
              }
              if (_previousEmail.isEmpty) {
                _previousEmail = snapshot.data!.email!;
              }
              return Column(
                children: [
                  // CircleAvatar(
                  //   maxRadius: 50,
                  //   backgroundImage: AssetImage(
                  //     UiUtils.getImagesPath('foto.png'),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  filled: true,
                                  hintMaxLines: 100,
                                  hintText: snapshot.data!.namaLengkap)),
                          TextFormField(
                            controller: _emailController
                              ..text = snapshot.data!
                                  .email, // default value akan menggunakan value dari snapshot data
                            decoration:
                                const InputDecoration(hintText: "Email baru"),
                          ),
                          TextFormField(
                            controller: _noHpController
                              ..text = snapshot.data!.noHp,
                            decoration:
                                InputDecoration(hintText: snapshot.data!.noHp),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                hintText: "Password baru"),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _passwordConfirmController,
                            decoration: const InputDecoration(
                                hintText: "Konfirmasi Password baru"),
                          ),
                          const SizedBox(height: 30),
                          wKonfirmasiButton(
                            function: () async {
                              // validasi email
                              if (_emailController.text != _previousEmail &&
                                  !RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(_emailController.text)) {
                                UiUtils.setSnackbar(
                                  context,
                                  text: "Email tidak valid",
                                );
                                // validasi no hp
                              } else if (_noHpController.text !=
                                      _previousPhone &&
                                  !RegExp(r'^(\+62|62)?[\s-]?0?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$')
                                      .hasMatch(_noHpController.text)) {
                                UiUtils.setSnackbar(
                                  context,
                                  text: "Nomor Handphone tidak valid",
                                );
                                // validasi password
                              } else if (_passwordController.text ==
                                  _passwordConfirmController.text) {
                                await _userRepositories.updateProfile(
                                  email: _emailController.text,
                                  noHp: _noHpController.text,
                                  password: _passwordController.text,
                                );

                                if (mounted) {
                                  UiUtils.setSnackbar(context,
                                      text: "Update data berhasil");
                                }
                              } else {
                                UiUtils.setSnackbar(context,
                                    text: "Konfirmasi password tidak cocok");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
