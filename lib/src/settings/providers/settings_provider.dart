import 'dart:convert';

import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/settings_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<_SettingsNotifier, SettingsModel>(
        (ref) => _SettingsNotifier());

enum TabEnum {
  two('  '),
  four('    ');

  const TabEnum(this.space);
  final String space;
}

class _SettingsNotifier extends StateNotifier<SettingsModel> {
  _SettingsNotifier()
      : super(SettingsModel.fromJson(
            Map<String, dynamic>.from(box.get('settings') ??
                {
                  'tabSize': 'two',
                  'fontSize': 16.0,
                  'isLocked': false,
                  'isWordWrapped': false,
                  'isTabBarVisible': true,
                  'isFloatingRunVisible': false,
                  'isSaveOnRun': true
                })));

  Future<void> _saveToStorage(SettingsModel state) async {
    await box.put('settings', state.toJson());
  }

  Future<void> setTabSize(TabEnum tab) async {
    final newState = state.copyWith(tabSize: tab);
    await _saveToStorage(newState);
    state = newState;
  }

  Future<void> setTabBarVisibility() async {
    final newState = state.copyWith(isTabBarVisible: !state.isTabBarVisible);
    await _saveToStorage(newState);
    state = newState;
  }

  Future<void> setWordWrapped() async {
    final newState = state.copyWith(isWordWrapped: !state.isWordWrapped);
    await _saveToStorage(newState);
    state = newState;
  }

  Future<void> incrementFontSize() async {
    final newState = state.copyWith(fontSize: state.fontSize + 1);
    await _saveToStorage(newState);
    state = newState;
  }

  Future<void> decrementFontSize() async {
    final newState = state.copyWith(fontSize: state.fontSize - 1);
    await _saveToStorage(newState);
    state = newState;
  }

  Future<void> setSaveOnRun() async {
    final newState = state.copyWith(isSaveOnRun: !state.isSaveOnRun);
    await _saveToStorage(newState);
    state = newState;
  }

  Future<void> setFloatingRunVisibility() async {
    final newState =
        state.copyWith(isFloatingRunVisible: !state.isFloatingRunVisible);
    await _saveToStorage(newState);
    state = newState;
  }

  void setLocked() {
    state = state.copyWith(isLocked: !state.isLocked);
  }
}
