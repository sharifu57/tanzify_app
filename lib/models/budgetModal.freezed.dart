// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budgetModal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BudgetModal _$BudgetModalFromJson(Map<String, dynamic> json) {
  return _BudgetModal.fromJson(json);
}

/// @nodoc
mixin _$BudgetModal {
  int get id => throw _privateConstructorUsedError;
  String get price_from => throw _privateConstructorUsedError;
  String get price_to => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetModalCopyWith<BudgetModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetModalCopyWith<$Res> {
  factory $BudgetModalCopyWith(
          BudgetModal value, $Res Function(BudgetModal) then) =
      _$BudgetModalCopyWithImpl<$Res, BudgetModal>;
  @useResult
  $Res call({int id, String price_from, String price_to});
}

/// @nodoc
class _$BudgetModalCopyWithImpl<$Res, $Val extends BudgetModal>
    implements $BudgetModalCopyWith<$Res> {
  _$BudgetModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? price_from = null,
    Object? price_to = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      price_from: null == price_from
          ? _value.price_from
          : price_from // ignore: cast_nullable_to_non_nullable
              as String,
      price_to: null == price_to
          ? _value.price_to
          : price_to // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetModalImplCopyWith<$Res>
    implements $BudgetModalCopyWith<$Res> {
  factory _$$BudgetModalImplCopyWith(
          _$BudgetModalImpl value, $Res Function(_$BudgetModalImpl) then) =
      __$$BudgetModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String price_from, String price_to});
}

/// @nodoc
class __$$BudgetModalImplCopyWithImpl<$Res>
    extends _$BudgetModalCopyWithImpl<$Res, _$BudgetModalImpl>
    implements _$$BudgetModalImplCopyWith<$Res> {
  __$$BudgetModalImplCopyWithImpl(
      _$BudgetModalImpl _value, $Res Function(_$BudgetModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? price_from = null,
    Object? price_to = null,
  }) {
    return _then(_$BudgetModalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      price_from: null == price_from
          ? _value.price_from
          : price_from // ignore: cast_nullable_to_non_nullable
              as String,
      price_to: null == price_to
          ? _value.price_to
          : price_to // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetModalImpl implements _BudgetModal {
  const _$BudgetModalImpl(
      {required this.id, required this.price_from, required this.price_to});

  factory _$BudgetModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetModalImplFromJson(json);

  @override
  final int id;
  @override
  final String price_from;
  @override
  final String price_to;

  @override
  String toString() {
    return 'BudgetModal(id: $id, price_from: $price_from, price_to: $price_to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetModalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.price_from, price_from) ||
                other.price_from == price_from) &&
            (identical(other.price_to, price_to) ||
                other.price_to == price_to));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, price_from, price_to);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetModalImplCopyWith<_$BudgetModalImpl> get copyWith =>
      __$$BudgetModalImplCopyWithImpl<_$BudgetModalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetModalImplToJson(
      this,
    );
  }
}

abstract class _BudgetModal implements BudgetModal {
  const factory _BudgetModal(
      {required final int id,
      required final String price_from,
      required final String price_to}) = _$BudgetModalImpl;

  factory _BudgetModal.fromJson(Map<String, dynamic> json) =
      _$BudgetModalImpl.fromJson;

  @override
  int get id;
  @override
  String get price_from;
  @override
  String get price_to;
  @override
  @JsonKey(ignore: true)
  _$$BudgetModalImplCopyWith<_$BudgetModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
