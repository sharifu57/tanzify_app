import 'package:freezed_annotation/freezed_annotation.dart';

part 'categoryModal.freezed.dart';
part 'categoryModal.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}
