import 'dart:io';

import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../widgets/konfirmasi_button.dart';

class SakitScreen extends StatefulWidget {
  const SakitScreen({super.key});
  @override
  State<SakitScreen> createState() => _SakitScreenState();
}

class _SakitScreenState extends State<SakitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  File imageFile = File('No data');
  String imagePath = 'No image path';
  XFile? pickedImage;

  @override
  void initState() {
    _dateStartController.text = "";
    _dateEndController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: "Sakit"),
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
                Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                      ),
                      child: IconButton(
                        onPressed: () {
                          print("Add gambar button");
                        },
                        icon: SvgPicture.asset(
                          UiUtils.getImagesPath('addimage_icon.svg'),
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text('Tambah gambar')
                  ],
                ),
                const SizedBox(height: 20),
                wKonfirmasiButton(function: () {
                  if (_alasanController.text.isNotEmpty) {
                    print('Print berhasil guys nih');
                    print(_dateStartController.text);
                    print(_dateEndController.text);
                  } else {
                    UiUtils.setSnackbar(context,
                        text: "dak boleh ado yang kosong");
                    print("Alasan tidak boleh kosong");
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
