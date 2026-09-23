import '../entities/history_entry.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntry>> getHistory();
  Future<void> addToday({required bool confirmed});
}
