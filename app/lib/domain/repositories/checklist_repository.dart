import '../entities/checklist_item.dart';

abstract class ChecklistRepository {
  Future<List<ChecklistItem>> getAll();
  Future<List<ChecklistItem>> getByDay(int weekday);
  Future<ChecklistItem?> getById(String id);
  Future<void> create(ChecklistItem item);
  Future<void> update(ChecklistItem item);
  Future<void> delete(String id);
  Future<void> markRegistered(String id, DateTime at);
}
