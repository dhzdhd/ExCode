import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'char_model.freezed.dart';

@freezed
class CharModel with _$CharModel {
  const factory CharModel({
    required String name,
    required String value,
  }) = _CharModel;
}
