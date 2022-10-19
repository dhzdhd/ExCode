import 'dart:convert';

abstract class CloudModel {
  String toJsonString();
}

class CloudSettingsModel implements CloudModel {
  CloudSettingsModel();

  @override
  String toJsonString() {
    return '';
  }

  static CloudModel fromJsonString() {
    return CloudSettingsModel();
  }
}

class CloudCodeModel implements CloudModel {
  final String lang;
  final String content;

  CloudCodeModel({required this.lang, required this.content});

  @override
  String toJsonString() {
    final map = {'lang': lang, 'content': content};
    return const JsonEncoder().convert(map);
  }

  static CloudModel fromJsonString(String json) {
    final map = const JsonDecoder().convert(json);
    return CloudCodeModel(lang: map['lang'], content: map['content']);
  }
}
