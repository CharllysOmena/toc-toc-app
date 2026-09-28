import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_time.freezed.dart';
part 'day_time.g.dart';

@freezed
abstract class DayTime with _$DayTime {
  const factory DayTime({required int hour, required int minute}) = _DayTime;

  factory DayTime.fromJson(Map<String, dynamic> json) => _$DayTimeFromJson(json);
}

extension DayTimeX on DayTime {
  String format() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
