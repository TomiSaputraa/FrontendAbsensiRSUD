import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/constants/constants.dart';

Widget absensiButton({String? assetPath, String? label}) {
  return Container(
    height: 117,
    width: 130,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment(-0.83, -0.56),
        end: Alignment(0.83, 0.56),
        colors: [Color(0xFFF2E1A3), Color(0xFFDAB0FA)],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          '$assetPath',
          color: kPrimaryColor,
        ),
        Text(
          '$label',
          style: const TextStyle(
            fontSize: 16,
            color: kPrimaryColor,
          ),
        )
      ],
    ),
  );
}
