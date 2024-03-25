import 'dart:io';

import 'package:absensi_mattaher/ui/styles/colors.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:absensi_mattaher/repositories/user_repositories.dart';
import 'package:absensi_mattaher/ui/screens/login.dart';
import 'package:absensi_mattaher/ui/screens/user/home.dart';
import 'package:absensi_mattaher/model/user_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserRepositories _userResponse = UserRepositories();
  late Future<UserProfile> _userProfile;
  int? statusCode;

  @override
  void initState() {
    super.initState();
    _userProfile = _userResponse.userProfileInfo().catchError((error) {
      setState(() {
        statusCode = error;
      });
    });
    detectMockLocation();
    init();
  }

  // Handle permission
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      UiUtils.setSnackbar(context,
          text: "Lokasi tidak di aktifkan, mohon aktifkan!");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        UiUtils.setSnackbar(context, text: "Permintaan lokasi ditolak");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      UiUtils.setSnackbar(context,
          text: "Lokasi ditolak permanen, mohon hidupkan izin lokasi");
      return false;
    }
    return true;
  }

  Future<void> detectMockLocation() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      UiUtils.setSnackbar(context, text: "Izin lokasi ditolak");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Deteksi fake GPS
    if (position.isMocked) {
      // Inisialisasi plugin push notification
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      // Konfigurasi untuk Android
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Tampilkan push notification sebelum keluar
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'channel_id', 'Notifikasi Absensi',
          importance: Importance.max, priority: Priority.high);
      var platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Peringatan',
        'Anda menggunakan lokasi palsu. Aplikasi akan keluar.',
        platformChannelSpecifics,
      );

      await Future.delayed(const Duration(seconds: 2));
      exit(0);
    }
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    if (statusCode != null) {
      // Handle error status code
      log('Error status code: $statusCode');
    } else {
      _userProfile.then((value) {
        // Navigasi ke halaman home jika pemanggilan berhasil
        const Home().launch(context, isNewTask: true);
      }).catchError((error) {
        // Navigasi ke halaman login jika terjadi kesalahan
        const LoginScreen().launch(context, isNewTask: true);
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 220,
                width: 220,
                child: SvgPicture.asset(
                  UiUtils.getImagesPath('logo rs.svg'),
                  fit: BoxFit.cover,
                ),
              ),
              const CircularProgressIndicator(color: kPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
