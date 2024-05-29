import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/Bid/bidModal.dart';
import 'package:tanzify_app/models/budget/budgetModal.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/models/duration/durationModal.dart';
import 'package:tanzify_app/models/experience/experienceModal.dart';
import 'package:tanzify_app/models/location/locationModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/models/user/userModal.dart';

part 'projectModal.freezed.dart';
part 'projectModal.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel(
      {required int id,
      String? title,
      String? description,
      CategoryModel? category,
      List<SkillModel>? skills,
      DurationModal? duration,
      String? created,
      // ignore: non_constant_identifier_names
      String? application_deadline,
      // ignore: non_constant_identifier_names
      UserModel? created_by,
      BudgetModal? budget,
      LocationModal? location,
      ExperienceModal? experience,
      List<BidModal>? bids}) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
  // factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
  //       id: json['id'] as int,
  //       title: json['title'] as String?,
  //       description: json['description'] as String?,
  //       // Use the null-aware operator (?.) to handle nullable fields
  //       application_deadline: json['application_deadline'] as String?,
  //       // Handle nullable fields using conditional logic
  //       category: json['category'] != null
  //           ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
  //           : null,
  //       // Use null-aware operators to safely access nested properties
  //       location: json['location'] != null
  //           ? LocationModal.fromJson(json['location'] as Map<String, dynamic>)
  //           : null,

  //       // check for budget
  //       budget: json['budget'] != null
  //           ? BudgetModal.fromJson(json['budget'] as Map<String, dynamic>)
  //           : null,
  //       created_by: json['created_by'] != null
  //           ? UserModel.fromJson(json['created_by'] as Map<String, dynamic>)
  //           : null,
  //       // Handle nullable lists by checking if the value is a list and using conditional logic
  //       skills: (json['skills'] as List?)
  //           ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  //       // Handle other fields similarly to ensure proper handling of null values
  //       experience: json['experience'] != null
  //           ? ExperienceModal.fromJson(
  //               json['experience'] as Map<String, dynamic>)
  //           : null,
  //       bids: (json['bids'] as List<dynamic>?)
  //           ?.map((e) => BidModal.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  //     );
}
