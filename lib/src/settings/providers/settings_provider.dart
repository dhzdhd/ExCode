import 'package:excode/src/factory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<_SettingsNotifier, _SettingsModel>(
        ((ref) => _SettingsNotifier()));
final tabSpaceProvider = StateNotifierProvider<_TabSpaceNotifier, TabEnum>(
    (ref) => _TabSpaceNotifier());

class _SettingsModel {
  final bool isWordWrapped;

  _SettingsModel({required this.isWordWrapped});
}

class _SettingsNotifier extends StateNotifier<_SettingsModel> {
  _SettingsNotifier()
      : super(_SettingsModel(isWordWrapped: box.get('wordwrap') ?? false));

  void setWordWrapped() {
    box.put('wordwrap', !state.isWordWrapped);
    state = _SettingsModel(isWordWrapped: !state.isWordWrapped);
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
