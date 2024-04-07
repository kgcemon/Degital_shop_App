import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  static sharedPreferencesGet<String>(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("$key");
  }

  static sharedPreferencesSet(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, "$value");
  }

  static sharedPreferencesRemove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
