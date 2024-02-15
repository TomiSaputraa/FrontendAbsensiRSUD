import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/ui/widgets/konfirmasiButton.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});
  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();
  bool _dateStartIsFilled = false;
  bool _dateEndIsFilled = false;

  @override
  void initState() {
    _dateStartController.text = "";
    _dateEndController.text = "";
    _dateStartIsFilled = false;
    _dateEndIsFilled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Izin'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2080),
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formateDate = DateFormat('yyyy-MM-ddTHH:mm:sssZ')
                          .format(pickedDate);
                      setState(() {
                        _dateStartController.text = formateDate;
                        _dateStartIsFilled = true;
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
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2080),
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formateDate = DateFormat('yyyy-MM-ddTHH:mm:sssZ')
                          .format(pickedDate);
                      setState(() {
                        _dateEndController.text = formateDate;
                        _dateEndIsFilled = true;
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
                wKonfirmasiButton(
                  function: _dateStartIsFilled & _dateEndIsFilled
                      ? () {
                          if (_alasanController.text.isNotEmpty) {
                            print('Print berhasil guys nih');
                            print(_dateStartController.text);
                            print(_dateEndController.text);
                          } else {
                            UiUtils.setSnackbar(context,
                                text: "Alasan tidak boleh kosong");
                            print("Alasan tidak boleh kosong");
                          }
                        }
                      : () {
                          print("Tidak boleh ada data yang kosong");
                        },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
