import 'package:flutter/material.dart';

import '../../../utils/constants/constants.dart';

ElevatedButton wKonfirmasiButton({required Function function}) {
  return ElevatedButton(
    onPressed: () {
      function();
    },
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
