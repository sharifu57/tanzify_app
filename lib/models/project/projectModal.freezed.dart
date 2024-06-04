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

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return _ProjectModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectModel {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CategoryModel? get category => throw _privateConstructorUsedError;
  List<SkillModel>? get skills => throw _privateConstructorUsedError;
  DurationModal? get duration => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get application_deadline =>
      throw _privateConstructorUsedError; // UserModel? created_by,
// BudgetModal? budget,
// LocationModal? location,
// ExperienceModal? experience,
// List<BidModal>? bids,
  @JsonKey(fromJson: _stringToDouble)
  double? get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
          ProjectModel value, $Res Function(ProjectModel) then) =
      _$ProjectModelCopyWithImpl<$Res, ProjectModel>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      CategoryModel? category,
      List<SkillModel>? skills,
      DurationModal? duration,
      String? created,
      String? application_deadline,
      @JsonKey(fromJson: _stringToDouble) double? amount});

  $CategoryModelCopyWith<$Res>? get category;
  $DurationModalCopyWith<$Res>? get duration;
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res, $Val extends ProjectModel>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? skills = freezed,
    Object? duration = freezed,
    Object? created = freezed,
    Object? application_deadline = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
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
}

/// @nodoc
abstract class _$$ProjectModelImplCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$ProjectModelImplCopyWith(
          _$ProjectModelImpl value, $Res Function(_$ProjectModelImpl) then) =
      __$$ProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      CategoryModel? category,
      List<SkillModel>? skills,
      DurationModal? duration,
      String? created,
      String? application_deadline,
      @JsonKey(fromJson: _stringToDouble) double? amount});

  @override
  $CategoryModelCopyWith<$Res>? get category;
  @override
  $DurationModalCopyWith<$Res>? get duration;
}

/// @nodoc
class __$$ProjectModelImplCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res, _$ProjectModelImpl>
    implements _$$ProjectModelImplCopyWith<$Res> {
  __$$ProjectModelImplCopyWithImpl(
      _$ProjectModelImpl _value, $Res Function(_$ProjectModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? skills = freezed,
    Object? duration = freezed,
    Object? created = freezed,
    Object? application_deadline = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$ProjectModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectModelImpl implements _ProjectModel {
  const _$ProjectModelImpl(
      {this.id,
      this.title,
      this.description,
      this.category,
      final List<SkillModel>? skills,
      this.duration,
      this.created,
      this.application_deadline,
      @JsonKey(fromJson: _stringToDouble) this.amount})
      : _skills = skills;

  factory _$ProjectModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectModelImplFromJson(json);

  @override
  final int? id;
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
// BudgetModal? budget,
// LocationModal? location,
// ExperienceModal? experience,
// List<BidModal>? bids,
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double? amount;

  @override
  String toString() {
    return 'ProjectModel(id: $id, title: $title, description: $description, category: $category, skills: $skills, duration: $duration, created: $created, application_deadline: $application_deadline, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      category,
      const DeepCollectionEquality().hash(_skills),
      duration,
      created,
      application_deadline,
      amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      __$$ProjectModelImplCopyWithImpl<_$ProjectModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectModelImplToJson(
      this,
    );
  }
}

abstract class _ProjectModel implements ProjectModel {
  const factory _ProjectModel(
          {final int? id,
          final String? title,
          final String? description,
          final CategoryModel? category,
          final List<SkillModel>? skills,
          final DurationModal? duration,
          final String? created,
          final String? application_deadline,
          @JsonKey(fromJson: _stringToDouble) final double? amount}) =
      _$ProjectModelImpl;

  factory _ProjectModel.fromJson(Map<String, dynamic> json) =
      _$ProjectModelImpl.fromJson;

  @override
  int? get id;
  @override
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
// BudgetModal? budget,
// LocationModal? location,
// ExperienceModal? experience,
// List<BidModal>? bids,
  @JsonKey(fromJson: _stringToDouble)
  double? get amount;
  @override
  @JsonKey(ignore: true)
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
