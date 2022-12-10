import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required TabEnum tabSize,
    required double fontSize,
    required bool isLocked, // ! Find a way to prevent serialisation
    required bool isWordWrapped,
    required bool isTabBarVisible,
    required bool isFloatingRunVisible,
    required bool isSaveOnRun,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
