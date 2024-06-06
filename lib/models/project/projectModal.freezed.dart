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
  String? get description => throw _privateConstructorUsedError;
  CategoryModel? get category => throw _privateConstructorUsedError;
  List<SkillModel>? get skills => throw _privateConstructorUsedError;
  DurationModal? get duration => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get application_deadline =>
      throw _privateConstructorUsedError; // UserModel? created_by,
  BudgetModal? get budget => throw _privateConstructorUsedError;
  LocationModal? get location =>
      throw _privateConstructorUsedError; // ExperienceModal? experience,
  List<BidModal>? get bids => throw _privateConstructorUsedError;

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
      CategoryModel? category,
      List<SkillModel>? skills,
      DurationModal? duration,
      String? created,
      String? application_deadline,
      BudgetModal? budget,
      LocationModal? location,
      List<BidModal>? bids});

  $CategoryModelCopyWith<$Res>? get category;
  $DurationModalCopyWith<$Res>? get duration;
  $BudgetModalCopyWith<$Res>? get budget;
  $LocationModalCopyWith<$Res>? get location;
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
    Object? category = freezed,
    Object? skills = freezed,
    Object? duration = freezed,
    Object? created = freezed,
    Object? application_deadline = freezed,
    Object? budget = freezed,
    Object? location = freezed,
    Object? bids = freezed,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<SkillModel>?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as DurationModal?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      application_deadline: freezed == application_deadline
          ? _value.application_deadline
          : application_deadline // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as BudgetModal?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModal?,
      bids: freezed == bids
          ? _value.bids
          : bids // ignore: cast_nullable_to_non_nullable
              as List<BidModal>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DurationModalCopyWith<$Res>? get duration {
    if (_value.duration == null) {
      return null;
    }

    return $DurationModalCopyWith<$Res>(_value.duration!, (value) {
      return _then(_value.copyWith(duration: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetModalCopyWith<$Res>? get budget {
    if (_value.budget == null) {
      return null;
    }

    return $BudgetModalCopyWith<$Res>(_value.budget!, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationModalCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationModalCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
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
      CategoryModel? category,
      List<SkillModel>? skills,
      DurationModal? duration,
      String? created,
      String? application_deadline,
      BudgetModal? budget,
      LocationModal? location,
      List<BidModal>? bids});

  @override
  $CategoryModelCopyWith<$Res>? get category;
  @override
  $DurationModalCopyWith<$Res>? get duration;
  @override
  $BudgetModalCopyWith<$Res>? get budget;
  @override
  $LocationModalCopyWith<$Res>? get location;
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
    Object? category = freezed,
    Object? skills = freezed,
    Object? duration = freezed,
    Object? created = freezed,
    Object? application_deadline = freezed,
    Object? budget = freezed,
    Object? location = freezed,
    Object? bids = freezed,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<SkillModel>?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as DurationModal?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      application_deadline: freezed == application_deadline
          ? _value.application_deadline
          : application_deadline // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as BudgetModal?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModal?,
      bids: freezed == bids
          ? _value._bids
          : bids // ignore: cast_nullable_to_non_nullable
              as List<BidModal>?,
    ));
  }
}

/// @nodoc

class _$ProjectModalImpl implements _ProjectModal {
  const _$ProjectModalImpl(
      {this.title,
      this.description,
      this.category,
      final List<SkillModel>? skills,
      this.duration,
      this.created,
      this.application_deadline,
      this.budget,
      this.location,
      final List<BidModal>? bids})
      : _skills = skills,
        _bids = bids;

// int? id,
  @override
  final String? title;
  @override
  final String? description;
  @override
  final CategoryModel? category;
  final List<SkillModel>? _skills;
  @override
  List<SkillModel>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DurationModal? duration;
  @override
  final String? created;
  @override
  final String? application_deadline;
// UserModel? created_by,
  @override
  final BudgetModal? budget;
  @override
  final LocationModal? location;
// ExperienceModal? experience,
  final List<BidModal>? _bids;
// ExperienceModal? experience,
  @override
  List<BidModal>? get bids {
    final value = _bids;
    if (value == null) return null;
    if (_bids is EqualUnmodifiableListView) return _bids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProjectModal(title: $title, description: $description, category: $category, skills: $skills, duration: $duration, created: $created, application_deadline: $application_deadline, budget: $budget, location: $location, bids: $bids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModalImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.application_deadline, application_deadline) ||
                other.application_deadline == application_deadline) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._bids, _bids));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      category,
      const DeepCollectionEquality().hash(_skills),
      duration,
      created,
      application_deadline,
      budget,
      location,
      const DeepCollectionEquality().hash(_bids));

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
      final CategoryModel? category,
      final List<SkillModel>? skills,
      final DurationModal? duration,
      final String? created,
      final String? application_deadline,
      final BudgetModal? budget,
      final LocationModal? location,
      final List<BidModal>? bids}) = _$ProjectModalImpl;

  @override // int? id,
  String? get title;
  @override
  String? get description;
  @override
  CategoryModel? get category;
  @override
  List<SkillModel>? get skills;
  @override
  DurationModal? get duration;
  @override
  String? get created;
  @override
  String? get application_deadline;
  @override // UserModel? created_by,
  BudgetModal? get budget;
  @override
  LocationModal? get location;
  @override // ExperienceModal? experience,
  List<BidModal>? get bids;
  @override
  @JsonKey(ignore: true)
  _$$ProjectModalImplCopyWith<_$ProjectModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
