import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeStateProvider =
    StateNotifierProvider<_ThemeModel, ThemeData>((ref) => _ThemeModel());

class _ThemeModel extends StateNotifier<ThemeData> {
  _ThemeModel()
      : super(ThemeMode.system == ThemeMode.dark
            ? ThemeData(fontFamily: 'FiraCode')
            : ThemeData.light());

  void changeTheme() {
    state = ThemeData(fontFamily: 'FiraCode', useMaterial3: true);
  }
}
