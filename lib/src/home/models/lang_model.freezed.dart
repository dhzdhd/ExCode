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
  Language get lang => throw _privateConstructorUsedError;
  String get template => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LangModelCopyWith<LangModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangModelCopyWith<$Res> {
  factory $LangModelCopyWith(LangModel value, $Res Function(LangModel) then) =
      _$LangModelCopyWithImpl<$Res, LangModel>;
  @useResult
  $Res call({Mode mode, String name, Language lang, String template});
}

/// @nodoc
class _$LangModelCopyWithImpl<$Res, $Val extends LangModel>
    implements $LangModelCopyWith<$Res> {
  _$LangModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? name = null,
    Object? lang = null,
    Object? template = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as Mode,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as Language,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LangModelCopyWith<$Res> implements $LangModelCopyWith<$Res> {
  factory _$$_LangModelCopyWith(
          _$_LangModel value, $Res Function(_$_LangModel) then) =
      __$$_LangModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Mode mode, String name, Language lang, String template});
}

/// @nodoc
class __$$_LangModelCopyWithImpl<$Res>
    extends _$LangModelCopyWithImpl<$Res, _$_LangModel>
    implements _$$_LangModelCopyWith<$Res> {
  __$$_LangModelCopyWithImpl(
      _$_LangModel _value, $Res Function(_$_LangModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? name = null,
    Object? lang = null,
    Object? template = null,
  }) {
    return _then(_$_LangModel(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as Mode,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as Language,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
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
      required this.template});

  @override
  final Mode mode;
  @override
  final String name;
  @override
  final Language lang;
  @override
  final String template;

  @override
  String toString() {
    return 'LangModel(mode: $mode, name: $name, lang: $lang, template: $template)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LangModel &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.template, template) ||
                other.template == template));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode, name, lang, template);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LangModelCopyWith<_$_LangModel> get copyWith =>
      __$$_LangModelCopyWithImpl<_$_LangModel>(this, _$identity);
}

abstract class _LangModel implements LangModel {
  const factory _LangModel(
      {required final Mode mode,
      required final String name,
      required final Language lang,
      required final String template}) = _$_LangModel;

  @override
  Mode get mode;
  @override
  String get name;
  @override
  Language get lang;
  @override
  String get template;
  @override
  @JsonKey(ignore: true)
  _$$_LangModelCopyWith<_$_LangModel> get copyWith =>
      throw _privateConstructorUsedError;
}
