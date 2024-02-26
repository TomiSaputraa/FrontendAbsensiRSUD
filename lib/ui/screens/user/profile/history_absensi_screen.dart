import 'package:absensi_mattaher/ui/styles/colors.dart';
import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: "Riwayat"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Riwayat Absensi :",
                style: kTextStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
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
                        child: Text("Sakit",
                            style: kTextStyle.copyWith(fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kode Shift : -",
                                style: kTextStyle.copyWith(fontSize: 16)),
                            Text("Waktu Masuk : -",
                                style: kTextStyle.copyWith(fontSize: 16)),
                            Text("Waktu Pulang : -",
                                style: kTextStyle.copyWith(fontSize: 16)),
                            Text("Tanggal : 12-04-2024",
                                style: kTextStyle.copyWith(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
