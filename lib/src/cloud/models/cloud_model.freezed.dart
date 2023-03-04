// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CloudModel _$CloudModelFromJson(Map<String, dynamic> json) {
  return _CloudModel.fromJson(json);
}

/// @nodoc
mixin _$CloudModel {
  SettingsModel get settings => throw _privateConstructorUsedError;
  List<SnippetModel> get snippets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CloudModelCopyWith<CloudModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudModelCopyWith<$Res> {
  factory $CloudModelCopyWith(
          CloudModel value, $Res Function(CloudModel) then) =
      _$CloudModelCopyWithImpl<$Res, CloudModel>;
  @useResult
  $Res call({SettingsModel settings, List<SnippetModel> snippets});

  $SettingsModelCopyWith<$Res> get settings;
}

/// @nodoc
class _$CloudModelCopyWithImpl<$Res, $Val extends CloudModel>
    implements $CloudModelCopyWith<$Res> {
  _$CloudModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? snippets = null,
  }) {
    return _then(_value.copyWith(
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
      snippets: null == snippets
          ? _value.snippets
          : snippets // ignore: cast_nullable_to_non_nullable
              as List<SnippetModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SettingsModelCopyWith<$Res> get settings {
    return $SettingsModelCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CloudModelCopyWith<$Res>
    implements $CloudModelCopyWith<$Res> {
  factory _$$_CloudModelCopyWith(
          _$_CloudModel value, $Res Function(_$_CloudModel) then) =
      __$$_CloudModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SettingsModel settings, List<SnippetModel> snippets});

  @override
  $SettingsModelCopyWith<$Res> get settings;
}

/// @nodoc
class __$$_CloudModelCopyWithImpl<$Res>
    extends _$CloudModelCopyWithImpl<$Res, _$_CloudModel>
    implements _$$_CloudModelCopyWith<$Res> {
  __$$_CloudModelCopyWithImpl(
      _$_CloudModel _value, $Res Function(_$_CloudModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? snippets = null,
  }) {
    return _then(_$_CloudModel(
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
      snippets: null == snippets
          ? _value._snippets
          : snippets // ignore: cast_nullable_to_non_nullable
              as List<SnippetModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CloudModel implements _CloudModel {
  const _$_CloudModel(
      {required this.settings, required final List<SnippetModel> snippets})
      : _snippets = snippets;

  factory _$_CloudModel.fromJson(Map<String, dynamic> json) =>
      _$$_CloudModelFromJson(json);

  @override
  final SettingsModel settings;
  final List<SnippetModel> _snippets;
  @override
  List<SnippetModel> get snippets {
    if (_snippets is EqualUnmodifiableListView) return _snippets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_snippets);
  }

  @override
  String toString() {
    return 'CloudModel(settings: $settings, snippets: $snippets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CloudModel &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            const DeepCollectionEquality().equals(other._snippets, _snippets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, settings, const DeepCollectionEquality().hash(_snippets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CloudModelCopyWith<_$_CloudModel> get copyWith =>
      __$$_CloudModelCopyWithImpl<_$_CloudModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CloudModelToJson(
      this,
    );
  }
}

abstract class _CloudModel implements CloudModel {
  const factory _CloudModel(
      {required final SettingsModel settings,
      required final List<SnippetModel> snippets}) = _$_CloudModel;

  factory _CloudModel.fromJson(Map<String, dynamic> json) =
      _$_CloudModel.fromJson;

  @override
  SettingsModel get settings;
  @override
  List<SnippetModel> get snippets;
  @override
  @JsonKey(ignore: true)
  _$$_CloudModelCopyWith<_$_CloudModel> get copyWith =>
      throw _privateConstructorUsedError;
}
