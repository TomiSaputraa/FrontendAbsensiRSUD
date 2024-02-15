import 'package:absensi_mattaher/ui/screens/user/absensi/absensi_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/jadwal/jadwal_screen.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/constants/constants.dart';
import '../../../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.response});
  final Map? response;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  "Waktu absen kerja :",
                  style: kTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Waktu masuk
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF083B7F),
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Masuk"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                UiUtils.getImagesPath('home/clock_icon.svg')),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: Colors.green,
                              ),
                              child: Text(
                                '08:00',
                                style: kTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Waktu pulang
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF083B7F),
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Pulang"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                UiUtils.getImagesPath('home/clock_icon.svg')),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                '18:00',
                                style: kTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF083B7F),
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 57,
                      child: GestureDetector(
                        onTap: () {
                          const AbsensiPage().launch(context);
                        },
                        child: _button(
                            name: "Absensi",
                            iconPath: UiUtils.getImagesPath(
                                'home/icon_fingerprint.svg')),
                      ),
                    ),
                    SizedBox(
                      width: 57,
                      child: GestureDetector(
                        onTap: () {
                          const JadwalScreen().launch(context);
                        },
                        child: _button(
                            name: "Jadwal",
                            iconPath:
                                UiUtils.getImagesPath('home/jadwal_icon.svg')),
                      ),
                    ),
                    SizedBox(
                      width: 57,
                      child: GestureDetector(
                        onTap: () {
                          const AbsensiPage().launch(context);
                        },
                        child: _button(
                          name: "Pulang",
                          iconPath:
                              UiUtils.getImagesPath("home/pulang_icon.svg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // background
  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.9),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    UiUtils.getImagesPath('foto.png'),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tomi saputra",
                      style: kTextStyle.copyWith(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Administrasi",
                      style: kTextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Selamat datang, Jangan lupa absen hari ini \n 12-03-2024',
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({required String name, required String iconPath}) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 45,
          height: 45,
        ),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF083B7F),
          ),
        )
      ],
    );
  }
}
