import 'package:freezed_annotation/freezed_annotation.dart';

part 'piston_model.freezed.dart';

@freezed
class PistonModel with _$PistonModel {
  const factory PistonModel({
    required String stdout,
    required String stderr,
    required String output,
    required int? code,
    required String? signal,
  }) = _PistonModel;
}
