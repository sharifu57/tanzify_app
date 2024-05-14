// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budgetModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetModalImpl _$$BudgetModalImplFromJson(Map<String, dynamic> json) =>
    _$BudgetModalImpl(
      id: (json['id'] as num).toInt(),
      price_from: json['price_from'] as String,
      price_to: json['price_to'] as String,
    );

Map<String, dynamic> _$$BudgetModalImplToJson(_$BudgetModalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price_from': instance.price_from,
      'price_to': instance.price_to,
    };
