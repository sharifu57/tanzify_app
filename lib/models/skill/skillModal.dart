import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';

part 'skillModal.freezed.dart';
part 'skillModal.g.dart';

@freezed
class SkillModel with _$SkillModel {
  const factory SkillModel(
      {
      final int? id,
      final String? name,
      // required CategoryModel? category
    }) = _SkillModel;

  // factory SkillModel.fromJson(Map<String, dynamic> json) =>
  //     SkillModel(id: json["id"] as int, name: json["name"] as String);

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);
}
