import '../../domain/entities/check_result.dart';
import '../../domain/repositories/check_repository.dart';
import '../../domain/repositories/checklist_repository.dart';
import '../services/check_ai_service.dart';

class CheckRepositoryImpl implements CheckRepository {
  CheckRepositoryImpl(this._checklistRepository, this._aiService);

  final ChecklistRepository _checklistRepository;
  final CheckAiService _aiService;
  CheckResult? _last;

  @override
  CheckResult? get lastResult => _last;

  @override
  Future<CheckResult> performCheck(String itemId, {String? photoPath}) async {
    final item = await _checklistRepository.getById(itemId);
    if (item == null) throw Exception('Item não encontrado');
    final detected = await _aiService.detect(item, photoPath);
    _last = CheckResult(item: item, detected: detected, timestamp: DateTime.now());
    return _last!;
  }
}
