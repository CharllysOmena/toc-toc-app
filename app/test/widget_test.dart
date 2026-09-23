import 'package:app/app_module.dart';
import 'package:app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp(() async {
    await GetIt.instance.reset();
    await setupDependencies();
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  testWidgets('WelcomePage renders', (tester) async {
    final router = createRouter();
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pump();

    expect(find.text('Toc Toc'), findsWidgets);
    expect(find.text('Confira uma vez. Siga em paz.'), findsOneWidget);
    expect(find.text('Configurar meu checklist'), findsOneWidget);
    expect(find.text('leva cerca de 30 segundos'), findsOneWidget);
  });

  testWidgets('ChecklistPage renders after navigation', (tester) async {
    final router = createRouter();
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pump();

    await tester.tap(find.text('Configurar meu checklist'));
    await tester.pumpAndSettle();

    expect(find.text('Aponte para o lugar de sempre'), findsOneWidget);
    expect(find.text('Salvar checklist'), findsOneWidget);
  });

  testWidgets('Check flow renders', (tester) async {
    final router = createRouter();
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pump();

    await tester.tap(find.text('Configurar meu checklist'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar checklist'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
