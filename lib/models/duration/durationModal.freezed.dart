// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'durationModal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DurationModal _$DurationModalFromJson(Map<String, dynamic> json) {
  return _DurationModal.fromJson(json);
}

/// @nodoc
mixin _$DurationModal {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DurationModalCopyWith<DurationModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DurationModalCopyWith<$Res> {
  factory $DurationModalCopyWith(
          DurationModal value, $Res Function(DurationModal) then) =
      _$DurationModalCopyWithImpl<$Res, DurationModal>;
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class _$DurationModalCopyWithImpl<$Res, $Val extends DurationModal>
    implements $DurationModalCopyWith<$Res> {
  _$DurationModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DurationModalImplCopyWith<$Res>
    implements $DurationModalCopyWith<$Res> {
  factory _$$DurationModalImplCopyWith(
          _$DurationModalImpl value, $Res Function(_$DurationModalImpl) then) =
      __$$DurationModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class __$$DurationModalImplCopyWithImpl<$Res>
    extends _$DurationModalCopyWithImpl<$Res, _$DurationModalImpl>
    implements _$$DurationModalImplCopyWith<$Res> {
  __$$DurationModalImplCopyWithImpl(
      _$DurationModalImpl _value, $Res Function(_$DurationModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$DurationModalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DurationModalImpl implements _DurationModal {
  const _$DurationModalImpl({required this.id, required this.title});

  factory _$DurationModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$DurationModalImplFromJson(json);

  @override
  final int id;
  @override
  final String title;

  @override
  String toString() {
    return 'DurationModal(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DurationModalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DurationModalImplCopyWith<_$DurationModalImpl> get copyWith =>
      __$$DurationModalImplCopyWithImpl<_$DurationModalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DurationModalImplToJson(
      this,
    );
  }
}

abstract class _DurationModal implements DurationModal {
  const factory _DurationModal(
      {required final int id,
      required final String title}) = _$DurationModalImpl;

  factory _DurationModal.fromJson(Map<String, dynamic> json) =
      _$DurationModalImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$DurationModalImplCopyWith<_$DurationModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
