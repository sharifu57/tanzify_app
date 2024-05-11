import 'package:freezed_annotation/freezed_annotation.dart';

part 'skillModal.freezed.dart';
part 'skillModal.g.dart';

@freezed
class SkillModel with _$SkillModel {
  const factory SkillModel({
    required int id,
    required String name
  }) = _SkillModel;

  factory SkillModel.fromJson(Map<String, dynamic> json) => _$SkillModelFromJson(json);
}
