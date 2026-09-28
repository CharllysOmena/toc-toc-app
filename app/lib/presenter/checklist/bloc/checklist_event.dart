import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_event.freezed.dart';

@freezed
abstract class ChecklistEvent with _$ChecklistEvent {
  const factory ChecklistEvent.started() = _Started;
  const factory ChecklistEvent.filterChanged(int? day) = _FilterChanged;
  const factory ChecklistEvent.deleted(String id) = _Deleted;
}
