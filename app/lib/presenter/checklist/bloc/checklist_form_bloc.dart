import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/notification_service.dart';
import '../../../domain/entities/checklist_item.dart';
import '../../../domain/entities/day_time.dart';
import '../../../domain/repositories/checklist_repository.dart';
import 'checklist_form_event.dart';
import 'checklist_form_state.dart';

class ChecklistFormBloc extends Bloc<ChecklistFormEvent, ChecklistFormState> {
  ChecklistFormBloc(this._repository, this._notificationService) : super(const ChecklistFormState.loading()) {
    on<ChecklistFormEvent>((event, emit) => event.when(
          started: (id) => _onStarted(id, emit),
          titleChanged: (title) => _onTitleChanged(title, emit),
          objectChanged: (objectId) => _onObjectChanged(objectId, emit),
          timeChanged: (time) => _onTimeChanged(time, emit),
          weekDayToggled: (day) => _onWeekDayToggled(day, emit),
          saved: () => _onSaved(emit),
        ));
  }

  final ChecklistRepository _repository;
  final NotificationService _notificationService;

  Future<void> _onStarted(String? id, Emitter<ChecklistFormState> emit) async {
    if (id == null) {
      emit(const ChecklistFormState.ready(
        title: '',
        objectId: 'door',
        time: DayTime(hour: 8, minute: 0),
        weekDays: [1, 2, 3, 4, 5],
      ));
      return;
    }
    final item = await _repository.getById(id);
    if (item == null) {
      emit(const ChecklistFormState.error(message: 'Item não encontrado'));
      return;
    }
    emit(ChecklistFormState.ready(
      id: item.id,
      title: item.title,
      objectId: item.objectId,
      time: item.time,
      weekDays: item.weekDays,
    ));
  }

  void _onTitleChanged(String title, Emitter<ChecklistFormState> emit) {
    state.maybeMap(ready: (s) => emit(s.copyWith(title: title)), orElse: () {});
  }

  void _onObjectChanged(String objectId, Emitter<ChecklistFormState> emit) {
    state.maybeMap(ready: (s) => emit(s.copyWith(objectId: objectId)), orElse: () {});
  }

  void _onTimeChanged(DayTime time, Emitter<ChecklistFormState> emit) {
    state.maybeMap(ready: (s) => emit(s.copyWith(time: time)), orElse: () {});
  }

  void _onWeekDayToggled(int day, Emitter<ChecklistFormState> emit) {
    state.maybeMap(
      ready: (s) {
        final days = List<int>.from(s.weekDays);
        if (days.contains(day)) {
          days.remove(day);
        } else {
          days.add(day);
        }
        emit(s.copyWith(weekDays: days));
      },
      orElse: () {},
    );
  }

  Future<void> _onSaved(Emitter<ChecklistFormState> emit) async {
    final current = state;
    await current.maybeMap(
      ready: (s) async {
        if (s.title.trim().isEmpty) {
          emit(s.copyWith(error: 'Informe um título'));
          return;
        }
        if (s.weekDays.isEmpty) {
          emit(s.copyWith(error: 'Selecione ao menos um dia'));
          return;
        }
        final item = ChecklistItem(
          id: s.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          title: s.title.trim(),
          objectId: s.objectId,
          time: s.time,
          weekDays: s.weekDays,
          createdAt: DateTime.now(),
          registeredAt: null,
        );
        if (s.id == null) {
          await _repository.create(item);
        } else {
          final existing = await _repository.getById(s.id!);
          await _repository.update(item.copyWith(registeredAt: existing?.registeredAt, createdAt: existing?.createdAt ?? DateTime.now()));
        }
        final saved = await _repository.getById(item.id) ?? item;
        await _notificationService.requestPermission();
        await _notificationService.syncItem(saved);
        emit(const ChecklistFormState.success());
      },
      orElse: () async {},
    );
  }
}
