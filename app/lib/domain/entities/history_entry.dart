import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_entry.freezed.dart';
part 'history_entry.g.dart';

@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required DateTime date,
    required bool confirmed,
    DateTime? confirmedAt,
    String? photoPath,
    @Default(false) bool manual,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntryFromJson(json);
}
