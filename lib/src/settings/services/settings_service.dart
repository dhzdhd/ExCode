import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static late final SharedPreferences _prefs;

  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getTheme() {
    return _prefs.getString('theme') ?? 'light';
  }

  static Future<void> setTheme(String theme) async {
    /// Accepts dark or light only
    await _prefs.setString('theme', theme);
  }
}
