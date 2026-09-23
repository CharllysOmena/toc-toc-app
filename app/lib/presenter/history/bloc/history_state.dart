import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/history_entry.dart';

part 'history_state.freezed.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState.loading() = _Loading;
  const factory HistoryState.ready({required List<HistoryEntry> entries}) = _Ready;
  const factory HistoryState.error({required String message}) = _Error;
}
