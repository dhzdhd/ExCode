import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'char_model.freezed.dart';

@freezed
class CharModel with _$CharModel {
  const factory CharModel({
    required String name,
    required String value,
    required int length,
  }) = _CharModel;
}

extension CharModelSerialisable on CharModel {
  static CharModel fromJsonString(String json) {
    final map = const JsonDecoder().convert(json);
    return CharModel(
        name: map['name'], value: map['value'], length: map['length']);
  }

  String toJson() {
    final map = {'name': name, 'value': value, 'length': length};
    return const JsonEncoder().convert(map);
  }
}
