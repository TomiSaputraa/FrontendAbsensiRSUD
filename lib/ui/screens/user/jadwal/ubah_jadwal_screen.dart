import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class UbahJadwalScreen extends StatefulWidget {
  const UbahJadwalScreen({super.key});
  @override
  State<UbahJadwalScreen> createState() => _UbahJadwalScreenState();
}

class _UbahJadwalScreenState extends State<UbahJadwalScreen> {
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Ubah Jadwal'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Kode Shift"),
              DropdownMenu<String>(
                hintText: "Pilih kode shift baru", textStyle: kTextStyle,
                // initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries: list.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  },
                ).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
