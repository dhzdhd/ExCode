import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:highlight/highlight.dart';

part 'lang_model.freezed.dart';

@freezed
class LangModel with _$LangModel {
  const factory LangModel({
    required Mode mode,
    required String name,
  }) = _LangModel;
}
