import '../entities/check_result.dart';

abstract class CheckRepository {
  Future<CheckResult> performCheck(String itemId, {String? photoPath});
  CheckResult? get lastResult;
}
