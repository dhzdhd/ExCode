import 'package:excode/src/home/services/api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:highlight/highlight.dart';

part 'lang_model.freezed.dart';

@freezed
class LangModel with _$LangModel {
  const factory LangModel({
    required Mode mode,
    required String name,
    required Language lang,
    required String template,
    required String ext,
    // required String ext,
  }) = _LangModel;
}
