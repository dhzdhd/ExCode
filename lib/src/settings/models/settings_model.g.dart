// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      tabSize: $enumDecode(_$TabEnumEnumMap, json['tabSize']),
      fontSize: (json['fontSize'] as num).toDouble(),
      isLocked: json['isLocked'] as bool,
      isWordWrapped: json['isWordWrapped'] as bool,
      isTabBarVisible: json['isTabBarVisible'] as bool,
      isFloatingRunVisible: json['isFloatingRunVisible'] as bool,
      isSaveOnRun: json['isSaveOnRun'] as bool,
      isSaveToCloud: json['isSaveToCloud'] as bool,
      isSentryEnabled: json['isSentryEnabled'] as bool,
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'tabSize': _$TabEnumEnumMap[instance.tabSize]!,
      'fontSize': instance.fontSize,
      'isLocked': instance.isLocked,
      'isWordWrapped': instance.isWordWrapped,
      'isTabBarVisible': instance.isTabBarVisible,
      'isFloatingRunVisible': instance.isFloatingRunVisible,
      'isSaveOnRun': instance.isSaveOnRun,
      'isSaveToCloud': instance.isSaveToCloud,
      'isSentryEnabled': instance.isSentryEnabled,
    };

const _$TabEnumEnumMap = {
  TabEnum.two: 'two',
  TabEnum.four: 'four',
};
