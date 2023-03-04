// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FileModel _$$_FileModelFromJson(Map<String, dynamic> json) => _$_FileModel(
      name: json['name'] as String,
      content: json['content'] as String,
      language: json['language'] as String,
      ext: json['ext'] as String,
      path: Uri.parse(json['path'] as String),
    );

Map<String, dynamic> _$$_FileModelToJson(_$_FileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
      'language': instance.language,
      'ext': instance.ext,
      'path': instance.path.toString(),
    };
