import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/day_time.dart';

part 'checklist_form_event.freezed.dart';

@freezed
abstract class ChecklistFormEvent with _$ChecklistFormEvent {
  const factory ChecklistFormEvent.started(String? id) = _Started;
  const factory ChecklistFormEvent.titleChanged(String title) = _TitleChanged;
  const factory ChecklistFormEvent.objectChanged(String objectId) = _ObjectChanged;
  const factory ChecklistFormEvent.timeChanged(DayTime time) = _TimeChanged;
  const factory ChecklistFormEvent.weekDayToggled(int day) = _WeekDayToggled;
  const factory ChecklistFormEvent.saved() = _Saved;
}
