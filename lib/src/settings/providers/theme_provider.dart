import 'package:excode/src/settings/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeStateProvider =
    StateNotifierProvider<_ThemeModel, ThemeDataModel>((ref) => _ThemeModel());

const accentColor = Color.fromARGB(255, 238, 108, 77);

const _primaryLightColor = Color.fromARGB(255, 215, 227, 252);
const _secondaryLightColor = Color.fromARGB(255, 244, 247, 255);
final lightTheme = ThemeDataModel(
  primaryColor: _primaryLightColor,
  secondaryColor: _secondaryLightColor,
  invertedColor: _primaryDarkColor,
  theme: ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(backgroundColor: _primaryLightColor),
    scaffoldBackgroundColor: _secondaryLightColor,
    cardTheme: const CardTheme(color: _primaryLightColor),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(_primaryDarkColor),
        backgroundColor: MaterialStateProperty.all(_primaryLightColor),
        splashFactory: InkRipple.splashFactory,
        shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
      ),
    ),
    colorScheme: const ColorScheme.light(
        primary: _primaryLightColor, onPrimary: _secondaryDarkColor),
    fontFamily: 'Rubik',
    useMaterial3: true,
  ),
);

const _primaryDarkColor = Color.fromARGB(255, 9, 28, 50);
const _secondaryDarkColor = Color.fromARGB(255, 25, 41, 60);
final darkTheme = ThemeDataModel(
  primaryColor: _primaryDarkColor,
  secondaryColor: _secondaryDarkColor,
  invertedColor: _primaryLightColor,
  theme: ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: _primaryDarkColor),
    scaffoldBackgroundColor: _secondaryDarkColor,
    cardTheme: const CardTheme(color: _primaryDarkColor),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(_primaryLightColor),
        backgroundColor: MaterialStateProperty.all(_primaryDarkColor),
        splashFactory: InkRipple.splashFactory,
        shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
      ),
    ),
    colorScheme: const ColorScheme.dark(
        primary: _primaryDarkColor, onPrimary: _secondaryLightColor),
    fontFamily: 'Rubik',
    useMaterial3: true,
  ),
);

class ThemeDataModel {
  final Color primaryColor;
  final Color secondaryColor;
  final Color invertedColor;
  final ThemeData theme;

  ThemeDataModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.invertedColor,
    required this.theme,
  });
}

ThemeDataModel getThemeFromString(String? theme) {
  return theme == null
      ? ThemeMode.system == ThemeMode.dark
          ? darkTheme
          : lightTheme
      : theme == 'dark'
          ? darkTheme
          : lightTheme;
}

class _ThemeModel extends StateNotifier<ThemeDataModel> {
  _ThemeModel() : super(getThemeFromString(SettingsService.getTheme()));

  void changeTheme(ThemeMode mode) {
    if (mode == ThemeMode.light) {
      SettingsService.setTheme('light');
      state = lightTheme;
    } else {
      SettingsService.setTheme('dark');
      state = darkTheme;
    }
  }
}
