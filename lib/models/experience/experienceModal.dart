import 'package:freezed_annotation/freezed_annotation.dart';

part 'experienceModal.freezed.dart';
part 'experienceModal.g.dart';

@freezed
class ExperienceModal with _$ExperienceModal {
  const factory ExperienceModal({
    // required int? id,
    required String? title,
  }) = _ExperienceModal;

  factory ExperienceModal.fromJson(Map<String, dynamic> json) =>
      ExperienceModal(
        title: json["title"] as String,
      );
}
