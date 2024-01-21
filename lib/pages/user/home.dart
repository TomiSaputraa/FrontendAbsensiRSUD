import 'package:absensi_mattaher/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});
  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 50),
              Container(
                height: 112,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      height: 80,
                      width: 57,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/user/absensi',
                          );
                          print("Hallo button absensi : $context");
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/icon _fingerprint.svg'),
                            const Text(
                              'Absensi',
                              style: TextStyle(
                                color: Color(0xFF083B7F),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Constants.kPrimaryColor,
        unselectedItemColor: Constants.kPrimaryColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home_icon.svg',
              color: Constants.kPrimaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icon_profil_.svg',
                color: Constants.kPrimaryColor),
            label: 'Profil',
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
      decoration: const BoxDecoration(
        color: Color(0xFFE7B312),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/foto.png'),
                ),
                SizedBox(width: 12),
                Text(
                  'Tomi saputra',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF083B7F),
                  ),
                )
              ],
            ),
            Text(
              'Selamat datang, Jangan lupa absen hari ini',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
