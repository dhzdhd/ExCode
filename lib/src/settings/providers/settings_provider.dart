import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/settings_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<_SettingsNotifier, SettingsModel>(
        (ref) => _SettingsNotifier());
// final tabSpaceProvider = StateNotifierProvider<_TabSpaceNotifier, TabEnum>(
//     (ref) => _TabSpaceNotifier());
// final fontSizeProvider = StateNotifierProvider<_FontSizeNotifier, double>(
//     (ref) => _FontSizeNotifier());
// final saveOnRunProvider = StateNotifierProvider<_SaveOnRunNotifier, bool>(
//     (ref) => _SaveOnRunNotifier());
// final lockProvider =
//     StateNotifierProvider<_LockNotifier, bool>((ref) => _LockNotifier());
// final tabVisibilityProvider =
//     StateNotifierProvider<_TabVisibilityNotifier, bool>(
//         (ref) => _TabVisibilityNotifier());
// final floatingRunVisibilityProvider =
//     StateNotifierProvider<_FloatingRunVisibilityNotifier, bool>(
//         (ref) => _FloatingRunVisibilityNotifier());

class _SettingsNotifier extends StateNotifier<SettingsModel> {
  _SettingsNotifier()
      : super(SettingsModel.fromJson(
            Map<String, dynamic>.from(box.get('settings') ??
                {
                  'tabSize': TabEnum.two,
                  'fontSize': 16,
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

class _OldSettingsNotifier extends StateNotifier<bool> {
  _OldSettingsNotifier() : super(box.get('wordwrap') ?? false);

  void setWordWrapped() {
    box.put('wordwrap', !state);
    state = !state;
  }
}

enum TabEnum {
  two('  '),
  four('    ');

  const TabEnum(this.space);
  final String space;
}

class _TabSpaceNotifier extends StateNotifier<TabEnum> {
  _TabSpaceNotifier()
      : super(getTabFromString(box.get('tab') ?? TabEnum.two.name));

  static TabEnum getTabFromString(String tab) {
    return tab == TabEnum.two.name ? TabEnum.two : TabEnum.four;
  }

  Future<void> setTabSpace(TabEnum tab) async {
    await box.put('tab', tab.name);
    state = tab;
  }
}

class _FontSizeNotifier extends StateNotifier<double> {
  _FontSizeNotifier() : super(box.get('fontSize') ?? 16);

  Future<void> increment() async {
    state += 1;
    await box.put('fontSize', state);
  }

  Future<void> decrement() async {
    state -= 1;
    await box.put('fontSize', state);
  }
}

class _SaveOnRunNotifier extends StateNotifier<bool> {
  _SaveOnRunNotifier() : super(box.get('saveonrun') ?? true);

  void setSaveOnRun() {
    box.put('saveonrun', !state);
    state = !state;
  }
}

class _LockNotifier extends StateNotifier<bool> {
  _LockNotifier() : super(false);

  void setLock() {
    state = !state;
  }
}

class _TabVisibilityNotifier extends StateNotifier<bool> {
  _TabVisibilityNotifier() : super(box.get('tabVisibility') ?? true);

  void setTabVisibility() {
    box.put('tabVisibility', !state);
    state = !state;
  }
}

class _FloatingRunVisibilityNotifier extends StateNotifier<bool> {
  _FloatingRunVisibilityNotifier()
      : super(box.get('floatingRunVisibility') ?? false);

  void setFloatingRunVisibility() {
    box.put('floatingRunVisibility', !state);
    state = !state;
  }
}
