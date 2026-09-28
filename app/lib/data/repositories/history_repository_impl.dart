import 'dart:convert';

import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../services/preferences_service.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._prefs);

  final PreferencesService _prefs;

  String _key(String checklistId) => 'toc_history_$checklistId';

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Future<List<HistoryEntry>> getHistory({String? checklistId}) async {
    if (checklistId == null) return [];
    final raw = await _prefs.getString(_key(checklistId));
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    final entries = list.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>)).toList();
    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  @override
  Future<List<HistoryEntry>> getAllForChecklist(String checklistId) => getHistory(checklistId: checklistId);

  @override
  Future<void> addToday({required String checklistId, required bool confirmed, String? photoPath}) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entries = await getHistory(checklistId: checklistId);
    final filtered = entries.where((e) => !_sameDay(e.date, today)).toList();
    filtered.add(HistoryEntry(date: today, confirmed: confirmed, confirmedAt: now, photoPath: photoPath));
    final raw = jsonEncode(filtered.map((e) => e.toJson()).toList());
    await _prefs.setString(_key(checklistId), raw);
  }
}
