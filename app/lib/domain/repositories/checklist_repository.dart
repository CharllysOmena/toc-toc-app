import '../entities/checklist_item.dart';

abstract class ChecklistRepository {
  Future<List<ChecklistItem>> getItems();
  Future<void> saveItems(List<ChecklistItem> items);
  Future<void> toggleItem(String id);
}
