import 'dart:convert';

import '../../domain/entities/checklist_item.dart';
import '../../domain/repositories/checklist_repository.dart';
import '../services/preferences_service.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  ChecklistRepositoryImpl(this._prefs);

  final PreferencesService _prefs;
  static const _key = 'toc_checklist_items';

  @override
  Future<List<ChecklistItem>> getAll() async {
    final raw = await _prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<ChecklistItem>> getByDay(int weekday) async {
    final all = await getAll();
    return all.where((e) => e.weekDays.contains(weekday)).toList();
  }

  @override
  Future<ChecklistItem?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> create(ChecklistItem item) async {
    final all = await getAll();
    all.add(item);
    await _save(all);
  }

  @override
  Future<void> update(ChecklistItem item) async {
    final all = await getAll();
    final idx = all.indexWhere((e) => e.id == item.id);
    if (idx != -1) {
      all[idx] = item;
      await _save(all);
    }
  }

  @override
  Future<void> delete(String id) async {
    final all = await getAll();
    all.removeWhere((e) => e.id == id);
    await _save(all);
  }

  @override
  Future<void> markRegistered(String id, DateTime at) async {
    final item = await getById(id);
    if (item == null) return;
    await update(item.copyWith(registeredAt: at));
  }

  Future<void> _save(List<ChecklistItem> list) async {
    final raw = jsonEncode(list.map((e) => e.toJson()).toList());
    await _prefs.setString(_key, raw);
  }
}
