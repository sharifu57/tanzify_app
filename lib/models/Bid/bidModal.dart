import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/models/user/userModal.dart';

part 'bidModal.freezed.dart';
part 'bidModal.g.dart';

@freezed
class BidModal with _$BidModal {
  const factory BidModal({
    // int? id,
    // ProjectModel? project,
    // UserModel? bidder,
    // String? duration,
    String? amount,
    // String? proposal,
    // String? message
  }) = _BidModal;

  factory BidModal.fromJson(Map<String, dynamic> json) => BidModal(
        amount: json["amount"] as String,
      );
}
