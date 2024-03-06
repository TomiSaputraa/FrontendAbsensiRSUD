import 'package:absensi_mattaher/model/absensi_model.dart';
import 'package:absensi_mattaher/repositories/absensi_repositories.dart';
import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/ui/widgets/konfirmasi_button.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../styles/colors.dart';

const List<String> list = <String>[
  'L',
  'P1',
  'P2',
  'J',
  'J1',
  'SB',
  'SB1',
  'SB3',
  'S1',
  'N'
];

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});
  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  // static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;

  final AbsensiRepositories _absensiRepositories = AbsensiRepositories();
  Future<AbsensiModel>? _absensi;
  String? _curentDateTime;
  int idAbsensi = 0;
  String kodeShift = "";
  String _jamMasuk = "-";
  String _waktuPulang = "-";
  String tanggalAbsen = "";

  @override
  void initState() {
    super.initState();
    _absensi = _absensiRepositories.getLastAbsensi();
    getCurrentDate();
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
            DateTime.parse(absensi.absensi[0].tanggalAbsensi.toString());
        DateFormat format = DateFormat('dd-MM-yyyy');
        String formatedDate = format.format(waktuMasuk); //result : 04-03-2024
        // print("absensi function ${formatedDate}");

        // pengecekan apakah ada tanggal absensi yang sama saat ini dengan tanggal sistem
        if (formatedDate == _curentDateTime) {
          setState(() {
            idAbsensi = absensi.absensi[0].idAbsensi!.toInt();
            kodeShift = absensi.absensi[0].kodeShift.toString();
            _jamMasuk = absensi.absensi[0].waktuMasuk.toString();
            _waktuPulang = absensi.absensi[0].waktuPulang.toString();
            tanggalAbsen = absensi.absensi[0].tanggalAbsensi.toString();
          });
        }
      },
    );
  }

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
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Update kode shift absen",
                        style: kTextStyle.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize
                              .min, // auto height content secara vertikal
                          children: [
                            DropdownMenu<String>(
                              hintText: "Pilih kode shift baru",
                              textStyle: kTextStyle,
                              initialSelection: kodeShift,
                              onSelected: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownMenuEntries:
                                  list.map<DropdownMenuEntry<String>>(
                                (String value) {
                                  return DropdownMenuEntry<String>(
                                    value: value,
                                    label: value,
                                  );
                                },
                              ).toList(),
                            ),
                            const SizedBox(height: 16),
                            wKonfirmasiButton(function: () async {
                              try {
                                await _absensiRepositories.updateAbsensi(
                                    kodeShift: dropdownValue,
                                    idAbsen: idAbsensi);

                                if (mounted) {
                                  UiUtils.setSnackbar(context,
                                      text: "Update kode shift berhasil");
                                  Navigator.pop(context);
                                }
                              } on DioException catch (e) {
                                UiUtils.setSnackbar(
                                  context,
                                  text:
                                      "${e.response!.statusCode.toString()} : Waktu login sudah berakhir",
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: kPrimaryColor,
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kode Shift : $kodeShift",
                                style: kTextStyle.copyWith(fontSize: 16)),
                            Text("Waktu Masuk : $_jamMasuk",
                                style: kTextStyle.copyWith(fontSize: 16)),
                            Text("Waktu Pulang : $_waktuPulang",
                                style: kTextStyle.copyWith(fontSize: 16)),
                            Text("Tanggal : $tanggalAbsen",
                                style: kTextStyle.copyWith(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
