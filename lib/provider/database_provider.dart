import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class DataBase {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future saveString(String key, String value) async {
    FlutterSecureStorage storage = _storage;
    storage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    FlutterSecureStorage storage = _storage;
    return storage.read(key: key);
  }

  Future deleteToken(String key) async {
    FlutterSecureStorage storage = _storage;
    await storage.delete(key: key);
  }

  Future getAllData() async {
    FlutterSecureStorage storage = _storage;
    await storage.readAll();
  }
}

class DataBaseSharedPref {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveString(String data, String key) async {
    SharedPreferences preferences = await _prefs;
    preferences.setString(key, data);
  }

  Future<String?> retrieveString(String key) async {
    SharedPreferences preferences = await _prefs;
    return preferences.getString(key);
  }

  Future<void> deleteToken() async {
    SharedPreferences preferences = await _prefs;
    await preferences.remove('token');
  }
}
