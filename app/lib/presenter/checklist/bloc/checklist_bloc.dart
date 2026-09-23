import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/checklist_repository.dart';
import 'checklist_event.dart';
import 'checklist_state.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  ChecklistBloc(this._repository) : super(const ChecklistState.loading()) {
    on<ChecklistEvent>(
      (event, emit) => event.when(
        started: () => _onStarted(emit),
        toggled: (id) => _onToggled(id, emit),
        saved: () => _onSaved(emit),
      ),
    );
  }

  final ChecklistRepository _repository;

  Future<void> _onStarted(Emitter<ChecklistState> emit) async {
    final items = await _repository.getItems();
    emit(ChecklistState.ready(items: items));
  }

  Future<void> _onToggled(String id, Emitter<ChecklistState> emit) async {
    await _repository.toggleItem(id);
    final items = await _repository.getItems();
    emit(ChecklistState.ready(items: items));
  }

  Future<void> _onSaved(Emitter<ChecklistState> emit) async {
    final current = state;
    await current.maybeMap(
      ready: (s) async => emit(ChecklistState.saving(items: s.items)),
      orElse: () async {},
    );
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final items = await _repository.getItems();
    emit(ChecklistState.ready(items: items));
  }
}
