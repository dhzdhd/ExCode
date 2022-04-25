import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static late final SharedPreferences prefs;

  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String getTheme() {
    return prefs.getString('theme') ?? 'light';
  }

  static Future<void> setTheme(String theme) async {
    /// Accepts dark or light only
    await prefs.setString('theme', theme);
  }
}
