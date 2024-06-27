import 'package:freezed_annotation/freezed_annotation.dart';

part 'bidModal.freezed.dart';
part 'bidModal.g.dart';

@freezed
// class BidModal with _$BidModal {
//   const factory BidModal({
//     String? amount,
//     String? identity,
//     UserModel? bidder,
//     ProjectModel? project,
//   }) = _BidModal;

//   factory BidModal.fromJson(Map<String, dynamic> json) =>
//       _$BidModalFromJson(json);

//   // factory BidModal.fromJson(Map<String, dynamic> json) => BidModal(
//   //     amount: json["amount"] as String?,
//   //     identity: json["identity"] as String?,
//   //     project: json['project'] != null
//   //         ? ProjectModel.fromJson(json['project'] as Map<String, dynamic>)
//   //         : null);
// }

class BidModal with _$BidModal {
  const factory BidModal({
    int? id,
    // String? amount,
    String? identity,
    // UserModel? bidder,
    // ProjectModel? project,
  }) = _BidModal;

  factory BidModal.fromJson(Map<String, dynamic> json) =>
      _$BidModalFromJson(json);
}

double? _stringToDouble(dynamic value) {
  if (value is String) {
    return double.tryParse(value);
  } else if (value is num) {
    return value.toDouble();
  }
  return null;
}
