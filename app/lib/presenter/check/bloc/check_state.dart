import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/check_result.dart';
import '../../../domain/entities/checklist_item.dart';

part 'check_state.freezed.dart';

@freezed
abstract class CheckState with _$CheckState {
  const factory CheckState.loading() = _Loading;
  const factory CheckState.ready({required ChecklistItem item}) = _Ready;
  const factory CheckState.processing({required ChecklistItem item}) = _Processing;
  const factory CheckState.confirmed({required CheckResult result}) = _Confirmed;
  const factory CheckState.missing({required CheckResult result}) = _Missing;
  const factory CheckState.unavailable({required ChecklistItem item, required String message}) = _Unavailable;
  const factory CheckState.error({required String message}) = _Error;
}
