import 'package:app/data/services/camera_service.dart';
import 'package:app/domain/entities/checklist_item.dart';
import 'package:app/domain/entities/day_time.dart';
import 'package:app/presenter/check/bloc/check_bloc.dart';
import 'package:app/presenter/check/bloc/check_event.dart';
import 'package:app/presenter/check/bloc/check_state.dart';
import 'package:app/presenter/check/pages/check_page.dart';
import 'package:app/presenter/shared/widgets/app_cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fakes/fakes.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  late ChecklistItem item;
  late FakeChecklistRepository checklist;
  late FakeCheckRepository check;
  late FakeHistoryRepository history;
  late FakePhotoStorage photos;
  late CheckBloc bloc;

  setUp(() async {
    final now = DateTime.now();
    item = ChecklistItem(
      id: 'item-1',
      title: 'Pegar chave',
      objectId: 'key',
      time: DayTime(hour: now.hour, minute: now.minute),
      weekDays: [now.weekday % 7],
      createdAt: now,
    );
    checklist = FakeChecklistRepository({item.id: item});
    check = FakeCheckRepository(detected: false, item: item);
    history = FakeHistoryRepository();
    photos = FakePhotoStorage();
    await GetIt.instance.reset();
    GetIt.instance.registerSingleton<CameraService>(FakeCameraService());
    bloc = CheckBloc(check, history, checklist, photos, item.id);
  });

  tearDown(() async {
    await bloc.close();
    await GetIt.instance.reset();
  });

  testWidgets('estado missing oferece confirmação manual e leva ao confirmado', (tester) async {
    await tester.runAsync(() async {
      final ready = bloc.stream.firstWhere((s) => s.maybeMap(ready: (_) => true, orElse: () => false));
      bloc.add(const CheckEvent.started());
      await ready;
      final missing = bloc.stream.firstWhere((s) => s.maybeMap(missing: (_) => true, orElse: () => false));
      bloc.add(const CheckEvent.captureRequested('/tmp/foto.jpg'));
      await missing;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CheckBloc>.value(
          value: bloc,
          child: const CheckPage(itemId: 'item-1'),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Confirmar manualmente'), findsOneWidget);
    expect(find.textContaining('A IA não encontrou'), findsOneWidget);

    await tester.tap(find.widgetWithText(AppGhostButton, 'Confirmar manualmente'));
    await tester.pump();
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 30)));
    await tester.pump();
    await tester.pump();

    expect(find.text('Confirmado manualmente'), findsOneWidget);
  });
}
