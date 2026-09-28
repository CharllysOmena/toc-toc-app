import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/notification_service.dart';
import '../../../domain/repositories/checklist_repository.dart';
import 'checklist_event.dart';
import 'checklist_state.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  ChecklistBloc(this._repository, this._notificationService) : super(const ChecklistState.loading()) {
    on<ChecklistEvent>((event, emit) => event.when(
          started: () => _onStarted(emit),
          filterChanged: (day) => _onFilterChanged(day, emit),
          deleted: (id) => _onDeleted(id, emit),
        ));
  }

  final ChecklistRepository _repository;
  final NotificationService _notificationService;

  Future<void> _onStarted(Emitter<ChecklistState> emit) async {
    try {
      final now = DateTime.now();
      final weekday = now.weekday % 7;
      final items = await _repository.getAll();
      await _notificationService.syncAll(items);
      emit(ChecklistState.ready(items: items, selectedDay: weekday));
    } catch (e) {
      emit(ChecklistState.error(message: e.toString()));
    }
  }

  Future<void> _onFilterChanged(int? day, Emitter<ChecklistState> emit) async {
    final current = state;
    await current.maybeMap(
      ready: (s) async => emit(s.copyWith(selectedDay: day)),
      orElse: () async {},
    );
  }

  Future<void> _onDeleted(String id, Emitter<ChecklistState> emit) async {
    await _repository.delete(id);
    await _notificationService.cancelItem(id);
    final current = state;
    await current.maybeMap(
      ready: (s) async {
        final items = await _repository.getAll();
        emit(s.copyWith(items: items));
      },
      orElse: () async {},
    );
  }
}
