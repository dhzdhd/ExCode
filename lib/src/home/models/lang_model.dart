import 'package:excode/src/home/services/api.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:highlight/highlight.dart';

part 'lang_model.freezed.dart';

@freezed
class LangModel with _$LangModel {
  const factory LangModel({
    required Mode mode,
    required String name,
    required Languages lang,
    required String baseCode,
  }) = _LangModel;
}
