import 'package:freezed_annotation/freezed_annotation.dart';

part 'snippet_model.freezed.dart';
part 'snippet_model.g.dart';

@freezed
class SnippetModel with _$SnippetModel {
  const factory SnippetModel({
    required String name,
    required String value,
    required int length,
  }) = _SnippetModel;

  factory SnippetModel.fromJson(Map<String, dynamic> json) =>
      _$SnippetModelFromJson(json);
}
