import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<_SettingsNotifier, _SettingsModel>(
        ((ref) => _SettingsNotifier()));

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
