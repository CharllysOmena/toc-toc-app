import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../domain/entities/checklist_item.dart';
import '../../domain/entities/monitored_object.dart';
import 'yolo_decoder.dart';

const _inputSize = 416;
const _anchors = 3549;
const _scales = [1.0, 0.7, 0.5, 0.35];

const _defaultConfidence = 0.30;
const _defaultIou = 0.45;
const _confidenceEnv = String.fromEnvironment('AI_CONF_THRESHOLD');
const _iouEnv = String.fromEnvironment('AI_IOU_THRESHOLD');

double _resolveThreshold(String raw, double fallback) {
  if (raw.isEmpty) return fallback;
  return double.tryParse(raw) ?? fallback;
}

void _log(String message) {
  if (kDebugMode) debugPrint(message);
}

String _labelForClass(int classIndex) {
  for (final object in MonitoredObjects.all) {
    if (object.modelClassIndex == classIndex) return object.label;
  }
  return '?';
}

abstract class CheckAiService {
  Future<bool> detect(ChecklistItem item, String? photoPath);
}

class CheckAiServiceImpl implements CheckAiService {
  CheckAiServiceImpl({
    this.modelAsset = 'assets/models/yoloworld.tflite',
    double? confidenceThreshold,
    double? iouThreshold,
  }) : _decoder = YoloDecoder(
          confidenceThreshold: confidenceThreshold ?? _resolveThreshold(_confidenceEnv, _defaultConfidence),
          iouThreshold: iouThreshold ?? _resolveThreshold(_iouEnv, _defaultIou),
        );

  final String modelAsset;
  final YoloDecoder _decoder;

  Interpreter? _interpreter;
  IsolateInterpreter? _isolateInterpreter;
  Future<void>? _loading;

  Future<void> _ensureLoaded() => _loading ??= _load();

  Future<void> _load() async {
    final interpreter = await Interpreter.fromAsset(
      modelAsset,
      options: InterpreterOptions()..threads = 4,
    );
    _interpreter = interpreter;
    _isolateInterpreter = await IsolateInterpreter.create(address: interpreter.address);
    _log('[CheckAI] modelo carregado: $modelAsset');
  }

  @override
  Future<bool> detect(ChecklistItem item, String? photoPath) async {
    final object = MonitoredObjects.byId(item.objectId);
    _log('[CheckAI] modelo=$modelAsset limiar=${_decoder.confidenceThreshold} iou=${_decoder.iouThreshold} escalas=$_scales');
    _log('[CheckAI] alvo: id=${item.objectId} label=${object.label} classe=${object.modelClassIndex}');

    if (photoPath == null || photoPath.isEmpty) {
      _log('[CheckAI] sem foto -> NÃO DETECTADO');
      return false;
    }

    try {
      await _ensureLoaded();
      final interpreter = _isolateInterpreter;
      if (_interpreter == null || interpreter == null) {
        _log('[CheckAI] interpretador indisponível -> NÃO DETECTADO');
        return false;
      }

      final batch = await compute(_preprocessPhoto, photoPath);
      final channels = 4 + _decoder.numClasses;
      final target = object.modelClassIndex;
      var best = 0.0;
      var detected = false;

      final stopwatch = Stopwatch()..start();
      for (var i = 0; i < batch.length; i++) {
        final scale = _scales[i];
        final input = batch[i].reshape<double>([1, _inputSize, _inputSize, 3]);
        final output = List<double>.filled(channels * _anchors, 0).reshape<double>([1, channels, _anchors]);
        await interpreter.run(input, output);

        final flat = _flatten(output, channels);
        final targetMax = _decoder.maxClassScore(flat, anchors: _anchors, classIndex: target);
        best = math.max(best, targetMax);

        final detections = _decoder.decode(flat, anchors: _anchors);
        final nearMisses = _decoder.topCandidates(flat, anchors: _anchors, limit: 3);
        _log('[CheckAI] escala=$scale alvo($target/${object.label})=${targetMax.toStringAsFixed(3)} '
            'detecções=${detections.length} '
            'top=${nearMisses.map((d) => '${d.classIndex}(${_labelForClass(d.classIndex)})=${d.confidence.toStringAsFixed(3)}').join(', ')}');

        if (targetMax >= _decoder.confidenceThreshold) {
          detected = true;
          break;
        }
      }
      stopwatch.stop();

      _log('[CheckAI] inferência total em ${stopwatch.elapsedMilliseconds} ms');
      _log('[CheckAI] score máx da classe alvo ($target/${object.label}): ${best.toStringAsFixed(3)}');
      _log('[CheckAI] veredito: ${detected ? 'DETECTADO' : 'NÃO DETECTADO'}');
      return detected;
    } catch (e, stackTrace) {
      _log('[CheckAI] erro: $e');
      if (kDebugMode) debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  Float32List _flatten(List output, int channels) {
    final flat = Float32List(channels * _anchors);
    for (var c = 0; c < channels; c++) {
      final row = output[0][c] as List;
      for (var a = 0; a < _anchors; a++) {
        flat[c * _anchors + a] = (row[a] as num).toDouble();
      }
    }
    return flat;
  }
}

List<Float32List> _preprocessPhoto(String photoPath) {
  final bytes = File(photoPath).readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw const FormatException('Não foi possível decodificar a foto');
  }
  final image = img.bakeOrientation(decoded);

  final result = <Float32List>[];
  for (final scale in _scales) {
    final target = _inputSize * scale;
    final fit = math.min(target / image.width, target / image.height);
    final newWidth = (image.width * fit).round().clamp(1, _inputSize);
    final newHeight = (image.height * fit).round().clamp(1, _inputSize);

    final canvas = img.Image(width: _inputSize, height: _inputSize);
    img.fill(canvas, color: img.ColorRgb8(114, 114, 114));
    final resized = img.copyResize(
      image,
      width: newWidth,
      height: newHeight,
      interpolation: img.Interpolation.linear,
    );
    img.compositeImage(canvas, resized, dstX: (_inputSize - newWidth) ~/ 2, dstY: (_inputSize - newHeight) ~/ 2);

    final flat = Float32List(_inputSize * _inputSize * 3);
    var i = 0;
    for (var y = 0; y < _inputSize; y++) {
      for (var x = 0; x < _inputSize; x++) {
        final pixel = canvas.getPixel(x, y);
        flat[i++] = pixel.r / 255.0;
        flat[i++] = pixel.g / 255.0;
        flat[i++] = pixel.b / 255.0;
      }
    }
    result.add(flat);
  }
  return result;
}
