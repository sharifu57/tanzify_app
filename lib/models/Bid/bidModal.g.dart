// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bidModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BidModalImpl _$$BidModalImplFromJson(Map<String, dynamic> json) =>
    _$BidModalImpl(
      amount: json['amount'] as String?,
      identity: json['identity'] as String?,
      bidder: json['bidder'] == null
          ? null
          : UserModel.fromJson(json['bidder'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : ProjectModel.fromJson(json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BidModalImplToJson(_$BidModalImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'identity': instance.identity,
      'bidder': instance.bidder,
      'project': instance.project,
    };
