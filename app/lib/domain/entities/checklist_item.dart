import 'package:freezed_annotation/freezed_annotation.dart';

import 'day_time.dart';

part 'checklist_item.freezed.dart';
part 'checklist_item.g.dart';

@freezed
abstract class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String id,
    required String title,
    required String objectId,
    required DayTime time,
    required List<int> weekDays,
    required DateTime createdAt,
    DateTime? registeredAt,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => _$ChecklistItemFromJson(json);
}

extension ChecklistItemX on ChecklistItem {
  bool isRegisteredToday(DateTime now) {
    if (registeredAt == null) return false;
    return registeredAt!.year == now.year && registeredAt!.month == now.month && registeredAt!.day == now.day;
  }

  bool isScheduledToday(DateTime now) => weekDays.contains(now.weekday % 7);

  DateTime scheduledToday(DateTime now) => DateTime(now.year, now.month, now.day, time.hour, time.minute);

  bool isWithinWindow(DateTime now, {Duration tolerance = const Duration(hours: 1)}) {
    if (!isScheduledToday(now)) return false;
    final scheduled = scheduledToday(now);
    final diff = now.difference(scheduled).abs();
    return diff <= tolerance;
  }

  bool canRegisterAt(DateTime now) => !isRegisteredToday(now) && isWithinWindow(now);

  String? registerBlockReason(DateTime now) {
    if (isRegisteredToday(now)) return null;
    if (!isScheduledToday(now)) return 'Disponível apenas nos dias configurados';
    if (!isWithinWindow(now)) return 'Fora do horário (${time.format()} ± 1h)';
    return null;
  }

  String windowLabel() {
    final start = DateTime(0, 1, 1, time.hour, time.minute).subtract(const Duration(hours: 1));
    final end = DateTime(0, 1, 1, time.hour, time.minute).add(const Duration(hours: 1));
    String fmt(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    return 'Registre entre ${fmt(start)} e ${fmt(end)}';
  }
}
