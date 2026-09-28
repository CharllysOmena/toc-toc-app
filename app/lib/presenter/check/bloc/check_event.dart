import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_event.freezed.dart';

@freezed
abstract class CheckEvent with _$CheckEvent {
  const factory CheckEvent.started() = _Started;
  const factory CheckEvent.captureRequested(String? photoPath) = _CaptureRequested;
}
