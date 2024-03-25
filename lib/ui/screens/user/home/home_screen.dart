import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../model/absensi_model.dart';
import '../../../../model/user_model.dart';
import '../../../../repositories/absensi_repositories.dart';
import '../../../../repositories/user_repositories.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_utils.dart';
import '../../../styles/colors.dart';
import '../absensi/absensi_screen.dart';
import 'jadwal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepositories _userRepositories = UserRepositories();
  final AbsensiRepositories _absensiRepositories = AbsensiRepositories();
  Future<UserProfile>? _userProfile;
  String? _currentDateTime;
  AbsensiModel? _absensiModel;

  int? idAbsen;
  String _jamMasuk = "--:--";
  String _waktuPulang = "--:--";
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _userProfile = _userRepositories.userProfileInfo();
    getCurrentDate();
    getHourAbsensi();
  }

  void getCurrentDate() {
    DateTime now = DateTime.now();
    String formatDate =
        "${now.day.toString().padLeft(2, "0")}-${now.month.toString().padLeft(2, "0")}-${now.year}";
    setState(() {
      _currentDateTime = formatDate;
      print(_currentDateTime);
    });
  }

  void getHourAbsensi() async {
    final absensiModel = await _absensiRepositories.getLastAbsensi();
    setState(() {
      _absensiModel = absensiModel;
    });

    DateTime waktuMasuk = DateTime.parse(_absensiModel!.tanggalAbsensi);

    // Mengubah zona waktu dari UTC menjadi UTC+7
    waktuMasuk = waktuMasuk.add(const Duration(hours: 7));

    // Format tanggal sesuai dengan zona waktu UTC+7
    DateFormat format = DateFormat('dd-MM-yyyy');
    String formattedDate = format.format(waktuMasuk);

    if (formattedDate == _currentDateTime) {
      setState(() {
        _jamMasuk = _absensiModel!.waktuMasuk.toString();
        _waktuPulang = _absensiModel!.waktuPulang.toString();
      });
    }
  }

  Future<void> _getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      // _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  bool _isLocationInRange() {
    // -1.602936418177061, 103.58022258385294
    const double rsudLatitude = kRsudLatitude;
    const double rsudLongitude = kRsudLongitude;
    // Ganti dengan range yang diizinkan dalam meter
    const double rangeInMeters = krangeInMeters;

    // Hitung jarak antara posisi saat ini dengan posisi rsud
    double distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      rsudLatitude,
      rsudLongitude,
    );

    // Cek apakah posisi saat ini berada dalam range yang diizinkan
    return distanceInMeters <= rangeInMeters;
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Konfirmasi pulang",
                                    style: kTextStyle.copyWith(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const Text(
                                      "Apakah kamu yakin ingin pulang?"),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Tidak"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await _getCurrentPosition();
                                        bool isRange = _isLocationInRange();

                                        if (isRange) {
                                          print(_currentPosition!.latitude);
                                          await _absensiRepositories
                                              .updateAbsensi(
                                            idAbsen: _absensiModel!.idAbsensi,
                                            latPulang: _currentPosition!
                                                .latitude
                                                .toString(),
                                            longPulang: _currentPosition!
                                                .longitude
                                                .toString(),
                                          );
                                          if (mounted) {
                                            UiUtils.setSnackbar(context,
                                                text: "Anda berhasil pulang");
                                            Navigator.pop(context);
                                          }
                                        } else {
                                          UiUtils.setSnackbar(
                                            context,
                                            text:
                                                "Anda berada di luar area lokasi yang diizinkan.",
                                          );
                                        }
                                      },
                                      child: const Text("Ya"),
                                    ),
                                  ],
                                );
                              },
                            );
                            // const PulangScreen().launch(context);
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
                  'Selamat datang, Jangan lupa absen hari ini \n $_currentDateTime',
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
