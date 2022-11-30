import 'package:freezed_annotation/freezed_annotation.dart';

part 'char_model.freezed.dart';
part 'char_model.g.dart';

@freezed
class CharModel with _$CharModel {
  const factory CharModel({
    required String name,
    required String value,
    required int length,
  }) = _CharModel;

  factory CharModel.fromJson(Map<String, dynamic> json) =>
      _$CharModelFromJson(json);
}
