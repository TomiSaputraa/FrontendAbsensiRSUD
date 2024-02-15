import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';
import '../styles/colors.dart';

ElevatedButton wKonfirmasiButton({Function? function}) {
  return ElevatedButton(
    onPressed: function as void Function(),
    style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        kPrimaryColor,
      ),
    ),
    child: Text(
      'Konfirmasi',
      style: kTextStyle.copyWith(color: Colors.white),
    ),
  );
}
