import 'package:shared_preferences/shared_preferences.dart';

class SaveSetting {
  static SharedPreferences? _preferences;
  static SharedPreferences? _vibrate;

  static String switchCopy = "false";
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setSwitch(bool switchName) async =>
      await _preferences?.setBool(switchCopy, switchName);
  static bool? getSwitch() => _preferences?.getBool(switchCopy);

  static String vibrate = "true";

  static Future setVibrate(bool vibrateName) async =>
      await _preferences?.setBool(vibrate, vibrateName);
  static bool? getVibrate() => _preferences?.getBool(vibrate);

  static String isgranted = "false";

  static Future granted(bool grant) async =>
      await _preferences?.setBool(isgranted, grant);
  static bool? getgranted() => _preferences?.getBool(isgranted);

  static String search = "Google";

  static Future setSearch(String searchEngine) async =>
      await _preferences?.setString(search, searchEngine);
  static String? getSearch() => _preferences?.getString(search);
}
