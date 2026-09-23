import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/check_repository.dart';
import '../../../domain/repositories/history_repository.dart';
import 'check_event.dart';
import 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc(this._checkRepository, this._historyRepository) : super(const CheckState.loading()) {
    on<CheckEvent>((event, emit) => event.when(started: () => _onStarted(emit)));
  }

  final CheckRepository _checkRepository;
  final HistoryRepository _historyRepository;

  Future<void> _onStarted(Emitter<CheckState> emit) async {
    emit(const CheckState.loading());
    try {
      final result = await _checkRepository.performCheck();
      final isConfirmed = result.missingIds.isEmpty;
      await _historyRepository.addToday(confirmed: isConfirmed);
      if (isConfirmed) {
        emit(CheckState.confirmed(result: result));
      } else {
        emit(CheckState.missing(result: result));
      }
    } catch (e) {
      emit(CheckState.error(message: e.toString()));
    }
  }
}
