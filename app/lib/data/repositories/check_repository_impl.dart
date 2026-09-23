import '../../domain/entities/check_result.dart';
import '../../domain/repositories/check_repository.dart';
import '../../domain/repositories/checklist_repository.dart';

class CheckRepositoryImpl implements CheckRepository {
  CheckRepositoryImpl(this._checklistRepository);

  final ChecklistRepository _checklistRepository;
  CheckResult? _last;

  @override
  CheckResult? get lastResult => _last;

  @override
  Future<CheckResult> performCheck() async {
    final items = await _checklistRepository.getItems();
    final selected = items.where((e) => e.selected).toList();
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final missingIds = <String>[];
    if (selected.any((e) => e.id == 'carteira')) {
      final shouldMiss = DateTime.now().millisecond % 3 == 0;
      if (shouldMiss) {
        missingIds.add('carteira');
      }
    }

    _last = CheckResult(
      timestamp: DateTime.now(),
      items: selected,
      missingIds: missingIds,
    );
    return _last!;
  }
}
