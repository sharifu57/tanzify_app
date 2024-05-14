// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as String?,
      created: json['created'] as String?,
      created_by: json['created_by'] == null
          ? null
          : UserModel.fromJson(json['created_by'] as Map<String, dynamic>),
      budget: json['budget'] == null
          ? null
          : BudgetModal.fromJson(json['budget'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModal.fromJson(json['location'] as Map<String, dynamic>),
      bids: (json['bids'] as List<dynamic>?)
          ?.map((e) => BidModal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'skills': instance.skills,
      'duration': instance.duration,
      'created': instance.created,
      'created_by': instance.created_by,
      'budget': instance.budget,
      'location': instance.location,
      'bids': instance.bids,
    };
