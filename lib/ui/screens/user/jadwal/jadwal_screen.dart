// ignore_for_file: prefer_const_constructors

import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});
  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Ubah Jadwal'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pilih jadwal yang akan anda ubah hari ini",
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF083B7F),
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: kSecondaryColor,
                      ),
                      child: Text("JADWAL HARI INI",
                          style: kTextStyle.copyWith(fontSize: 16)),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kode Shift : P1",
                              style: kTextStyle.copyWith(fontSize: 16)),
                          Text("Waktu Masuk : 07:00",
                              style: kTextStyle.copyWith(fontSize: 16)),
                          Text("Waktu Pulang : 17:00",
                              style: kTextStyle.copyWith(fontSize: 16)),
                          Text("Tanggal : 12-04-2024",
                              style: kTextStyle.copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
