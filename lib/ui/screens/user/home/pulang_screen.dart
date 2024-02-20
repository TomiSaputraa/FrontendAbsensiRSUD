import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/constants.dart';
import '../../../styles/colors.dart';

class PulangScreen extends StatefulWidget {
  const PulangScreen({super.key});
  @override
  State<PulangScreen> createState() => _PulangScreenState();
}

class _PulangScreenState extends State<PulangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: "Pulang"),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              child: Column(
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: kSecondaryColor,
                    ),
                    child: Text("JADWAL PULANG",
                        style: kTextStyle.copyWith(fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jam saat ini : 16:20",
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
            SizedBox(height: 16),
            // Text("Kamu belum bisa absen pulang"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Batal")),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Konfirmasi")),
              ],
            )
          ],
        ),
      )),
    );
  }
}
