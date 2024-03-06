// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snippet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnippetModel _$SnippetModelFromJson(Map<String, dynamic> json) {
  return _SnippetModel.fromJson(json);
}

/// @nodoc
mixin _$SnippetModel {
  String get name => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SnippetModelCopyWith<SnippetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnippetModelCopyWith<$Res> {
  factory $SnippetModelCopyWith(
          SnippetModel value, $Res Function(SnippetModel) then) =
      _$SnippetModelCopyWithImpl<$Res, SnippetModel>;
  @useResult
  $Res call({String name, String value, int length});
}

/// @nodoc
class _$SnippetModelCopyWithImpl<$Res, $Val extends SnippetModel>
    implements $SnippetModelCopyWith<$Res> {
  _$SnippetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? length = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnippetModelImplCopyWith<$Res>
    implements $SnippetModelCopyWith<$Res> {
  factory _$$SnippetModelImplCopyWith(
          _$SnippetModelImpl value, $Res Function(_$SnippetModelImpl) then) =
      __$$SnippetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String value, int length});
}

/// @nodoc
class __$$SnippetModelImplCopyWithImpl<$Res>
    extends _$SnippetModelCopyWithImpl<$Res, _$SnippetModelImpl>
    implements _$$SnippetModelImplCopyWith<$Res> {
  __$$SnippetModelImplCopyWithImpl(
      _$SnippetModelImpl _value, $Res Function(_$SnippetModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? length = null,
  }) {
    return _then(_$SnippetModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnippetModelImpl implements _SnippetModel {
  const _$SnippetModelImpl(
      {required this.name, required this.value, required this.length});

  factory _$SnippetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnippetModelImplFromJson(json);

  @override
  final String name;
  @override
  final String value;
  @override
  final int length;

  @override
  String toString() {
    return 'SnippetModel(name: $name, value: $value, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnippetModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, value, length);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SnippetModelImplCopyWith<_$SnippetModelImpl> get copyWith =>
      __$$SnippetModelImplCopyWithImpl<_$SnippetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnippetModelImplToJson(
      this,
    );
  }
}

abstract class _SnippetModel implements SnippetModel {
  const factory _SnippetModel(
      {required final String name,
      required final String value,
      required final int length}) = _$SnippetModelImpl;

  factory _SnippetModel.fromJson(Map<String, dynamic> json) =
      _$SnippetModelImpl.fromJson;

  @override
  String get name;
  @override
  String get value;
  @override
  int get length;
  @override
  @JsonKey(ignore: true)
  _$$SnippetModelImplCopyWith<_$SnippetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
