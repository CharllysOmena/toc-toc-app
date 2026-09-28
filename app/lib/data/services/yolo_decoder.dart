import 'dart:math' as math;
import 'dart:typed_data';

class YoloDetection {
  const YoloDetection({
    required this.classIndex,
    required this.confidence,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  final int classIndex;
  final double confidence;
  final double left;
  final double top;
  final double right;
  final double bottom;

  double get area => math.max(0, right - left) * math.max(0, bottom - top);
}

class YoloDecoder {
  const YoloDecoder({
    this.confidenceThreshold = 0.35,
    this.iouThreshold = 0.45,
    this.numClasses = 22,
  });

  final double confidenceThreshold;
  final double iouThreshold;
  final int numClasses;

  List<YoloDetection> decode(Float32List output, {required int anchors}) {
    const boxValues = 4;
    final channels = boxValues + numClasses;
    if (output.length != channels * anchors) {
      throw ArgumentError('Saída inesperada: ${output.length} (esperado ${channels * anchors})');
    }

    final candidates = <YoloDetection>[];
    for (var anchor = 0; anchor < anchors; anchor++) {
      var bestClass = -1;
      var bestScore = confidenceThreshold;
      for (var c = 0; c < numClasses; c++) {
        final score = output[(boxValues + c) * anchors + anchor];
        if (score > bestScore) {
          bestScore = score;
          bestClass = c;
        }
      }
      if (bestClass < 0) continue;

      final cx = output[anchor];
      final cy = output[anchors + anchor];
      final w = output[2 * anchors + anchor];
      final h = output[3 * anchors + anchor];
      candidates.add(YoloDetection(
        classIndex: bestClass,
        confidence: bestScore,
        left: cx - w / 2,
        top: cy - h / 2,
        right: cx + w / 2,
        bottom: cy + h / 2,
      ));
    }

    candidates.sort((a, b) => b.confidence.compareTo(a.confidence));
    final kept = <YoloDetection>[];
    for (final candidate in candidates) {
      final overlaps = kept.any((other) => _iou(candidate, other) > iouThreshold);
      if (!overlaps) kept.add(candidate);
    }
    return kept;
  }

  bool containsClass(List<YoloDetection> detections, int classIndex) =>
      detections.any((d) => d.classIndex == classIndex);

  double maxClassScore(Float32List output, {required int anchors, required int classIndex}) {
    var best = 0.0;
    for (var anchor = 0; anchor < anchors; anchor++) {
      final score = output[(4 + classIndex) * anchors + anchor];
      if (score > best) best = score;
    }
    return best;
  }

  List<YoloDetection> topCandidates(Float32List output, {required int anchors, int limit = 5}) {
    const boxValues = 4;
    final channels = boxValues + numClasses;
    if (output.length != channels * anchors) {
      throw ArgumentError('Saída inesperada: ${output.length} (esperado ${channels * anchors})');
    }

    final candidates = <YoloDetection>[];
    for (var anchor = 0; anchor < anchors; anchor++) {
      var bestClass = 0;
      var bestScore = -1.0;
      for (var c = 0; c < numClasses; c++) {
        final score = output[(boxValues + c) * anchors + anchor];
        if (score > bestScore) {
          bestScore = score;
          bestClass = c;
        }
      }
      final cx = output[anchor];
      final cy = output[anchors + anchor];
      final w = output[2 * anchors + anchor];
      final h = output[3 * anchors + anchor];
      candidates.add(YoloDetection(
        classIndex: bestClass,
        confidence: bestScore,
        left: cx - w / 2,
        top: cy - h / 2,
        right: cx + w / 2,
        bottom: cy + h / 2,
      ));
    }

    candidates.sort((a, b) => b.confidence.compareTo(a.confidence));
    return candidates.take(limit).toList();
  }

  double _iou(YoloDetection a, YoloDetection b) {
    final interLeft = math.max(a.left, b.left);
    final interTop = math.max(a.top, b.top);
    final interRight = math.min(a.right, b.right);
    final interBottom = math.min(a.bottom, b.bottom);
    final interArea = math.max(0, interRight - interLeft) * math.max(0, interBottom - interTop);
    if (interArea == 0) return 0;
    final union = a.area + b.area - interArea;
    return union <= 0 ? 0 : interArea / union;
  }
}
