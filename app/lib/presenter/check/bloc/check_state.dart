import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/check_result.dart';

part 'check_state.freezed.dart';

@freezed
abstract class CheckState with _$CheckState {
  const factory CheckState.loading() = _Loading;
  const factory CheckState.confirmed({required CheckResult result}) = _Confirmed;
  const factory CheckState.missing({required CheckResult result}) = _Missing;
  const factory CheckState.error({required String message}) = _Error;
}
