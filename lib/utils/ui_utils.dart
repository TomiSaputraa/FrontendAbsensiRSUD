import 'package:flutter/material.dart';

import '../ui/styles/colors.dart';
import 'constants/constants.dart';

class UiUtils {
  static void setSnackbar(BuildContext context, {String? text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: kSecondaryColor,
        content: Text(text!),
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 1),
        backgroundColor: kPrimaryColor.withOpacity(0.85),
        elevation: 2.0,
      ),
    );
  }

  static String getImagesPath(String imageName) {
    return "assets/images/$imageName";
  }
}
