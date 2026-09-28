import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  Future<bool?> getBool(String key);
  Future<String?> getString(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool> setString(String key, String value);
  Future<bool> remove(String key);
}

class PreferencesServiceImpl implements PreferencesService {
  PreferencesServiceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool?> getBool(String key) async => _prefs.getBool(key);

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<bool> setBool(String key, bool value) async => _prefs.setBool(key, value);

  @override
  Future<bool> setString(String key, String value) async => _prefs.setString(key, value);

  @override
  Future<bool> remove(String key) async => _prefs.remove(key);
}
