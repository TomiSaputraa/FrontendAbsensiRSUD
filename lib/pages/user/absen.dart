import 'dart:io';

import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/user/lokasi.dart';
import 'package:absensi_mattaher/pages/user/widget/absensiButton.dart';
import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:absensi_mattaher/provider/database_provider.dart';
import 'package:absensi_mattaher/repositories/absensi_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

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
              'Lengkapi semua intruksi yang di berikan',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
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
                    print('Image file : ${imageFile.toString()}');
                    print('Image path : ${imagePath.toString()}');
                  },
                  child: absensiButton(
                      assetPath: 'assets/kamera_icon.svg', label: 'Foto'),
                ),
                GestureDetector(
                  onTap: () {
                    const LokasiScreen().launch(context);
                  },
                  child: absensiButton(
                      assetPath: 'assets/lokasi_icon.svg', label: 'Lokasi'),
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
            ElevatedButton(
              onPressed: () async {
                try {
                  // print(imagePath);
                  var idUser = await DataBase().getString('id_user');
                  var lat =
                      await DataBaseSharedPref().retrieveString('latitude');
                  var long =
                      await DataBaseSharedPref().retrieveString('longtitude');
                  var token = await DataBase().getString('token');

                  await Absensi().createAbsensi(
                    idUser: idUser,
                    latitudeMasuk: lat,
                    longtitudeMasuk: long,
                    fotoMasuk: imageFile,
                    token: token,
                  );

                  if (mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (e is DioException) {
                    if (e.response != null) {
                      print('DioError response: ${e.response}');
                    } else {
                      print('DioError request: ${e.requestOptions}');
                    }
                  }
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  kPrimaryColor,
                ),
              ),
              child: const Text('Konfirmasi'),
            )
          ],
        ),
      ),
    );
  }
}
