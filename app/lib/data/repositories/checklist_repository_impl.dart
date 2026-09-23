import '../../domain/entities/checklist_item.dart';
import '../../domain/repositories/checklist_repository.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  ChecklistRepositoryImpl() : _items = List.of(_defaultItems);

  static const _defaultItems = [
    ChecklistItem(id: 'chave', label: 'Chave', emoji: '🔑', selected: true),
    ChecklistItem(id: 'carteira', label: 'Carteira', emoji: '👛', selected: true),
    ChecklistItem(id: 'celular', label: 'Celular', emoji: '📱', selected: true),
    ChecklistItem(id: 'mochila', label: 'Mochila', emoji: '🎒', selected: false),
  ];

  List<ChecklistItem> _items;

  @override
  Future<List<ChecklistItem>> getItems() async => List.unmodifiable(_items);

  @override
  Future<void> saveItems(List<ChecklistItem> items) async {
    _items = List.of(items);
  }

  @override
  Future<void> toggleItem(String id) async {
    _items = _items
        .map((e) => e.id == id ? e.copyWith(selected: !e.selected) : e)
        .toList();
  }
}
