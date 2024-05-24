import 'package:freezed_annotation/freezed_annotation.dart';

part 'durationModal.freezed.dart';
part 'durationModal.g.dart';

@freezed
class DurationModal with _$DurationModal {
  const factory DurationModal({required int id, required String title}) =
      _DurationModal;

  factory DurationModal.fromJson(Map<String, dynamic> json) =>
      _$DurationModalFromJson(json);
}
