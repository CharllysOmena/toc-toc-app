import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/day_time.dart';

part 'checklist_form_state.freezed.dart';

@freezed
abstract class ChecklistFormState with _$ChecklistFormState {
  const factory ChecklistFormState.loading() = _Loading;
  const factory ChecklistFormState.ready({
    String? id,
    required String title,
    required String objectId,
    required DayTime time,
    required List<int> weekDays,
    String? error,
  }) = _Ready;
  const factory ChecklistFormState.success() = _Success;
  const factory ChecklistFormState.error({required String message}) = _Error;
}
