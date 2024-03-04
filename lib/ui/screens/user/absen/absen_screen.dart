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

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});
  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  bool isFotoDone = false;

  final ImagePicker _imagePicker = ImagePicker();
  File imageFile = File('No data');
  String imagePath = 'No image path';
  XFile? pickedImage;

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
                      // DataBaseSharedPref().saveString(imagePath, 'image_path');
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
                  onTap: () {
                    const LokasiScreen().launch(context);
                  },
                  child: absensiButton(
                      assetPath: UiUtils.getImagesPath('lokasi_icon.svg'),
                      label: 'Lokasi'),
                ),
              ],
            ),
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
                        'Gagal',
                        style: kTextStyle,
                      ),
              ],
            ),
            wKonfirmasiButton(
              function: () async {
                try {
                  if (imagePath.length < 20) {
                    print("object");
                    return;
                  }
                  log("value");
                  // print(imagePath);
                  var idUser = await DataBase().storageGetString('id_user');
                  var lat = await DataBase().prefGetString('latitude');
                  var long = await DataBase().prefGetString('longtitude');
                  var token = await DataBase().storageGetString('token');

                  await AbsensiRepositories().createAbsensi(
                    idUser: idUser!,
                    latitudeMasuk: lat!,
                    longtitudeMasuk: long!,
                    fotoMasuk: imageFile,
                    token: token,
                  );

                  if (mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (e is DioException) {
                    if (e.response != null) {
                      debugPrint('DioError response: ${e.response}');
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
