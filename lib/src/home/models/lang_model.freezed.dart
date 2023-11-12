// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  String get ext => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LangModelCopyWith<LangModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangModelCopyWith<$Res> {
  factory $LangModelCopyWith(LangModel value, $Res Function(LangModel) then) =
      _$LangModelCopyWithImpl<$Res, LangModel>;
  @useResult
  $Res call(
      {Mode mode, String name, Language lang, String template, String ext});
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
    Object? ext = null,
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
      ext: null == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LangModelImplCopyWith<$Res>
    implements $LangModelCopyWith<$Res> {
  factory _$$LangModelImplCopyWith(
          _$LangModelImpl value, $Res Function(_$LangModelImpl) then) =
      __$$LangModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Mode mode, String name, Language lang, String template, String ext});
}

/// @nodoc
class __$$LangModelImplCopyWithImpl<$Res>
    extends _$LangModelCopyWithImpl<$Res, _$LangModelImpl>
    implements _$$LangModelImplCopyWith<$Res> {
  __$$LangModelImplCopyWithImpl(
      _$LangModelImpl _value, $Res Function(_$LangModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? name = null,
    Object? lang = null,
    Object? template = null,
    Object? ext = null,
  }) {
    return _then(_$LangModelImpl(
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
      ext: null == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LangModelImpl implements _LangModel {
  const _$LangModelImpl(
      {required this.mode,
      required this.name,
      required this.lang,
      required this.template,
      required this.ext});

  @override
  final Mode mode;
  @override
  final String name;
  @override
  final Language lang;
  @override
  final String template;
  @override
  final String ext;

  @override
  String toString() {
    return 'LangModel(mode: $mode, name: $name, lang: $lang, template: $template, ext: $ext)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LangModelImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.ext, ext) || other.ext == ext));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode, name, lang, template, ext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LangModelImplCopyWith<_$LangModelImpl> get copyWith =>
      __$$LangModelImplCopyWithImpl<_$LangModelImpl>(this, _$identity);
}

abstract class _LangModel implements LangModel {
  const factory _LangModel(
      {required final Mode mode,
      required final String name,
      required final Language lang,
      required final String template,
      required final String ext}) = _$LangModelImpl;

  @override
  Mode get mode;
  @override
  String get name;
  @override
  Language get lang;
  @override
  String get template;
  @override
  String get ext;
  @override
  @JsonKey(ignore: true)
  _$$LangModelImplCopyWith<_$LangModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
