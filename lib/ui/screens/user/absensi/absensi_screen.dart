import 'package:absensi_mattaher/repositories/absensi_repositories.dart';
import 'package:absensi_mattaher/ui/screens/user/absen/absen_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/absensi/cuti_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/absensi/izin_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/absensi/sakit_screen.dart';
import 'package:absensi_mattaher/ui/widgets/absensi_button.dart';
import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../model/absensi_model.dart';
import '../../../styles/colors.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});
  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(
        context,
        text: 'Absensi',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                        assetPath: UiUtils.getImagesPath('absensi/absen.svg'),
                        label: 'Absen',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        const IzinScreen().launch(context);
                      },
                      child: absensiButton(
                        assetPath: UiUtils.getImagesPath('absensi/absen.svg'),
                        label: 'Izin',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        const CutiScreen().launch(context);
                      },
                      child: absensiButton(
                        assetPath:
                            UiUtils.getImagesPath('absensi/cuti_icon.svg'),
                        label: 'Cuti',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        const SakitScreen().launch(context);
                      },
                      child: absensiButton(
                        assetPath:
                            UiUtils.getImagesPath('absensi/sakit_icon.svg'),
                        label: 'Sakit',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
