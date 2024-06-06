// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModalImpl _$$ProjectModalImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModalImpl(
      // id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      // category: json['category'] == null
      //     ? null
      //     : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      // duration: json['duration'] == null
      //     ? null
      //     : DurationModal.fromJson(json['duration'] as Map<String, dynamic>),
      created: json['created'] as String?,
      application_deadline: json['application_deadline'] as String?,
      // amount: _stringToDouble(json['amount']),
    );

Map<String, dynamic> _$$ProjectModalImplToJson(_$ProjectModalImpl instance) =>
    <String, dynamic>{
      // 'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      // 'category': instance.category,
      'skills': instance.skills,
      // 'duration': instance.duration,
      'created': instance.created,
      'application_deadline': instance.application_deadline,
      // 'amount': instance.amount,
    };