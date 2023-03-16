// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InputModel _$InputModelFromJson(Map<String, dynamic> json) {
  return _InputModel.fromJson(json);
}

/// @nodoc
mixin _$InputModel {
  String get stdInArgs => throw _privateConstructorUsedError;
  String get cmdLineArgs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InputModelCopyWith<InputModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputModelCopyWith<$Res> {
  factory $InputModelCopyWith(
          InputModel value, $Res Function(InputModel) then) =
      _$InputModelCopyWithImpl<$Res, InputModel>;
  @useResult
  $Res call({String stdInArgs, String cmdLineArgs});
}

/// @nodoc
class _$InputModelCopyWithImpl<$Res, $Val extends InputModel>
    implements $InputModelCopyWith<$Res> {
  _$InputModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stdInArgs = null,
    Object? cmdLineArgs = null,
  }) {
    return _then(_value.copyWith(
      stdInArgs: null == stdInArgs
          ? _value.stdInArgs
          : stdInArgs // ignore: cast_nullable_to_non_nullable
              as String,
      cmdLineArgs: null == cmdLineArgs
          ? _value.cmdLineArgs
          : cmdLineArgs // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InputModelCopyWith<$Res>
    implements $InputModelCopyWith<$Res> {
  factory _$$_InputModelCopyWith(
          _$_InputModel value, $Res Function(_$_InputModel) then) =
      __$$_InputModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String stdInArgs, String cmdLineArgs});
}

/// @nodoc
class __$$_InputModelCopyWithImpl<$Res>
    extends _$InputModelCopyWithImpl<$Res, _$_InputModel>
    implements _$$_InputModelCopyWith<$Res> {
  __$$_InputModelCopyWithImpl(
      _$_InputModel _value, $Res Function(_$_InputModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stdInArgs = null,
    Object? cmdLineArgs = null,
  }) {
    return _then(_$_InputModel(
      stdInArgs: null == stdInArgs
          ? _value.stdInArgs
          : stdInArgs // ignore: cast_nullable_to_non_nullable
              as String,
      cmdLineArgs: null == cmdLineArgs
          ? _value.cmdLineArgs
          : cmdLineArgs // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InputModel implements _InputModel {
  const _$_InputModel({required this.stdInArgs, required this.cmdLineArgs});

  factory _$_InputModel.fromJson(Map<String, dynamic> json) =>
      _$$_InputModelFromJson(json);

  @override
  final String stdInArgs;
  @override
  final String cmdLineArgs;

  @override
  String toString() {
    return 'InputModel(stdInArgs: $stdInArgs, cmdLineArgs: $cmdLineArgs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InputModel &&
            (identical(other.stdInArgs, stdInArgs) ||
                other.stdInArgs == stdInArgs) &&
            (identical(other.cmdLineArgs, cmdLineArgs) ||
                other.cmdLineArgs == cmdLineArgs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stdInArgs, cmdLineArgs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InputModelCopyWith<_$_InputModel> get copyWith =>
      __$$_InputModelCopyWithImpl<_$_InputModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InputModelToJson(
      this,
    );
  }
}

abstract class _InputModel implements InputModel {
  const factory _InputModel(
      {required final String stdInArgs,
      required final String cmdLineArgs}) = _$_InputModel;

  factory _InputModel.fromJson(Map<String, dynamic> json) =
      _$_InputModel.fromJson;

  @override
  String get stdInArgs;
  @override
  String get cmdLineArgs;
  @override
  @JsonKey(ignore: true)
  _$$_InputModelCopyWith<_$_InputModel> get copyWith =>
      throw _privateConstructorUsedError;
}
