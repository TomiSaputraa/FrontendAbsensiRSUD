import 'package:absensi_mattaher/ui/widgets/appbar.dart';
import 'package:absensi_mattaher/services/database_services.dart';
import 'package:absensi_mattaher/ui/widgets/konfirmasi_button.dart';
import 'package:absensi_mattaher/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../utils/constants/constants.dart';
import '../../../styles/colors.dart';

class LokasiScreen extends StatefulWidget {
  const LokasiScreen({super.key});
  @override
  State<LokasiScreen> createState() => _LokasiScreenState();
}

class _LokasiScreenState extends State<LokasiScreen> {
  // String? _currentAddress;
  Position? _currentPosition;

  // Handle permission
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      UiUtils.setSnackbar(context,
          text: "Lokasi tidak di aktifkan, mohon aktifkan!");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        UiUtils.setSnackbar(context, text: "Permintaan lokasi ditolak");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      UiUtils.setSnackbar(context,
          text: "Lokasi ditolak permanen, mohon hidupkan izin lokasi");
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      // _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       // _currentAddress =
  //       //     '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar(context, text: 'Lokasi'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  color: kSecondaryColor,
                  child: const Center(
                    child: Text(
                      'Lokasi terkini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Lat : ${_currentPosition?.latitude.toString() ?? ''}',
                  style: kTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  'Lng : ${_currentPosition?.longitude.toString() ?? ''}',
                  style: kTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              UiUtils.setSnackbar(context,
                  text: "Proses mendapatkan lokasi harap tunggu...");
              await _getCurrentPosition();

              String? lat = _currentPosition?.latitude.toString();
              String? long = _currentPosition?.longitude.toString();
              print('lat $lat');
              print('long $long');

              DataBase().prefSetString(lat!, 'latitude');
              DataBase().prefSetString(long!, 'longtitude');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                kPrimaryColor.withOpacity(0.5),
              ),
            ),
            child: const Text(
              'Dapatkan Lokasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          wKonfirmasiButton(function: () async {
            var getDatabaselat = await DataBase().prefGetString('latitude');
            var getDatabaselong = await DataBase().prefGetString('longtitude');

            print('latitude: $getDatabaselat');
            print('longtitude: $getDatabaselong');

            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
