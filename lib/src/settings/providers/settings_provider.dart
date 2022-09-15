import 'package:excode/src/factory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider = StateNotifierProvider<_SettingsNotifier, bool>(
    (ref) => _SettingsNotifier());
final tabSpaceProvider = StateNotifierProvider<_TabSpaceNotifier, TabEnum>(
    (ref) => _TabSpaceNotifier());
final fontSizeProvider = StateNotifierProvider<_FontSizeNotifier, double>(
    (ref) => _FontSizeNotifier());
final saveOnRunProvider = StateNotifierProvider<_SaveOnRunNotifier, bool>(
    (ref) => _SaveOnRunNotifier());
final lockProvider =
    StateNotifierProvider<_LockNotifier, bool>((ref) => _LockNotifier());

class _SettingsNotifier extends StateNotifier<bool> {
  _SettingsNotifier() : super(box.get('wordwrap') ?? false);

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

  Future<void> setFontSize(double size) async {
    await box.put('fontSize', size);
    state = size;
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
