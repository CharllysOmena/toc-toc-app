import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/history_repository.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._repository) : super(const HistoryState.loading()) {
    on<HistoryEvent>((event, emit) => event.when(started: () => _onStarted(emit)));
  }

  final HistoryRepository _repository;

  Future<void> _onStarted(Emitter<HistoryState> emit) async {
    try {
      final entries = await _repository.getHistory();
      emit(HistoryState.ready(entries: entries));
    } catch (e) {
      emit(HistoryState.error(message: e.toString()));
    }
  }
}
