import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/entities/checklist_item.dart';

abstract class NotificationService {
  Future<void> init();
  set onSelect(void Function(String itemId) callback);
  Future<String?> getLaunchPayload();
  Future<bool> requestPermission();
  Future<void> syncAll(List<ChecklistItem> items);
  Future<void> syncItem(ChecklistItem item);
  Future<void> cancelItem(String itemId);
  Future<void> cancelAll();
}

class NotificationServiceImpl implements NotificationService {
  NotificationServiceImpl();

  final _plugin = FlutterLocalNotificationsPlugin();
  void Function(String itemId)? _onSelect;

  @override
  set onSelect(void Function(String itemId) callback) => _onSelect = callback;

  @override
  Future<String?> getLaunchPayload() async {
    try {
      final details = await _plugin.getNotificationAppLaunchDetails();
      if (details?.didNotificationLaunchApp == true) {
        return details!.notificationResponse?.payload;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> init() async {
    try {
      tz.initializeTimeZones();
      try {
        final timeZoneName = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timeZoneName));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
      }

      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );
      await _plugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) {
          final payload = response.payload;
          if (payload != null && payload.isNotEmpty) {
            _onSelect?.call(payload);
          }
        },
      );
    } catch (_) {}
  }

  @override
  Future<bool> requestPermission() async {
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      final androidGranted =
          await android?.requestNotificationsPermission() ?? true;
      final iosGranted =
          await ios?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          true;
      return androidGranted && iosGranted;
    } catch (_) {
      return true;
    }
  }

  @override
  Future<void> syncAll(List<ChecklistItem> items) async {
    try {
      await cancelAll();
      for (final item in items) {
        await syncItem(item);
      }
    } catch (_) {}
  }

  @override
  Future<void> syncItem(ChecklistItem item) async {
    try {
      await cancelItem(item.id);
      if (item.isRegisteredToday(DateTime.now())) return;
      for (final day in item.weekDays) {
        final id = _notificationId(item.id, day);
        final scheduled = _nextInstance(day, item.time.hour, item.time.minute);
        await _plugin.zonedSchedule(
          id,
          'Toc Toc — ${item.title}',
          'Hora de conferir: ${item.title}',
          scheduled,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'toc_reminders',
              'Lembretes',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: item.id,
        );
      }
    } catch (_) {}
  }

  @override
  Future<void> cancelItem(String itemId) async {
    try {
      for (var day = 0; day < 7; day++) {
        await _plugin.cancel(_notificationId(itemId, day));
      }
    } catch (_) {}
  }

  @override
  Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (_) {}
  }

  int _notificationId(String itemId, int day) =>
      (itemId.hashCode + day) & 0x7fffffff;

  tz.TZDateTime _nextInstance(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    final targetWeekday = weekday == 0 ? 7 : weekday;
    while (scheduled.weekday != targetWeekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
