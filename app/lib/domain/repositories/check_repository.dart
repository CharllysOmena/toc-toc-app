import '../entities/check_result.dart';

abstract class CheckRepository {
  Future<CheckResult> performCheck();
  CheckResult? get lastResult;
}
