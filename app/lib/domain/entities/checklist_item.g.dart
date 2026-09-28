// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) =>
    _ChecklistItem(
      id: json['id'] as String,
      title: json['title'] as String,
      objectId: json['objectId'] as String,
      time: DayTime.fromJson(json['time'] as Map<String, dynamic>),
      weekDays: (json['weekDays'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$ChecklistItemToJson(_ChecklistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'objectId': instance.objectId,
      'time': instance.time,
      'weekDays': instance.weekDays,
      'createdAt': instance.createdAt.toIso8601String(),
      'registeredAt': instance.registeredAt?.toIso8601String(),
    };
