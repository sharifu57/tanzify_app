// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projectModal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectModal {
// int? id,
  String? get title => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // CategoryModel? category,
  List<SkillModel>? get skills =>
      throw _privateConstructorUsedError; // DurationModal? duration,
  String? get created => throw _privateConstructorUsedError;
  String? get application_deadline => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectModalCopyWith<ProjectModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModalCopyWith<$Res> {
  factory $ProjectModalCopyWith(
          ProjectModal value, $Res Function(ProjectModal) then) =
      _$ProjectModalCopyWithImpl<$Res, ProjectModal>;
  @useResult
  $Res call(
      {String? title,
      String? description,
      List<SkillModel>? skills,
      String? created,
      String? application_deadline});
}

/// @nodoc
class _$ProjectModalCopyWithImpl<$Res, $Val extends ProjectModal>
    implements $ProjectModalCopyWith<$Res> {
  _$ProjectModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? skills = freezed,
    Object? created = freezed,
    Object? application_deadline = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<SkillModel>?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      application_deadline: freezed == application_deadline
          ? _value.application_deadline
          : application_deadline // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectModalImplCopyWith<$Res>
    implements $ProjectModalCopyWith<$Res> {
  factory _$$ProjectModalImplCopyWith(
          _$ProjectModalImpl value, $Res Function(_$ProjectModalImpl) then) =
      __$$ProjectModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? description,
      List<SkillModel>? skills,
      String? created,
      String? application_deadline});
}

/// @nodoc
class __$$ProjectModalImplCopyWithImpl<$Res>
    extends _$ProjectModalCopyWithImpl<$Res, _$ProjectModalImpl>
    implements _$$ProjectModalImplCopyWith<$Res> {
  __$$ProjectModalImplCopyWithImpl(
      _$ProjectModalImpl _value, $Res Function(_$ProjectModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? skills = freezed,
    Object? created = freezed,
    Object? application_deadline = freezed,
  }) {
    return _then(_$ProjectModalImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<SkillModel>?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      application_deadline: freezed == application_deadline
          ? _value.application_deadline
          : application_deadline // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProjectModalImpl implements _ProjectModal {
  const _$ProjectModalImpl(
      {this.title,
      this.description,
      final List<SkillModel>? skills,
      this.created,
      this.application_deadline})
      : _skills = skills;

// int? id,
  @override
  final String? title;
  @override
  final String? description;
// CategoryModel? category,
  final List<SkillModel>? _skills;
// CategoryModel? category,
  @override
  List<SkillModel>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// DurationModal? duration,
  @override
  final String? created;
  @override
  final String? application_deadline;

  @override
  String toString() {
    return 'ProjectModal(title: $title, description: $description, skills: $skills, created: $created, application_deadline: $application_deadline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModalImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.application_deadline, application_deadline) ||
                other.application_deadline == application_deadline));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      const DeepCollectionEquality().hash(_skills),
      created,
      application_deadline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModalImplCopyWith<_$ProjectModalImpl> get copyWith =>
      __$$ProjectModalImplCopyWithImpl<_$ProjectModalImpl>(this, _$identity);
}

abstract class _ProjectModal implements ProjectModal {
  const factory _ProjectModal(
      {final String? title,
      final String? description,
      final List<SkillModel>? skills,
      final String? created,
      final String? application_deadline}) = _$ProjectModalImpl;

  @override // int? id,
  String? get title;
  @override
  String? get description;
  @override // CategoryModel? category,
  List<SkillModel>? get skills;
  @override // DurationModal? duration,
  String? get created;
  @override
  String? get application_deadline;
  @override
  @JsonKey(ignore: true)
  _$$ProjectModalImplCopyWith<_$ProjectModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
