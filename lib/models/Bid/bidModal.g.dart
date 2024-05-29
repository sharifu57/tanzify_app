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
      id: (json['id'] as num).toInt(),
      isActive: json['isActive'] as bool,
      isDeleted: json['isDeleted'] as bool,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$$BidModalImplToJson(_$BidModalImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'identity': instance.identity,
      'bidder': instance.bidder,
      'project': instance.project,
      'id': instance.id,
      'isActive': instance.isActive,
      'isDeleted': instance.isDeleted,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };
