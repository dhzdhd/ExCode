import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'output_model.freezed.dart';

@freezed
class OutputModel with _$OutputModel {
  const factory OutputModel({
    required String output,
    required String error,
  }) = _OutputModel;
}
