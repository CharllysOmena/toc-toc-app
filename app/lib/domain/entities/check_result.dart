import 'package:freezed_annotation/freezed_annotation.dart';

import 'checklist_item.dart';

part 'check_result.freezed.dart';

@freezed
abstract class CheckResult with _$CheckResult {
  const factory CheckResult({
    required ChecklistItem item,
    required bool detected,
    required DateTime timestamp,
    String? photoPath,
  }) = _CheckResult;
}
