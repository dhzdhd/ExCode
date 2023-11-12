import 'package:excode/src/factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class SettingsService {
  static String getTheme() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return box.get('theme') ?? (isDarkMode ? 'dark' : 'light');
  }

  static Future<void> setTheme(String theme) async {
    /// Accepts dark or light only
    await box.put('theme', theme);
  }
}
