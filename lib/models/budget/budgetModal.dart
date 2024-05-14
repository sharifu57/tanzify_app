import 'package:freezed_annotation/freezed_annotation.dart';

part 'budgetModal.freezed.dart';
part 'budgetModal.g.dart';

@freezed
class BudgetModal with _$BudgetModal {
  const factory BudgetModal({
    required int id,
    required String price_from,
    required String price_to,
  }) = _BudgetModal;

  factory BudgetModal.fromJson(Map<String, dynamic> json) =>
      _$BudgetModalFromJson(json);
}
