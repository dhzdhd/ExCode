// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'piston_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PistonModel {
  String get stdout => throw _privateConstructorUsedError;
  String get stderr => throw _privateConstructorUsedError;
  String get output => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;
  String? get signal => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PistonModelCopyWith<PistonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PistonModelCopyWith<$Res> {
  factory $PistonModelCopyWith(
          PistonModel value, $Res Function(PistonModel) then) =
      _$PistonModelCopyWithImpl<$Res, PistonModel>;
  @useResult
  $Res call(
      {String stdout, String stderr, String output, int? code, String? signal});
}

/// @nodoc
class _$PistonModelCopyWithImpl<$Res, $Val extends PistonModel>
    implements $PistonModelCopyWith<$Res> {
  _$PistonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stdout = null,
    Object? stderr = null,
    Object? output = null,
    Object? code = freezed,
    Object? signal = freezed,
  }) {
    return _then(_value.copyWith(
      stdout: null == stdout
          ? _value.stdout
          : stdout // ignore: cast_nullable_to_non_nullable
              as String,
      stderr: null == stderr
          ? _value.stderr
          : stderr // ignore: cast_nullable_to_non_nullable
              as String,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      signal: freezed == signal
          ? _value.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PistonModelImplCopyWith<$Res>
    implements $PistonModelCopyWith<$Res> {
  factory _$$PistonModelImplCopyWith(
          _$PistonModelImpl value, $Res Function(_$PistonModelImpl) then) =
      __$$PistonModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stdout, String stderr, String output, int? code, String? signal});
}

/// @nodoc
class __$$PistonModelImplCopyWithImpl<$Res>
    extends _$PistonModelCopyWithImpl<$Res, _$PistonModelImpl>
    implements _$$PistonModelImplCopyWith<$Res> {
  __$$PistonModelImplCopyWithImpl(
      _$PistonModelImpl _value, $Res Function(_$PistonModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stdout = null,
    Object? stderr = null,
    Object? output = null,
    Object? code = freezed,
    Object? signal = freezed,
  }) {
    return _then(_$PistonModelImpl(
      stdout: null == stdout
          ? _value.stdout
          : stdout // ignore: cast_nullable_to_non_nullable
              as String,
      stderr: null == stderr
          ? _value.stderr
          : stderr // ignore: cast_nullable_to_non_nullable
              as String,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      signal: freezed == signal
          ? _value.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PistonModelImpl implements _PistonModel {
  const _$PistonModelImpl(
      {required this.stdout,
      required this.stderr,
      required this.output,
      required this.code,
      required this.signal});

  @override
  final String stdout;
  @override
  final String stderr;
  @override
  final String output;
  @override
  final int? code;
  @override
  final String? signal;

  @override
  String toString() {
    return 'PistonModel(stdout: $stdout, stderr: $stderr, output: $output, code: $code, signal: $signal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PistonModelImpl &&
            (identical(other.stdout, stdout) || other.stdout == stdout) &&
            (identical(other.stderr, stderr) || other.stderr == stderr) &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.signal, signal) || other.signal == signal));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, stdout, stderr, output, code, signal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PistonModelImplCopyWith<_$PistonModelImpl> get copyWith =>
      __$$PistonModelImplCopyWithImpl<_$PistonModelImpl>(this, _$identity);
}

abstract class _PistonModel implements PistonModel {
  const factory _PistonModel(
      {required final String stdout,
      required final String stderr,
      required final String output,
      required final int? code,
      required final String? signal}) = _$PistonModelImpl;

  @override
  String get stdout;
  @override
  String get stderr;
  @override
  String get output;
  @override
  int? get code;
  @override
  String? get signal;
  @override
  @JsonKey(ignore: true)
  _$$PistonModelImplCopyWith<_$PistonModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
