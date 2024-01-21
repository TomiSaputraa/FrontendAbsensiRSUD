import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:flutter/material.dart';

class LokasiScreen extends StatefulWidget {
  const LokasiScreen({super.key});
  @override
  State<LokasiScreen> createState() => _LokasiScreenState();
}

class _LokasiScreenState extends State<LokasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Lokasi'),
      // body: ,
    );
  }
}
