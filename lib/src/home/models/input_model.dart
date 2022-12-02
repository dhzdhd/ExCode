import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_model.freezed.dart';
part 'input_model.g.dart';

@freezed
class InputModel with _$InputModel {
  const factory InputModel({
    required String stdInArgs,
    required String cmdLineArgs,
  }) = _InputModel;

  factory InputModel.fromJson(Map<String, dynamic> json) =>
      _$InputModelFromJson(json);
}
