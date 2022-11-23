// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'char_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CharModel {
  String get name => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CharModelCopyWith<CharModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharModelCopyWith<$Res> {
  factory $CharModelCopyWith(CharModel value, $Res Function(CharModel) then) =
      _$CharModelCopyWithImpl<$Res>;
  $Res call({String name, String value, int length});
}

/// @nodoc
class _$CharModelCopyWithImpl<$Res> implements $CharModelCopyWith<$Res> {
  _$CharModelCopyWithImpl(this._value, this._then);

  final CharModel _value;
  // ignore: unused_field
  final $Res Function(CharModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
    Object? length = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_CharModelCopyWith<$Res> implements $CharModelCopyWith<$Res> {
  factory _$$_CharModelCopyWith(
          _$_CharModel value, $Res Function(_$_CharModel) then) =
      __$$_CharModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, String value, int length});
}

/// @nodoc
class __$$_CharModelCopyWithImpl<$Res> extends _$CharModelCopyWithImpl<$Res>
    implements _$$_CharModelCopyWith<$Res> {
  __$$_CharModelCopyWithImpl(
      _$_CharModel _value, $Res Function(_$_CharModel) _then)
      : super(_value, (v) => _then(v as _$_CharModel));

  @override
  _$_CharModel get _value => super._value as _$_CharModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
    Object? length = freezed,
  }) {
    return _then(_$_CharModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CharModel implements _CharModel {
  const _$_CharModel(
      {required this.name, required this.value, required this.length});

  @override
  final String name;
  @override
  final String value;
  @override
  final int length;

  @override
  String toString() {
    return 'CharModel(name: $name, value: $value, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CharModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.length, length));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(length));

  @JsonKey(ignore: true)
  @override
  _$$_CharModelCopyWith<_$_CharModel> get copyWith =>
      __$$_CharModelCopyWithImpl<_$_CharModel>(this, _$identity);
}

abstract class _CharModel implements CharModel {
  const factory _CharModel(
      {required final String name,
      required final String value,
      required final int length}) = _$_CharModel;

  @override
  String get name;
  @override
  String get value;
  @override
  int get length;
  @override
  @JsonKey(ignore: true)
  _$$_CharModelCopyWith<_$_CharModel> get copyWith =>
      throw _privateConstructorUsedError;
}
