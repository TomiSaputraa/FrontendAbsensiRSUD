import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/ui/widgets/konfirmasi_button.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class UpdateProfilScreen extends StatefulWidget {
  const UpdateProfilScreen({super.key});
  @override
  State<UpdateProfilScreen> createState() => _UpdateProfilScreenState();
}

class _UpdateProfilScreenState extends State<UpdateProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: "Update"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                maxRadius: 50,
                backgroundImage: AssetImage(
                  UiUtils.getImagesPath('foto.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                          initialValue: "Tomi saputra",
                          decoration: const InputDecoration(hintText: "Nama")),
                      TextFormField(
                          initialValue: "Tomi@gmail.com",
                          decoration: const InputDecoration(hintText: "Email")),
                      TextFormField(
                          initialValue: "081212341234",
                          decoration:
                              const InputDecoration(hintText: "Nomor Handphone")),
                      TextFormField(
                          decoration: const InputDecoration(hintText: "Password")),
                      const SizedBox(height: 25),
                      wKonfirmasiButton(function: () {})
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
