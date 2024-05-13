import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';

part 'userModal.freezed.dart';
part 'userModal.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    String? first_name,
    String? last_name,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(id: json['id'] as int, email: json['email'] as String);
}
