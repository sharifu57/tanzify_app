// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locationModal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationModal _$LocationModalFromJson(Map<String, dynamic> json) {
  return _LocationModal.fromJson(json);
}

/// @nodoc
mixin _$LocationModal {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationModalCopyWith<LocationModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationModalCopyWith<$Res> {
  factory $LocationModalCopyWith(
          LocationModal value, $Res Function(LocationModal) then) =
      _$LocationModalCopyWithImpl<$Res, LocationModal>;
  @useResult
  $Res call({int id, String? name});
}

/// @nodoc
class _$LocationModalCopyWithImpl<$Res, $Val extends LocationModal>
    implements $LocationModalCopyWith<$Res> {
  _$LocationModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationModalImplCopyWith<$Res>
    implements $LocationModalCopyWith<$Res> {
  factory _$$LocationModalImplCopyWith(
          _$LocationModalImpl value, $Res Function(_$LocationModalImpl) then) =
      __$$LocationModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? name});
}

/// @nodoc
class __$$LocationModalImplCopyWithImpl<$Res>
    extends _$LocationModalCopyWithImpl<$Res, _$LocationModalImpl>
    implements _$$LocationModalImplCopyWith<$Res> {
  __$$LocationModalImplCopyWithImpl(
      _$LocationModalImpl _value, $Res Function(_$LocationModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_$LocationModalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationModalImpl implements _LocationModal {
  const _$LocationModalImpl({required this.id, this.name});

  factory _$LocationModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationModalImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;

  @override
  String toString() {
    return 'LocationModal(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationModalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationModalImplCopyWith<_$LocationModalImpl> get copyWith =>
      __$$LocationModalImplCopyWithImpl<_$LocationModalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationModalImplToJson(
      this,
    );
  }
}

abstract class _LocationModal implements LocationModal {
  const factory _LocationModal({required final int id, final String? name}) =
      _$LocationModalImpl;

  factory _LocationModal.fromJson(Map<String, dynamic> json) =
      _$LocationModalImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$LocationModalImplCopyWith<_$LocationModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
