import 'package:absensi_mattaher/repositories/cuti_repositories.dart';
import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../widgets/konfirmasi_button.dart';

class CutiScreen extends StatefulWidget {
  const CutiScreen({super.key});
  @override
  State<CutiScreen> createState() => _CutiScreenState();
}

class _CutiScreenState extends State<CutiScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();

  CutiRepositories cutiRepositories = CutiRepositories();

  @override
  void initState() {
    _dateStartController.text = "";
    _dateEndController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: "Cuti"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                TextField(
                  controller: _dateStartController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Tanggal mulai',
                    hintText: 'Tanggal mulai izin',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2080),
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formateDate = DateFormat('yyyy-MM-ddTHH:mm:sssZ')
                          .format(pickedDate);
                      setState(() {
                        _dateStartController.text = formateDate;
                      });
                    }
                  },
                ),
                TextField(
                  controller: _dateEndController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Tanggal selesai',
                    hintText: 'Tanggal selesai izin',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2080),
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formateDate = DateFormat('yyyy-MM-ddTHH:mm:sssZ')
                          .format(pickedDate);
                      setState(() {
                        _dateEndController.text = formateDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _alasanController,
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Alasan',
                    enabledBorder: OutlineInputBorder(),
                  ),
                  maxLength: 255,
                ),
                wKonfirmasiButton(function: () {
                  if (_alasanController.text.isNotEmpty) {
                    print('Print berhasil guys nih');
                    print(_dateStartController.text);
                    print(_dateEndController.text);
                    String dateString1 = _dateStartController.text;
                    String dateString2 = _dateEndController.text;

                    DateTime date1 =
                        DateFormat('yyyy-MM-dd').parse(dateString1);
                    DateTime date2 =
                        DateFormat('yyyy-MM-dd').parse(dateString2);

                    if (date1.isBefore(date2) || date1 == date2) {
                      // Hitung selisih hari
                      int differenceInDays = date2.difference(date1).inDays;
                      print("total : $differenceInDays");

                      cutiRepositories.createCuti(
                        tanggalMulai: _dateStartController.text,
                        tanggalSelesai: _dateEndController.text,
                        alasan: _alasanController.text,
                        totalHari: differenceInDays.toInt() + 1,
                      );

                      if (mounted) {
                        UiUtils.setSnackbar(context,
                            text: "Izin baru berhasil dibuat");
                        Navigator.pop(context);
                      }
                    } else {
                      // Tampilkan pesan kesalahan jika tanggal mulai tidak berada di bawah tanggal selesai
                      UiUtils.setSnackbar(context,
                          text: "Tanggal mulai harus sebelum tanggal selesai");
                    }
                  } else {
                    UiUtils.setSnackbar(context,
                        text: "Tidak boleh ado yang kosong");
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
