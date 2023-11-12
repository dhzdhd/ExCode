// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloudModelImpl _$$CloudModelImplFromJson(Map<String, dynamic> json) =>
    _$CloudModelImpl(
      settings:
          SettingsModel.fromJson(json['settings'] as Map<String, dynamic>),
      snippets: (json['snippets'] as List<dynamic>)
          .map((e) => SnippetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CloudModelImplToJson(_$CloudModelImpl instance) =>
    <String, dynamic>{
      'settings': instance.settings,
      'snippets': instance.snippets,
    };
