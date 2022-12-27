import 'package:shared_preferences/shared_preferences.dart';

class SaveSetting {
  static SharedPreferences? _preferences;

  static String switchCopy = "Autocopy";
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setSwitch(bool switchName) async =>
      await _preferences?.setBool(switchCopy, switchName);
  static bool? getSwitch() => _preferences?.getBool(switchCopy);

  static String vibrate = 'vibrate';

  static Future setVibrate(bool vibrateName) async =>
      await _preferences?.setBool(vibrate.toString(), vibrateName);
  static bool? getVibrate() => _preferences?.getBool(vibrate.toString());

  static String isgranted = "false";

  static Future granted(bool grant) async =>
      await _preferences?.setBool(isgranted, grant);
  static bool? getgranted() => _preferences?.getBool(isgranted);

  static String search = "Google";

  static Future setSearch(String searchEngine) async =>
      await _preferences?.setString(search, searchEngine);
  static String? getSearch() => _preferences?.getString(search);
}
