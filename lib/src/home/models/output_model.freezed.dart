// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'output_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OutputModel {
  String get output => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OutputModelCopyWith<OutputModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputModelCopyWith<$Res> {
  factory $OutputModelCopyWith(
          OutputModel value, $Res Function(OutputModel) then) =
      _$OutputModelCopyWithImpl<$Res, OutputModel>;
  @useResult
  $Res call({String output, String error});
}

/// @nodoc
class _$OutputModelCopyWithImpl<$Res, $Val extends OutputModel>
    implements $OutputModelCopyWith<$Res> {
  _$OutputModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutputModelImplCopyWith<$Res>
    implements $OutputModelCopyWith<$Res> {
  factory _$$OutputModelImplCopyWith(
          _$OutputModelImpl value, $Res Function(_$OutputModelImpl) then) =
      __$$OutputModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String output, String error});
}

/// @nodoc
class __$$OutputModelImplCopyWithImpl<$Res>
    extends _$OutputModelCopyWithImpl<$Res, _$OutputModelImpl>
    implements _$$OutputModelImplCopyWith<$Res> {
  __$$OutputModelImplCopyWithImpl(
      _$OutputModelImpl _value, $Res Function(_$OutputModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = null,
    Object? error = null,
  }) {
    return _then(_$OutputModelImpl(
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OutputModelImpl implements _OutputModel {
  const _$OutputModelImpl({required this.output, required this.error});

  @override
  final String output;
  @override
  final String error;

  @override
  String toString() {
    return 'OutputModel(output: $output, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutputModelImpl &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, output, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutputModelImplCopyWith<_$OutputModelImpl> get copyWith =>
      __$$OutputModelImplCopyWithImpl<_$OutputModelImpl>(this, _$identity);
}

abstract class _OutputModel implements OutputModel {
  const factory _OutputModel(
      {required final String output,
      required final String error}) = _$OutputModelImpl;

  @override
  String get output;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$OutputModelImplCopyWith<_$OutputModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
