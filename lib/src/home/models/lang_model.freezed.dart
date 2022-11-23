// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lang_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LangModel {
  Mode get mode => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Languages get lang => throw _privateConstructorUsedError;
  String get baseCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LangModelCopyWith<LangModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangModelCopyWith<$Res> {
  factory $LangModelCopyWith(LangModel value, $Res Function(LangModel) then) =
      _$LangModelCopyWithImpl<$Res>;
  $Res call({Mode mode, String name, Languages lang, String baseCode});
}

/// @nodoc
class _$LangModelCopyWithImpl<$Res> implements $LangModelCopyWith<$Res> {
  _$LangModelCopyWithImpl(this._value, this._then);

  final LangModel _value;
  // ignore: unused_field
  final $Res Function(LangModel) _then;

  @override
  $Res call({
    Object? mode = freezed,
    Object? name = freezed,
    Object? lang = freezed,
    Object? baseCode = freezed,
  }) {
    return _then(_value.copyWith(
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as Mode,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as Languages,
      baseCode: baseCode == freezed
          ? _value.baseCode
          : baseCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LangModelCopyWith<$Res> implements $LangModelCopyWith<$Res> {
  factory _$$_LangModelCopyWith(
          _$_LangModel value, $Res Function(_$_LangModel) then) =
      __$$_LangModelCopyWithImpl<$Res>;
  @override
  $Res call({Mode mode, String name, Languages lang, String baseCode});
}

/// @nodoc
class __$$_LangModelCopyWithImpl<$Res> extends _$LangModelCopyWithImpl<$Res>
    implements _$$_LangModelCopyWith<$Res> {
  __$$_LangModelCopyWithImpl(
      _$_LangModel _value, $Res Function(_$_LangModel) _then)
      : super(_value, (v) => _then(v as _$_LangModel));

  @override
  _$_LangModel get _value => super._value as _$_LangModel;

  @override
  $Res call({
    Object? mode = freezed,
    Object? name = freezed,
    Object? lang = freezed,
    Object? baseCode = freezed,
  }) {
    return _then(_$_LangModel(
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as Mode,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as Languages,
      baseCode: baseCode == freezed
          ? _value.baseCode
          : baseCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LangModel implements _LangModel {
  const _$_LangModel(
      {required this.mode,
      required this.name,
      required this.lang,
      required this.baseCode});

  @override
  final Mode mode;
  @override
  final String name;
  @override
  final Languages lang;
  @override
  final String baseCode;

  @override
  String toString() {
    return 'LangModel(mode: $mode, name: $name, lang: $lang, baseCode: $baseCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LangModel &&
            const DeepCollectionEquality().equals(other.mode, mode) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.lang, lang) &&
            const DeepCollectionEquality().equals(other.baseCode, baseCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(mode),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(lang),
      const DeepCollectionEquality().hash(baseCode));

  @JsonKey(ignore: true)
  @override
  _$$_LangModelCopyWith<_$_LangModel> get copyWith =>
      __$$_LangModelCopyWithImpl<_$_LangModel>(this, _$identity);
}

abstract class _LangModel implements LangModel {
  const factory _LangModel(
      {required final Mode mode,
      required final String name,
      required final Languages lang,
      required final String baseCode}) = _$_LangModel;

  @override
  Mode get mode;
  @override
  String get name;
  @override
  Languages get lang;
  @override
  String get baseCode;
  @override
  @JsonKey(ignore: true)
  _$$_LangModelCopyWith<_$_LangModel> get copyWith =>
      throw _privateConstructorUsedError;
}
