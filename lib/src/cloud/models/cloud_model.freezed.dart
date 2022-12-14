// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  $Res call({SettingsModel settings});

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
  }) {
    return _then(_value.copyWith(
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
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
  $Res call({SettingsModel settings});

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
  }) {
    return _then(_$_CloudModel(
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CloudModel implements _CloudModel {
  const _$_CloudModel({required this.settings});

  factory _$_CloudModel.fromJson(Map<String, dynamic> json) =>
      _$$_CloudModelFromJson(json);

  @override
  final SettingsModel settings;

  @override
  String toString() {
    return 'CloudModel(settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CloudModel &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, settings);

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
  const factory _CloudModel({required final SettingsModel settings}) =
      _$_CloudModel;

  factory _CloudModel.fromJson(Map<String, dynamic> json) =
      _$_CloudModel.fromJson;

  @override
  SettingsModel get settings;
  @override
  @JsonKey(ignore: true)
  _$$_CloudModelCopyWith<_$_CloudModel> get copyWith =>
      throw _privateConstructorUsedError;
}
