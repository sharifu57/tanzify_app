import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/models/userModal.dart';

part 'projectModal.freezed.dart';
part 'projectModal.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required int id,
    required String title,
    required String description,
    required CategoryModel category,
    required SkillModel skills,
    required String duration,
    required UserModel createdBy,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);
}
