// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) =>
    _HistoryEntry(
      date: DateTime.parse(json['date'] as String),
      confirmed: json['confirmed'] as bool,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
    );

Map<String, dynamic> _$HistoryEntryToJson(_HistoryEntry instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'confirmed': instance.confirmed,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
    };
