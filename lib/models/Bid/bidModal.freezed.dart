// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bidModal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BidModal _$BidModalFromJson(Map<String, dynamic> json) {
  return _BidModal.fromJson(json);
}

/// @nodoc
mixin _$BidModal {
  String? get amount => throw _privateConstructorUsedError;
  String? get identity => throw _privateConstructorUsedError;
  UserModel? get bidder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BidModalCopyWith<BidModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidModalCopyWith<$Res> {
  factory $BidModalCopyWith(BidModal value, $Res Function(BidModal) then) =
      _$BidModalCopyWithImpl<$Res, BidModal>;
  @useResult
  $Res call({String? amount, String? identity, UserModel? bidder});

  $UserModelCopyWith<$Res>? get bidder;
}

/// @nodoc
class _$BidModalCopyWithImpl<$Res, $Val extends BidModal>
    implements $BidModalCopyWith<$Res> {
  _$BidModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? identity = freezed,
    Object? bidder = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      identity: freezed == identity
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String?,
      bidder: freezed == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get bidder {
    if (_value.bidder == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.bidder!, (value) {
      return _then(_value.copyWith(bidder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BidModalImplCopyWith<$Res>
    implements $BidModalCopyWith<$Res> {
  factory _$$BidModalImplCopyWith(
          _$BidModalImpl value, $Res Function(_$BidModalImpl) then) =
      __$$BidModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? amount, String? identity, UserModel? bidder});

  @override
  $UserModelCopyWith<$Res>? get bidder;
}

/// @nodoc
class __$$BidModalImplCopyWithImpl<$Res>
    extends _$BidModalCopyWithImpl<$Res, _$BidModalImpl>
    implements _$$BidModalImplCopyWith<$Res> {
  __$$BidModalImplCopyWithImpl(
      _$BidModalImpl _value, $Res Function(_$BidModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? identity = freezed,
    Object? bidder = freezed,
  }) {
    return _then(_$BidModalImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      identity: freezed == identity
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String?,
      bidder: freezed == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BidModalImpl implements _BidModal {
  const _$BidModalImpl({this.amount, this.identity, this.bidder});

  factory _$BidModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidModalImplFromJson(json);

  @override
  final String? amount;
  @override
  final String? identity;
  @override
  final UserModel? bidder;

  @override
  String toString() {
    return 'BidModal(amount: $amount, identity: $identity, bidder: $bidder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidModalImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.identity, identity) ||
                other.identity == identity) &&
            (identical(other.bidder, bidder) || other.bidder == bidder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, identity, bidder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BidModalImplCopyWith<_$BidModalImpl> get copyWith =>
      __$$BidModalImplCopyWithImpl<_$BidModalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BidModalImplToJson(
      this,
    );
  }
}

abstract class _BidModal implements BidModal {
  const factory _BidModal(
      {final String? amount,
      final String? identity,
      final UserModel? bidder}) = _$BidModalImpl;

  factory _BidModal.fromJson(Map<String, dynamic> json) =
      _$BidModalImpl.fromJson;

  @override
  String? get amount;
  @override
  String? get identity;
  @override
  UserModel? get bidder;
  @override
  @JsonKey(ignore: true)
  _$$BidModalImplCopyWith<_$BidModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
