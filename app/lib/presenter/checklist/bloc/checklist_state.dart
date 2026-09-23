import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/checklist_item.dart';

part 'checklist_state.freezed.dart';

@freezed
abstract class ChecklistState with _$ChecklistState {
  const factory ChecklistState.loading() = _Loading;
  const factory ChecklistState.ready({required List<ChecklistItem> items}) = _Ready;
  const factory ChecklistState.saving({required List<ChecklistItem> items}) = _Saving;
}
