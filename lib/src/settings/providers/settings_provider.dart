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
  _SettingsNotifier() : super(_SettingsModel(isWordWrapped: false));

  void setWordWrapped() {
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
  _TabSpaceNotifier() : super(TabEnum.two); // ! Get from local storage

  void setTabSpace(TabEnum tab) {
    state = tab;
  }
}
