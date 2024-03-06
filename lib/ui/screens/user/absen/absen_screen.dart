import 'dart:io';
import 'package:absensi_mattaher/ui/screens/user/absen/lokasi_screen.dart';
import 'package:absensi_mattaher/ui/widgets/absensi_button.dart';
import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/services/database_services.dart';
import 'package:absensi_mattaher/repositories/absensi_repositories.dart';
import 'package:absensi_mattaher/ui/widgets/konfirmasi_button.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/constants/constants.dart';
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

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});
  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  bool isFotoDone = false;
  bool isLokasiDone = false;

  final ImagePicker _imagePicker = ImagePicker();
  File imageFile = File('No data');
  String imagePath = 'No image path';
  XFile? pickedImage;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Absen'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Lengkapi semua intruksi yang di berikan!',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    pickedImage = await _imagePicker.pickImage(
                        source: ImageSource.camera);
                    setState(() {
                      imageFile = File(pickedImage!.path);
                      imagePath = pickedImage!.path;
                      isFotoDone = !isFotoDone;
                    });
                    debugPrint('Image file : ${imageFile.toString()}');
                    debugPrint('Image path : ${imagePath.toString()}');
                  },
                  child: absensiButton(
                      assetPath: UiUtils.getImagesPath('kamera_icon.svg'),
                      label: 'Foto'),
                ),
                GestureDetector(
                  onTap: () async {
                    // Navigasi ke halama berikutnya
                    bool result = await const LokasiScreen().launch(context);
                    setState(() {
                      isLokasiDone = result;
                    });
                  },
                  child: absensiButton(
                      assetPath: UiUtils.getImagesPath('lokasi_icon.svg'),
                      label: 'Lokasi'),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Pilih kode shift :",
                  style: kTextStyle,
                ),
                SizedBox(
                  width: 100,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    style: const TextStyle(color: kPrimaryColor),
                    underline: Container(
                      height: 2,
                      color: kPrimaryColor,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Foto : ',
                      style: kTextStyle,
                    ),
                    isFotoDone == true
                        ? Text(
                            'Berhasil',
                            style: kTextStyle,
                          )
                        : Text(
                            'Belum ada foto',
                            style: kTextStyle,
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lokasi : ',
                      style: kTextStyle,
                    ),
                    isLokasiDone
                        ? Text(
                            'Berhasil',
                            style: kTextStyle,
                          )
                        : Text(
                            'Belum ada lokasi',
                            style: kTextStyle,
                          ),
                  ],
                ),
              ],
            ),
            wKonfirmasiButton(
              function: () async {
                try {
                  // print(imagePath.length);
                  // Validasi foto
                  if (imagePath.isEmpty || imagePath == 'No image path') {
                    UiUtils.setSnackbar(context,
                        text: "Foto tidak boleh kosong");
                    return;
                  }

                  // validasi lokasi
                  if (!isLokasiDone) {
                    UiUtils.setSnackbar(context,
                        text: "Lokasi tidak boleh kosong");
                    return;
                  }

                  var lat = await DataBase().prefGetString('latitude');
                  var long = await DataBase().prefGetString('longitude');

                  await AbsensiRepositories().createAbsensi(
                    kodeShift: dropdownValue,
                    latitudeMasuk: lat.toString(),
                    longitudeMasuk: long.toString(),
                    fotoMasuk: imageFile,
                  );

                  if (mounted) {
                    DataBase().prefRemoveToken("latitude");
                    DataBase().prefRemoveToken("longtitude");
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (e is DioException) {
                    if (e.response != null) {
                      debugPrint('DioError response: ${e.response}');
                      UiUtils.setSnackbar(context,
                          text: e.response!.statusCode.toString());
                    } else {
                      debugPrint('DioError request: ${e.requestOptions}');
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
