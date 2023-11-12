// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FileModelImpl _$$FileModelImplFromJson(Map<String, dynamic> json) =>
    _$FileModelImpl(
      name: json['name'] as String,
      content: json['content'] as String,
      language: json['language'] as String,
      ext: json['ext'] as String,
      path: Uri.parse(json['path'] as String),
    );

Map<String, dynamic> _$$FileModelImplToJson(_$FileModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
      'language': instance.language,
      'ext': instance.ext,
      'path': instance.path.toString(),
    };
