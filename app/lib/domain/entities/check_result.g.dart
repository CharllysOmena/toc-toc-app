// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckResult _$CheckResultFromJson(Map<String, dynamic> json) => _CheckResult(
  timestamp: DateTime.parse(json['timestamp'] as String),
  items: (json['items'] as List<dynamic>)
      .map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  missingIds: (json['missingIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CheckResultToJson(_CheckResult instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'items': instance.items,
      'missingIds': instance.missingIds,
    };
