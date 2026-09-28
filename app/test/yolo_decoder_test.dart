import 'dart:typed_data';

import 'package:app/data/services/yolo_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('YoloDecoder', () {
    const anchors = 3;
    const numClasses = 22;
    const channels = 4 + numClasses;

    Float32List buildOutput() {
      final output = Float32List(channels * anchors);
      void set(int channel, int anchor, double value) {
        output[channel * anchors + anchor] = value;
      }

      set(0, 0, 100);
      set(1, 0, 100);
      set(2, 0, 40);
      set(3, 0, 40);
      set(4 + 5, 0, 0.9);

      set(0, 1, 102);
      set(1, 1, 102);
      set(2, 1, 40);
      set(3, 1, 40);
      set(4 + 5, 1, 0.8);

      set(0, 2, 300);
      set(1, 2, 300);
      set(2, 2, 40);
      set(3, 2, 40);
      set(4 + 2, 2, 0.5);
      set(4 + 0, 2, 0.1);

      return output;
    }

    test('filtra por confiança e aplica NMS', () {
      const decoder = YoloDecoder(numClasses: numClasses);
      final detections = decoder.decode(buildOutput(), anchors: anchors);

      expect(detections, hasLength(2));
      expect(detections.first.classIndex, 5);
      expect(detections.first.confidence, closeTo(0.9, 1e-6));
      expect(detections.last.classIndex, 2);
    });

    test('containsClass identifica a classe alvo', () {
      const decoder = YoloDecoder(numClasses: numClasses);
      final detections = decoder.decode(buildOutput(), anchors: anchors);

      expect(decoder.containsClass(detections, 5), isTrue);
      expect(decoder.containsClass(detections, 2), isTrue);
      expect(decoder.containsClass(detections, 0), isFalse);
      expect(decoder.containsClass(detections, 21), isFalse);
    });

    test('respeita limiar de confiança customizado', () {
      const decoder = YoloDecoder(confidenceThreshold: 0.95, numClasses: numClasses);
      final detections = decoder.decode(buildOutput(), anchors: anchors);

      expect(detections, isEmpty);
    });

    test('lança para saída com tamanho inesperado', () {
      const decoder = YoloDecoder(numClasses: numClasses);
      expect(() => decoder.decode(Float32List(10), anchors: anchors), throwsArgumentError);
    });

    test('maxClassScore retorna o maior score da classe', () {
      const decoder = YoloDecoder(numClasses: numClasses);
      final output = buildOutput();

      expect(decoder.maxClassScore(output, anchors: anchors, classIndex: 5), closeTo(0.9, 1e-6));
      expect(decoder.maxClassScore(output, anchors: anchors, classIndex: 2), closeTo(0.5, 1e-6));
      expect(decoder.maxClassScore(output, anchors: anchors, classIndex: 0), closeTo(0.1, 1e-6));
      expect(decoder.maxClassScore(output, anchors: anchors, classIndex: 21), 0);
    });

    test('topCandidates lista os melhores sem aplicar limiar', () {
      const decoder = YoloDecoder(numClasses: numClasses);
      final candidates = decoder.topCandidates(buildOutput(), anchors: anchors, limit: 5);

      expect(candidates, hasLength(3));
      expect(candidates[0].classIndex, 5);
      expect(candidates[0].confidence, closeTo(0.9, 1e-6));
      expect(candidates[1].confidence, closeTo(0.8, 1e-6));
      expect(candidates[2].classIndex, 2);
    });
  });
}
