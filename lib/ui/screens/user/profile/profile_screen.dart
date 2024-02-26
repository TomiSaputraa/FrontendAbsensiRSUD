import 'package:absensi_mattaher/ui/screens/user/profile/history_absensi_screen.dart';
import 'package:absensi_mattaher/ui/screens/user/profile/update_profil_screen.dart';
import 'package:absensi_mattaher/ui/styles/colors.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: Text(
          "Profil",
          style: kTextStyle.copyWith(color: kPrimaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 40,
                        backgroundImage:
                            AssetImage(UiUtils.getImagesPath('foto.png')),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tomi saputra",
                            style: kTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "Administrasi",
                            style: kTextStyle.copyWith(
                                fontSize: 14, color: kGreyColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      UiUtils.getImagesPath("profil/211604_email_icon.svg"),
                      width: 25,
                      height: 25,
                      colorFilter:
                          const ColorFilter.mode(kGreyColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "tomi@gmail.com",
                      style:
                          kTextStyle.copyWith(fontSize: 14, color: kGreyColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        UiUtils.getImagesPath(
                            "profil/211829_telephone_icon.svg"),
                        width: 25,
                        height: 25,
                        colorFilter:
                            const ColorFilter.mode(kGreyColor, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "082219891089",
                        style: kTextStyle.copyWith(
                            fontSize: 14, color: kGreyColor),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        UiUtils.getImagesPath("profil/update_icon.svg"),
                        width: 27,
                        height: 27,
                        colorFilter: const ColorFilter.mode(
                            kPrimaryColor, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          const UpdateProfilScreen().launch(context);
                        },
                        child: Text(
                          "Update Profil",
                          style: kTextStyle.copyWith(
                              color: kPrimaryColor, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        UiUtils.getImagesPath("profil/352426_history_icon.svg"),
                        width: 27,
                        height: 27,
                        colorFilter: const ColorFilter.mode(
                            kPrimaryColor, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          const HistoryScreen().launch(context);
                        },
                        child: Text("Riwayat absensi",
                            style: kTextStyle.copyWith(
                                color: kPrimaryColor, fontSize: 15)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        UiUtils.getImagesPath(
                            "profil/2639921_shutdown_icon.svg"),
                        width: 27,
                        height: 27,
                        colorFilter:
                            const ColorFilter.mode(kRedColor, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text("Keluar",
                          style: kTextStyle.copyWith(
                              color: kRedColor, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
