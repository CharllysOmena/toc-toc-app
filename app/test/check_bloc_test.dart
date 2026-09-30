import 'package:app/domain/entities/checklist_item.dart';
import 'package:app/domain/entities/day_time.dart';
import 'package:app/presenter/check/bloc/check_bloc.dart';
import 'package:app/presenter/check/bloc/check_event.dart';
import 'package:app/presenter/check/bloc/check_state.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes/fakes.dart';

ChecklistItem _scheduledNow({String id = 'item-1'}) {
  final now = DateTime.now();
  return ChecklistItem(
    id: id,
    title: 'Pegar chave',
    objectId: 'key',
    time: DayTime(hour: now.hour, minute: now.minute),
    weekDays: [now.weekday % 7],
    createdAt: now,
  );
}

void main() {
  late ChecklistItem item;
  late FakeChecklistRepository checklist;
  late FakeCheckRepository check;
  late FakeHistoryRepository history;
  late FakePhotoStorage photos;
  late CheckBloc bloc;

  setUp(() {
    item = _scheduledNow();
    checklist = FakeChecklistRepository({item.id: item});
    check = FakeCheckRepository(detected: false, item: item);
    history = FakeHistoryRepository();
    photos = FakePhotoStorage();
    bloc = CheckBloc(check, history, checklist, photos, item.id);
  });

  tearDown(() => bloc.close());

  Future<CheckState> waitFor(bool Function(CheckState) test) =>
      bloc.stream.firstWhere(test).timeout(const Duration(seconds: 2));

  Future<CheckState> toMissing() async {
    final ready = waitFor((s) => s.maybeMap(ready: (_) => true, orElse: () => false));
    bloc.add(const CheckEvent.started());
    await ready;
    final missing = waitFor((s) => s.maybeMap(missing: (_) => true, orElse: () => false));
    bloc.add(const CheckEvent.captureRequested('/tmp/foto.jpg'));
    return missing;
  }

  test('captura sem detecção entra em missing e mantém a foto', () async {
    final state = await toMissing();

    final result = state.maybeMap(missing: (m) => m.result, orElse: () => null);
    expect(result, isNotNull);
    expect(result!.photoPath, isNotNull);
    expect(photos.saved, hasLength(1));
    expect(photos.deleted, isEmpty);
    expect(history.calls, isEmpty);
    expect(checklist.registered, isEmpty);
  });

  test('confirmação manual registra o dia e marca manual=true', () async {
    final missing = await toMissing();
    final pendingPhoto = missing.maybeMap(missing: (m) => m.result.photoPath, orElse: () => null);

    final confirmedFuture = waitFor((s) => s.maybeMap(confirmed: (_) => true, orElse: () => false));
    bloc.add(const CheckEvent.manualConfirmed());
    final state = await confirmedFuture;

    final result = state.maybeMap(confirmed: (c) => c.result, orElse: () => null);
    expect(result, isNotNull);
    expect(result!.manual, isTrue);
    expect(result.detected, isTrue);
    expect(checklist.registered.containsKey(item.id), isTrue);
    expect(history.calls, hasLength(1));
    expect(history.calls.single.confirmed, isTrue);
    expect(history.calls.single.manual, isTrue);
    expect(history.calls.single.photoPath, pendingPhoto);
  });

  test('confirmação manual sem captura pendente emite erro', () async {
    final errorFuture = waitFor((s) => s.maybeMap(error: (_) => true, orElse: () => false));
    bloc.add(const CheckEvent.manualConfirmed());
    final state = await errorFuture;

    expect(state.maybeMap(error: (e) => e.message, orElse: () => null), isNotNull);
    expect(history.calls, isEmpty);
  });

  test('detecção automática confirma sem marcação manual', () async {
    check.detected = true;

    final ready = waitFor((s) => s.maybeMap(ready: (_) => true, orElse: () => false));
    bloc.add(const CheckEvent.started());
    await ready;

    final confirmedFuture = waitFor((s) => s.maybeMap(confirmed: (_) => true, orElse: () => false));
    bloc.add(const CheckEvent.captureRequested('/tmp/foto.jpg'));
    final state = await confirmedFuture;

    final result = state.maybeMap(confirmed: (c) => c.result, orElse: () => null);
    expect(result, isNotNull);
    expect(result!.manual, isFalse);
    expect(history.calls.single.manual, isFalse);
  });
}
