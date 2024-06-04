// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budgetModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetModalImpl _$$BudgetModalImplFromJson(Map<String, dynamic> json) =>
    _$BudgetModalImpl(
      id: (json['id'] as num).toInt(),
      created: json['created'] as String?,
      update: json['update'] as String?,
      price_from: _stringToDouble(json['price_from']),
      price_to: _stringToDouble(json['price_to']),
    );

Map<String, dynamic> _$$BudgetModalImplToJson(_$BudgetModalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'update': instance.update,
      'price_from': instance.price_from,
      'price_to': instance.price_to,
    };
