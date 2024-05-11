// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      skills: SkillModel.fromJson(json['skills'] as Map<String, dynamic>),
      duration: json['duration'] as String,
      createdBy: UserModel.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'skills': instance.skills,
      'duration': instance.duration,
      'createdBy': instance.createdBy,
    };
