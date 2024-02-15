import 'package:flutter/material.dart';
import '../styles/colors.dart';

AppBar wAppBar(BuildContext context, {String? text}) {
  return AppBar(
    backgroundColor: kSecondaryColor,
    leading: BackButton(color: Theme.of(context).primaryColor),
    title: Text(
      '$text',
      style: TextStyle(color: Theme.of(context).primaryColor),
    ),
    centerTitle: true,
  );
}
