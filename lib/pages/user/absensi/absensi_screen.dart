import 'package:absensi_mattaher/pages/user/absen/absen_screen.dart';
import 'package:absensi_mattaher/pages/user/izin/izin_screen.dart';
import 'package:absensi_mattaher/pages/user/widget/absensiButton.dart';
import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/constants/constants.dart';

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
              'Pilih tipe absensi:',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42, // 42% screen
              width: MediaQuery.of(context).size.width * 0.8,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.spaceAround,
                spacing: 17,
                children: [
                  GestureDetector(
                    onTap: () {
                      const AbsenPage().launch(context);
                    },
                    child: absensiButton(
                      assetPath: 'assets/absensi/absen.svg',
                      label: 'Absen',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      const IzinScreen().launch(context);
                    },
                    child: absensiButton(
                      assetPath: 'assets/absensi/izin_icon.svg',
                      label: 'Izin',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      const AbsenPage().launch(context);
                    },
                    child: absensiButton(
                      assetPath: 'assets/absensi/cuti_icon.svg',
                      label: 'Cuti',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      const AbsenPage().launch(context);
                    },
                    child: absensiButton(
                      assetPath: 'assets/absensi/sakit_icon.svg',
                      label: 'Sakit',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
