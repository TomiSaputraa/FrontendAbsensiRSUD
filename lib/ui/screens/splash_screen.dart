import 'package:absensi_mattaher/ui/styles/colors.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:absensi_mattaher/repositories/user_repositories.dart';
import 'package:absensi_mattaher/ui/screens/login.dart';
import 'package:absensi_mattaher/ui/screens/user/home.dart';
import 'package:absensi_mattaher/model/user_model.dart';
import 'package:flutter_svg/svg.dart';
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
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    if (statusCode != null) {
      // Handle error status code
      print('Error status code: $statusCode');
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
              CircularProgressIndicator(color: kPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
