import 'package:freezed_annotation/freezed_annotation.dart';

part 'budgetModal.freezed.dart';
part 'budgetModal.g.dart';

@freezed
class BudgetModal with _$BudgetModal {
  const factory BudgetModal({
    required int id,
    String? price_from,
    String? price_to,
  }) = _BudgetModal;

  factory BudgetModal.fromJson(Map<String, dynamic> json) =>
      _$BudgetModalFromJson(json);
  // factory BudgetModal.fromJson(Map<String, dynamic> json) => BudgetModal(
  //     id: json['id'] as int,
  //     price_from: json['price_from'] as String,
  //     price_to: json['price_to'] as String);
}

double? _stringToDouble(dynamic value) {
  if (value is String) {
    return double.tryParse(value);
  } else if (value is num) {
    return value.toDouble();
  }
  return null;
}
