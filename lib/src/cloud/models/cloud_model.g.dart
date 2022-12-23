// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CloudModel _$$_CloudModelFromJson(Map<String, dynamic> json) =>
    _$_CloudModel(
      settings:
          SettingsModel.fromJson(json['settings'] as Map<String, dynamic>),
      snippets: (json['snippets'] as List<dynamic>)
          .map((e) => SnippetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CloudModelToJson(_$_CloudModel instance) =>
    <String, dynamic>{
      'settings': instance.settings,
      'snippets': instance.snippets,
    };
