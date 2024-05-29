// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationModalImpl _$$LocationModalImplFromJson(Map<String, dynamic> json) =>
    _$LocationModalImpl(
      id: (json['id'] as num).toInt(),
      isActive: json['isActive'] as bool,
      isDeleted: json['isDeleted'] as bool,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$$LocationModalImplToJson(_$LocationModalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isActive': instance.isActive,
      'isDeleted': instance.isDeleted,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'code': instance.code,
    };
