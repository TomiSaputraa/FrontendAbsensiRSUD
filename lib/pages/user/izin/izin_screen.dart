import 'dart:math';

import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:absensi_mattaher/pages/user/widget/konfirmasiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});
  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _dateStartController.text = "";
    _dateEndController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Izin'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _dateStartController,
                readOnly: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Tanggal mulai',
                  hintText: 'Tanggal mulai izin',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2080),
                  );

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formateDate =
                        DateFormat('yyyy-MM-ddTHH:mm:sssZ').format(pickedDate);
                    setState(() {
                      _dateStartController.text = formateDate;
                    });
                  }
                },
              ),
              TextField(
                controller: _dateEndController,
                readOnly: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Tanggal selesai',
                  hintText: 'Tanggal selesai izin',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2080),
                  );

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formateDate =
                        DateFormat('yyyy-MM-ddTHH:mm:sssZ').format(pickedDate);
                    setState(() {
                      _dateEndController.text = formateDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Alasan',
                  enabledBorder: OutlineInputBorder(),
                ),
                maxLength: 255,
              ),
              wKonfirmasiButton(
                function: () {
                  print('Print berhasil guys');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
