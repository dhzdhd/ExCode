import 'package:excode/src/settings/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeStateProvider =
    StateNotifierProvider<_ThemeModel, ThemeDataModel>((ref) => _ThemeModel());

const _accentLightColor = Color.fromARGB(255, 85, 136, 156);
const _primaryLightColor = Color.fromARGB(255, 227, 245, 255);
const _secondaryLightColor = Color.fromARGB(255, 244, 247, 255);
final lightTheme = ThemeDataModel(
  mode: CustomThemeMode.light,
  primaryColor: _primaryLightColor,
  secondaryColor: _secondaryLightColor,
  invertedColor: _primaryDarkColor,
  accentColor: _accentLightColor,
  theme: ThemeData(
    dividerTheme: DividerThemeData(color: _primaryDarkColor.withOpacity(0.5)),
    popupMenuTheme: const PopupMenuThemeData(color: _secondaryLightColor),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(backgroundColor: _primaryLightColor),
    scaffoldBackgroundColor: _secondaryLightColor,
    cardTheme: const CardTheme(color: _primaryLightColor),
    dialogTheme: const DialogTheme(
      backgroundColor: _secondaryLightColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryDarkColor,
        backgroundColor: _primaryLightColor,
        shape: const BeveledRectangleBorder(),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: _accentLightColor.withOpacity(0.15),
      selectionHandleColor: _primaryLightColor,
      cursorColor: _secondaryDarkColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryLightColor,
        foregroundColor: _primaryDarkColor,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        textStyle: const TextStyle(
          color: _secondaryDarkColor,
          fontFamily: 'Rubik',
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: _primaryLightColor,
        side: const BorderSide(color: _accentLightColor),
        foregroundColor: _primaryDarkColor,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        ((states) => states.contains(MaterialState.selected)
            ? _accentLightColor
            : _primaryDarkColor.withOpacity(0.7)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      labelStyle: TextStyle(color: _accentLightColor),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: _accentLightColor),
    colorScheme: const ColorScheme.light(
        primary: _primaryLightColor, onPrimary: _secondaryDarkColor),
    fontFamily: 'Rubik',
    useMaterial3: true,
  ),
);

const _accentDarkColor = Color.fromARGB(255, 100, 255, 218);
const _primaryDarkColor = Color.fromARGB(255, 9, 28, 50);
const _secondaryDarkColor = Color.fromARGB(255, 25, 41, 60);
final darkTheme = ThemeDataModel(
  mode: CustomThemeMode.dark,
  primaryColor: _primaryDarkColor,
  secondaryColor: _secondaryDarkColor,
  invertedColor: _primaryLightColor,
  accentColor: _accentDarkColor,
  theme: ThemeData(
    dividerTheme: DividerThemeData(color: _primaryLightColor.withOpacity(0.5)),
    popupMenuTheme: const PopupMenuThemeData(color: _secondaryDarkColor),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: _primaryDarkColor),
    scaffoldBackgroundColor: _secondaryDarkColor,
    cardTheme: const CardTheme(color: _primaryDarkColor),
    dialogTheme: const DialogTheme(
      backgroundColor: _secondaryDarkColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryLightColor,
        backgroundColor: _primaryDarkColor,
        shape: const BeveledRectangleBorder(),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: _accentDarkColor.withOpacity(0.15),
      selectionHandleColor: _primaryDarkColor,
      cursorColor: _secondaryLightColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryDarkColor,
        foregroundColor: _primaryLightColor,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        textStyle: const TextStyle(
          color: _secondaryLightColor,
          fontFamily: 'Rubik',
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: _primaryDarkColor,
        side: const BorderSide(color: _accentDarkColor),
        foregroundColor: _primaryLightColor,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        ((states) => states.contains(MaterialState.selected)
            ? _accentDarkColor
            : _primaryLightColor.withOpacity(0.7)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      labelStyle: TextStyle(color: _accentDarkColor),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: _accentDarkColor),
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
  final Color accentColor;
  final ThemeData theme;
  final CustomThemeMode mode;

  ThemeDataModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.invertedColor,
    required this.accentColor,
    required this.theme,
    required this.mode,
  });
}

enum CustomThemeMode { light, dark }

ThemeDataModel getThemeFromString(String? theme) {
  return switch (theme) {
    'dark' => darkTheme,
    'light' => lightTheme,
    _ => lightTheme,
  };
}

class _ThemeModel extends StateNotifier<ThemeDataModel> {
  _ThemeModel() : super(getThemeFromString(SettingsService.getTheme()));

  void changeTheme(CustomThemeMode mode) {
    switch (mode) {
      case CustomThemeMode.light:
        SettingsService.setTheme('light');
        state = lightTheme;
      case CustomThemeMode.dark:
        SettingsService.setTheme('dark');
        state = darkTheme;
    }
  }
}
