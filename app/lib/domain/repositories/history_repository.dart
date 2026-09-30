import '../entities/history_entry.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntry>> getHistory({String? checklistId});
  Future<List<HistoryEntry>> getAllForChecklist(String checklistId);
  Future<void> addToday({
    required String checklistId,
    required bool confirmed,
    String? photoPath,
    bool manual = false,
  });
}
