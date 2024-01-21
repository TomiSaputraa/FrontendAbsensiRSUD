import 'dart:io';

import 'package:absensi_mattaher/constans.dart';
import 'package:absensi_mattaher/pages/user/widget/absensiButton.dart';
import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});
  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  File? imageFile;

  void getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? imagePicked = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    imageFile = File(imagePicked!.path);

    // Dapatkan hanya nama file dari path
    String fileName = path.basename(imageFile!.path);
    setState(() {});
    print(fileName);
  }

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
                color: Constants.kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: absensiButton(
                      assetPath: 'assets/kamera_icon.svg', label: 'Foto'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user/absen/lokasi');
                  },
                  child: absensiButton(
                      assetPath: 'assets/lokasi_icon.svg', label: 'Lokasi'),
                ),
              ],
            ),
            imageFile != null
                ? Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
            ElevatedButton(
              onPressed: () {
                print('Konfirmasi');
              },
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Constants.kPrimaryColor),
              ),
              child: const Text('Konfirmasi'),
            )
          ],
        ),
      ),
    );
  }
}
