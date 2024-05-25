import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/models/user/userModal.dart';

part 'bidModal.freezed.dart';
part 'bidModal.g.dart';

@freezed
class BidModal with _$BidModal {
  const factory BidModal({
    String? amount,
    String? identity,
    UserModel? bidder,
  }) = _BidModal;

  factory BidModal.fromJson(Map<String, dynamic> json) => BidModal(
        amount: json["amount"] as String?, // Nullable String
        identity: json["identity"] as String?,
        // bidder: json['bidder'] != null
        //     ? UserModel.fromJson(json['bidder'] as Map<String, dynamic>)
        //     : null,
      );
}
