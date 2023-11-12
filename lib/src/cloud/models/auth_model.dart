import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_model.freezed.dart';
// part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required User? user,
  }) = _AuthModel;

  // factory AuthModel.fromJson(Map<String, dynamic> json) =>
  //     _$AuthModelFromJson(json);
}
