import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

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
  static List<CharModel> fromJsonString(String json) {
    final List list = const JsonDecoder().convert(json);
    return list
        .map(
          (e) => CharModel(
            name: e['name'],
            value: e['value'],
            length: e['length'],
          ),
        )
        .toList();
  }

  static String toJsonString(List<CharModel> list) {
    final json = list.map(
      (e) => {
        'name': e.name,
        'value': e.value,
        'length': e.length,
      },
    );
    return const JsonEncoder().convert(json);
  }
}
