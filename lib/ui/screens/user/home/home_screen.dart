import 'package:absensi_mattaher/model/absensi_model.dart';
import 'package:absensi_mattaher/model/user_profile.dart';
import 'package:absensi_mattaher/repositories/absensi_repositories.dart';
import 'package:absensi_mattaher/repositories/user_repositories.dart';
import 'package:absensi_mattaher/ui/screens/user/absensi/absensi_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/home/pulang_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/jadwal/jadwal_screen.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/constants/constants.dart';
import '../../../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepositories _userRepositories = UserRepositories();
  final AbsensiRepositories _absensiRepositories = AbsensiRepositories();
  Future<UserProfile>? _userProfile;
  Future<AbsensiModel>? _absensi;
  String? _curentDateTime;
  String _jamMasuk = "--:--";
  String _waktuPulang = "--:--";

  @override
  void initState() {
    super.initState();
    _userProfile = _userRepositories.userProfileInfo();
    _absensi = _absensiRepositories.getLastAbsensi();
    getCurrentDate();
    getHourAbsesi();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getHourAbsesi();
  }

  void getCurrentDate() {
    DateTime now = DateTime.now();
    String formatDate =
        "${now.day.toString().padLeft(2, "0")}-${now.month.toString().padLeft(2, "0")}-${now.year}";
    setState(() {
      _curentDateTime = formatDate;
    });
  }

  void getHourAbsesi() {
    _absensi!.then(
      (absensi) {
        DateTime waktuMasuk =
            DateTime.parse(absensi.absensi!.tanggalAbsensi.toString());
        DateFormat format = DateFormat('dd-MM-yyyy');
        String formatedDate = format.format(waktuMasuk); //result : 04-03-2024
        // print("absensi function ${formatedDate}");

        // pengecekan apakah ada tanggal absensi yang sama saat ini dengan tanggal sistem
        if (formatedDate == _curentDateTime) {
          setState(() {
            _jamMasuk = absensi.absensi!.waktuMasuk.toString();
            _waktuPulang = absensi.absensi!.waktuPulang.toString();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                                  _jamMasuk,
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
                                  _waktuPulang,
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
                            const AbsensiPage().launch(context).then((value) {
                              setState(() {});
                            });
                            ;
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
                            const JadwalScreen().launch(context).then((value) {
                              setState(() {});
                            });
                          },
                          child: _button(
                              name: "Jadwal",
                              iconPath: UiUtils.getImagesPath(
                                  'home/jadwal_icon.svg')),
                        ),
                      ),
                      SizedBox(
                        width: 57,
                        child: GestureDetector(
                          onTap: () {
                            const PulangScreen().launch(context).then((value) {
                              setState(() {});
                            });
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
        child: FutureBuilder(
          future: _userProfile,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Text("No data", style: kTextStyle);
            } else if (snapshot.hasError) {
              UiUtils.setSnackbar(context,
                  text: "Ada kesalahan saat proses data");
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(apiUrl + snapshot.data.fotoProfil),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data.namaLengkap,
                          style: kTextStyle.copyWith(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          snapshot.data.jabatan,
                          style: kTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Selamat datang, Jangan lupa absen hari ini \n $_curentDateTime',
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
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
