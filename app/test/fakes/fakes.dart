import 'package:app/data/services/camera_service.dart';
import 'package:app/data/services/photo_storage.dart';
import 'package:app/domain/entities/check_result.dart';
import 'package:app/domain/entities/checklist_item.dart';
import 'package:app/domain/entities/history_entry.dart';
import 'package:app/domain/repositories/check_repository.dart';
import 'package:app/domain/repositories/checklist_repository.dart';
import 'package:app/domain/repositories/history_repository.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FakeChecklistRepository implements ChecklistRepository {
  FakeChecklistRepository(this.items);

  final Map<String, ChecklistItem> items;
  final Map<String, DateTime> registered = {};

  @override
  Future<List<ChecklistItem>> getAll() async => items.values.toList();

  @override
  Future<List<ChecklistItem>> getByDay(int weekday) async =>
      items.values.where((e) => e.weekDays.contains(weekday)).toList();

  @override
  Future<ChecklistItem?> getById(String id) async => items[id];

  @override
  Future<void> create(ChecklistItem item) async => items[item.id] = item;

  @override
  Future<void> update(ChecklistItem item) async => items[item.id] = item;

  @override
  Future<void> delete(String id) async => items.remove(id);

  @override
  Future<void> markRegistered(String id, DateTime at) async {
    registered[id] = at;
    final current = items[id];
    if (current != null) items[id] = current.copyWith(registeredAt: at);
  }
}

class FakeCheckRepository implements CheckRepository {
  FakeCheckRepository({required this.detected, required this.item});

  bool detected;
  ChecklistItem item;

  @override
  CheckResult? lastResult;

  @override
  Future<CheckResult> performCheck(String itemId, {String? photoPath}) async {
    lastResult = CheckResult(
      item: item,
      detected: detected,
      timestamp: DateTime.now(),
      photoPath: photoPath,
    );
    return lastResult!;
  }
}

class HistoryAddCall {
  const HistoryAddCall({
    required this.checklistId,
    required this.confirmed,
    required this.manual,
    this.photoPath,
  });

  final String checklistId;
  final bool confirmed;
  final bool manual;
  final String? photoPath;
}

class FakeHistoryRepository implements HistoryRepository {
  final List<HistoryAddCall> calls = [];
  final List<HistoryEntry> entries = [];

  @override
  Future<List<HistoryEntry>> getHistory({String? checklistId}) async => entries;

  @override
  Future<List<HistoryEntry>> getAllForChecklist(String checklistId) async => entries;

  @override
  Future<void> addToday({
    required String checklistId,
    required bool confirmed,
    String? photoPath,
    bool manual = false,
  }) async {
    calls.add(HistoryAddCall(
      checklistId: checklistId,
      confirmed: confirmed,
      manual: manual,
      photoPath: photoPath,
    ));
    entries.add(HistoryEntry(
      date: DateTime.now(),
      confirmed: confirmed,
      confirmedAt: DateTime.now(),
      photoPath: photoPath,
      manual: manual,
    ));
  }
}

class FakePhotoStorage implements PhotoStorage {
  final List<String> saved = [];
  final List<String?> deleted = [];

  @override
  Future<String?> save(String sourcePath, String itemId) async {
    final path = '${itemId}_saved_${saved.length}.jpg';
    saved.add(path);
    return path;
  }

  @override
  Future<void> delete(String? path) async => deleted.add(path);

  @override
  Future<void> deleteAllForItem(String itemId) async {}
}

class FakeCameraService implements CameraService {
  bool initialized = false;

  @override
  Future<void> initialize() async => initialized = true;

  @override
  Widget buildPreview() => const SizedBox.shrink();

  @override
  Future<XFile?> takePicture() async => null;

  @override
  Future<void> dispose() async => initialized = false;
}
