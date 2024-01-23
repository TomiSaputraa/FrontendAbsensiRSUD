import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/user/absen.dart';
import 'package:absensi_mattaher/pages/user/widget/absensiButton.dart';
import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});
  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Absensi'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pilih absensi yang kamu inginkan',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                const AbsenPage().launch(context);
              },
              child: absensiButton(
                assetPath: 'assets/icon _fingerprint.svg',
                label: 'Absen',
              ),
            )
          ],
        ),
      ),
    );
  }
}
