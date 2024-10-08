import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class DataBase {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Flutter secure storage
  Future storageSaveString(String key, String value) async {
    FlutterSecureStorage storage = _storage;
    storage.write(key: key, value: value);
  }

  Future<String?> storageGetString(String key) async {
    FlutterSecureStorage storage = _storage;
    return storage.read(key: key);
  }

  Future storageGetAll() async {
    FlutterSecureStorage storage = _storage;
    await storage.readAll();
  }

  Future storageDeleteToken(String key) async {
    FlutterSecureStorage storage = _storage;
    await storage.delete(key: key);
  }

  Future storageDeleteAll() async {
    FlutterSecureStorage storage = _storage;
    await storage.deleteAll();
  }

  // Shared preferences
  void prefSetString(String data, String key) async {
    SharedPreferences preferences = await _prefs;
    preferences.setString(key, data);
  }

  void prefSetBool(String key, bool value) async {
    SharedPreferences preferences = await _prefs;
    preferences.setBool(key, value);
  }

  Future<String?> prefGetString(String key) async {
    SharedPreferences preferences = await _prefs;
    return preferences.getString(key);
  }

  Future<bool?> prefGetBool(String key) async {
    SharedPreferences preferences = await _prefs;
    return preferences.getBool(key);
  }

  /// Fungsi ini menghapus data key dan value dari sharedprefences yang tersimpan
  Future<void> prefRemoveToken(String key) async {
    SharedPreferences preferences = await _prefs;
    await preferences.remove(key);
  }

  Future<void> prefRemovesAllToken() async {
    SharedPreferences preferences = await _prefs;
    await preferences.clear();
  }
}
