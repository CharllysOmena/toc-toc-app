import 'package:app/app_module.dart';
import 'package:app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await GetIt.instance.reset();
    await setupDependencies();
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  testWidgets('WelcomePage renders on first launch', (tester) async {
    final router = createRouter();
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pump();

    expect(find.text('Toc Toc'), findsWidgets);
    expect(find.text('Confira uma vez. Siga em paz.'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
    expect(find.text('crie seu primeiro checklist'), findsOneWidget);
  });

  testWidgets('Navigates to checklist after welcome', (tester) async {
    final router = createRouter();
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pump();

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(find.text('Checklist'), findsOneWidget);
    expect(find.text('Hoje'), findsOneWidget);
    expect(find.text('Todos'), findsOneWidget);
  });

  testWidgets('Preserva deep link de check após o welcome', (tester) async {
    final router = createRouter(initialLocation: '/check/inexistente');
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Começar'), findsOneWidget);

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(find.text('Item não encontrado'), findsOneWidget);
  });

  testWidgets('Can create item and see it in list', (tester) async {
    final router = createRouter();
    await tester.pumpWidget(AppWidget(router: router));
    await tester.pump();
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Novo item'));
    await tester.pumpAndSettle();

    expect(find.text('Novo item'), findsWidgets);
    expect(find.text('Título'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Fechar porta');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Checklist'), findsOneWidget);
    await tester.tap(find.text('Todos'));
    await tester.pumpAndSettle();

    expect(find.text('Fechar porta'), findsWidgets);
    expect(find.textContaining('Fechar porta'), findsWidgets);
  });
}
