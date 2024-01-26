import 'package:absensi_mattaher/pages/user/absensi_screen.dart';
import 'package:absensi_mattaher/pages/user/cubits/user_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.response});
  final Map? response;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<UserDetailsCubit>().fetchUserDetails();
    super.initState();
  }

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
                          const AbsensiPage().launch(context);
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
      decoration: const BoxDecoration(
        color: Color(0xFFE7B312),
        borderRadius: BorderRadius.only(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/foto.png'),
                ),
                const SizedBox(width: 12),
                BlocBuilder<UserDetailsCubit, UserDetailsState>(
                  builder: (context, state) {
                    if (state is UserDetailsFetchInSucces) {
                      return Text(
                        state.userProfile.namaLengkap.toString(),
                        maxLines: 1,
                        style: kTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF083B7F),
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
            Text(
              'Selamat datang, Jangan lupa absen hari ini',
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
