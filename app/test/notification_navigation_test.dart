import 'package:app/app_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('initialLocationForPayload', () {
    test('retorna null quando não há payload', () {
      expect(initialLocationForPayload(null), isNull);
    });

    test('mapeia o id do item para a rota de registro', () {
      expect(initialLocationForPayload('abc'), '/check/abc');
    });

    test('retorna null para payload vazio', () {
      expect(initialLocationForPayload(''), isNull);
    });

    test('retorna null para payload em branco', () {
      expect(initialLocationForPayload('   '), isNull);
    });

    test('codifica o id do item na rota', () {
      expect(initialLocationForPayload('a/b'), '/check/a%2Fb');
    });
  });
}
