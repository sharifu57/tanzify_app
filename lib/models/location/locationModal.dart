import 'package:freezed_annotation/freezed_annotation.dart';

part 'locationModal.freezed.dart';
part 'locationModal.g.dart';
@freezed

class LocationModal with _$LocationModal {
  const factory LocationModal ({
    required int id,
    required String name
  }) = _LocationModal;

  factory LocationModal.fromJson(Map<String, dynamic> json) => _$LocationModalFromJson(json);
}