import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/models/user/userModal.dart';

part 'projectModal.freezed.dart';
part 'projectModal.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required int id,
    String? title,
    String? description,
    CategoryModel? category,
    List<SkillModel>? skills,
    String? duration,
    // ignore: non_constant_identifier_names
    UserModel? created_by,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'] as int,
        title: json['title'] as String?,
        description: json['description'] as String?,
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        skills: json['skills'] != null
            ? (json['skills'] as List)
                .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        duration: json['duration'] as String?,
        created_by: json['created_by'] != null
            ? UserModel.fromJson(json['created_by'] as Map<String, dynamic>)
            : null,
      );
}
