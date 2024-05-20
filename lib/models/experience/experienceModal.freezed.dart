// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experienceModal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExperienceModal _$ExperienceModalFromJson(Map<String, dynamic> json) {
  return _ExperienceModal.fromJson(json);
}

/// @nodoc
mixin _$ExperienceModal {
// required int? id,
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExperienceModalCopyWith<ExperienceModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceModalCopyWith<$Res> {
  factory $ExperienceModalCopyWith(
          ExperienceModal value, $Res Function(ExperienceModal) then) =
      _$ExperienceModalCopyWithImpl<$Res, ExperienceModal>;
  @useResult
  $Res call({String? title});
}

/// @nodoc
class _$ExperienceModalCopyWithImpl<$Res, $Val extends ExperienceModal>
    implements $ExperienceModalCopyWith<$Res> {
  _$ExperienceModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExperienceModalImplCopyWith<$Res>
    implements $ExperienceModalCopyWith<$Res> {
  factory _$$ExperienceModalImplCopyWith(_$ExperienceModalImpl value,
          $Res Function(_$ExperienceModalImpl) then) =
      __$$ExperienceModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$$ExperienceModalImplCopyWithImpl<$Res>
    extends _$ExperienceModalCopyWithImpl<$Res, _$ExperienceModalImpl>
    implements _$$ExperienceModalImplCopyWith<$Res> {
  __$$ExperienceModalImplCopyWithImpl(
      _$ExperienceModalImpl _value, $Res Function(_$ExperienceModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$ExperienceModalImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceModalImpl implements _ExperienceModal {
  const _$ExperienceModalImpl({required this.title});

  factory _$ExperienceModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceModalImplFromJson(json);

// required int? id,
  @override
  final String? title;

  @override
  String toString() {
    return 'ExperienceModal(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceModalImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceModalImplCopyWith<_$ExperienceModalImpl> get copyWith =>
      __$$ExperienceModalImplCopyWithImpl<_$ExperienceModalImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceModalImplToJson(
      this,
    );
  }
}

abstract class _ExperienceModal implements ExperienceModal {
  const factory _ExperienceModal({required final String? title}) =
      _$ExperienceModalImpl;

  factory _ExperienceModal.fromJson(Map<String, dynamic> json) =
      _$ExperienceModalImpl.fromJson;

  @override // required int? id,
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$ExperienceModalImplCopyWith<_$ExperienceModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
