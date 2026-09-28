import 'dart:io';

import 'package:app/domain/entities/monitored_object.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MonitoredObjects', () {
    test('expõe as 22 classes do modelo', () {
      expect(MonitoredObjects.all, hasLength(22));
    });

    test('mapeia o índice de classe na ordem do modelo', () {
      for (var i = 0; i < MonitoredObjects.all.length; i++) {
        expect(MonitoredObjects.all[i].modelClassIndex, i);
      }
    });

    test('labels batem com labels.txt do modelo', () {
      final labels = File('assets/models/labels.txt')
          .readAsLinesSync()
          .where((line) => line.trim().isNotEmpty)
          .toList();

      expect(labels, hasLength(MonitoredObjects.all.length));
      for (var i = 0; i < labels.length; i++) {
        expect(MonitoredObjects.all[i].label, labels[i].trim());
      }
    });

    test('byId retorna o objeto correspondente', () {
      expect(MonitoredObjects.byId('door').label, 'Porta');
      expect(MonitoredObjects.byId('leash').modelClassIndex, 21);
    });
  });
}
