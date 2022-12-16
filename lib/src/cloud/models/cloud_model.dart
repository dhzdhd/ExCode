import 'package:excode/src/settings/models/settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cloud_model.freezed.dart';
part 'cloud_model.g.dart';

@freezed
class CloudModel with _$CloudModel {
  const factory CloudModel({
    required SettingsModel settings,
  }) = _CloudModel;

  factory CloudModel.fromJson(Map<String, dynamic> json) =>
      _$CloudModelFromJson(json);
}
