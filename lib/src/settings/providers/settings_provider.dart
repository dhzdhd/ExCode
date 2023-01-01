import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/services/cloud_store.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/settings/models/settings_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<_SettingsNotifier, SettingsModel>(
        (ref) => _SettingsNotifier(ref));

enum TabEnum {
  two('  '),
  four('    ');

  const TabEnum(this.space);
  final String space;
}

class _SettingsNotifier extends StateNotifier<SettingsModel> {
  final StateNotifierProviderRef<_SettingsNotifier, SettingsModel> ref;

  _SettingsNotifier(this.ref)
      : super(SettingsModel.fromJson(
            Map<String, dynamic>.from(box.get('settings') ??
                {
                  'tabSize': 'two',
                  'fontSize': 16.0,
                  'isLocked': false,
                  'isWordWrapped': false,
                  'isTabBarVisible': true,
                  'isFloatingRunVisible': false,
                  'isSaveOnRun': true,
                  'isSaveToCloud': false,
                })));

  Future<void> _saveToStorage(SettingsModel state) async {
    await box.put('settings', state.toJson());
  }

  Future<void> setState(SettingsModel newState) async {
    state = newState;
    await _saveToStorage(newState);
  }

  Future<void> setTabSize(TabEnum tab) async {
    final newState = state.copyWith(tabSize: tab);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> setTabBarVisibility() async {
    final newState = state.copyWith(isTabBarVisible: !state.isTabBarVisible);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> setWordWrapped() async {
    final newState = state.copyWith(isWordWrapped: !state.isWordWrapped);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> incrementFontSize() async {
    final newState = state.copyWith(fontSize: state.fontSize + 1);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> decrementFontSize() async {
    final newState = state.copyWith(fontSize: state.fontSize - 1);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> setSaveOnRun() async {
    final newState = state.copyWith(isSaveOnRun: !state.isSaveOnRun);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> setFloatingRunVisibility() async {
    final newState =
        state.copyWith(isFloatingRunVisible: !state.isFloatingRunVisible);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  Future<void> setSaveToCloud() async {
    final newState = state.copyWith(isSaveToCloud: !state.isSaveToCloud);
    state = newState;
    await _saveToStorage(newState);
    await saveToCloud(
      settings: Some(newState),
      snippets: const None(),
      ref: ref,
    );
  }

  void setLocked() {
    state = state.copyWith(isLocked: !state.isLocked);
  }
}
