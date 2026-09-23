import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl() {
    final now = DateTime.now();
    _entries = List.generate(30, (i) {
      final date = DateTime(now.year, now.month, now.day - (29 - i));
      final confirmed = i < 20;
      return HistoryEntry(
        date: date,
        confirmed: confirmed,
        confirmedAt: confirmed
            ? DateTime(date.year, date.month, date.day, 8, 15)
            : null,
      );
    });
  }

  late List<HistoryEntry> _entries;

  @override
  Future<List<HistoryEntry>> getHistory() async => List.unmodifiable(_entries);

  @override
  Future<void> addToday({required bool confirmed}) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _entries = [
      for (final e in _entries)
        if (e.date != today) e,
      HistoryEntry(date: today, confirmed: confirmed, confirmedAt: now),
    ];
  }
}
