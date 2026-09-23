import 'package:freezed_annotation/freezed_annotation.dart';

import 'checklist_item.dart';

part 'check_result.freezed.dart';
part 'check_result.g.dart';

@freezed
abstract class CheckResult with _$CheckResult {
  const factory CheckResult({
    required DateTime timestamp,
    required List<ChecklistItem> items,
    required List<String> missingIds,
  }) = _CheckResult;

  factory CheckResult.fromJson(Map<String, dynamic> json) =>
      _$CheckResultFromJson(json);
}

extension CheckResultX on CheckResult {
  bool get isConfirmed => missingIds.isEmpty;
}
