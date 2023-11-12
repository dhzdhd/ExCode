import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static late final SharedPreferences _prefs;

  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getTheme() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return _prefs.getString('theme') ?? (isDarkMode ? 'dark' : 'light');
  }

  static Future<void> setTheme(String theme) async {
    /// Accepts dark or light only
    await _prefs.setString('theme', theme);
  }
}
