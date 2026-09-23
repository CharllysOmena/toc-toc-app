import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_event.freezed.dart';

@freezed
abstract class ChecklistEvent with _$ChecklistEvent {
  const factory ChecklistEvent.started() = _Started;
  const factory ChecklistEvent.toggled(String id) = _Toggled;
  const factory ChecklistEvent.saved() = _Saved;
}
