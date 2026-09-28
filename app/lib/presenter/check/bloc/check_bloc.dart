import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/photo_storage.dart';
import '../../../domain/entities/check_result.dart';
import '../../../domain/entities/checklist_item.dart';
import '../../../domain/repositories/check_repository.dart';
import '../../../domain/repositories/checklist_repository.dart';
import '../../../domain/repositories/history_repository.dart';
import 'check_event.dart';
import 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc(this._checkRepository, this._historyRepository, this._checklistRepository, this._photoStorage, this._itemId) : super(const CheckState.loading()) {
    on<CheckEvent>((event, emit) => event.when(
          started: () => _onStarted(emit),
          captureRequested: (photoPath) => _onCaptureRequested(photoPath, emit),
        ));
  }

  final CheckRepository _checkRepository;
  final HistoryRepository _historyRepository;
  final ChecklistRepository _checklistRepository;
  final PhotoStorage _photoStorage;
  final String _itemId;

  Future<void> _onStarted(Emitter<CheckState> emit) async {
    emit(const CheckState.loading());
    try {
      final item = await _checklistRepository.getById(_itemId);
      if (item == null) {
        emit(const CheckState.error(message: 'Item não encontrado'));
        return;
      }
      if (item.isRegisteredToday(DateTime.now())) {
        final history = await _historyRepository.getHistory(checklistId: _itemId);
        final today = DateTime.now();
        final todayEntry = history.where((e) => e.date.year == today.year && e.date.month == today.month && e.date.day == today.day).toList();
        final photoPath = todayEntry.isNotEmpty ? todayEntry.last.photoPath : null;
        emit(CheckState.confirmed(
          result: CheckResult(
            item: item,
            detected: true,
            timestamp: item.registeredAt ?? today,
            photoPath: photoPath,
          ),
        ));
        return;
      }
      final now = DateTime.now();
      final reason = item.registerBlockReason(now);
      if (reason != null) {
        emit(CheckState.unavailable(item: item, message: reason));
        return;
      }
      emit(CheckState.ready(item: item));
    } catch (e) {
      emit(CheckState.error(message: e.toString()));
    }
  }

  Future<void> _onCaptureRequested(String? photoPath, Emitter<CheckState> emit) async {
    final current = state;
    ChecklistItem? item;
    await current.maybeMap(
      ready: (s) async => item = s.item,
      orElse: () async {},
    );
    item ??= await _checklistRepository.getById(_itemId);
    if (item == null) {
      emit(const CheckState.error(message: 'Item não encontrado'));
      return;
    }
    final now = DateTime.now();
    final effectiveItem = item!;
    final reason = effectiveItem.registerBlockReason(now);
    if (reason != null) {
      emit(CheckState.unavailable(item: effectiveItem, message: reason));
      return;
    }
    emit(CheckState.processing(item: effectiveItem));
    try {
      String? savedPath;
      if (photoPath != null) {
        savedPath = await _photoStorage.save(photoPath, _itemId);
      }
      final result = await _checkRepository.performCheck(_itemId, photoPath: savedPath);
      final resultWithPhoto = result.copyWith(photoPath: savedPath);
      if (result.detected) {
        if (kDebugMode) debugPrint('[Check] detectado=true -> registrando item $_itemId');
        await _checklistRepository.markRegistered(_itemId, DateTime.now());
        await _historyRepository.addToday(checklistId: _itemId, confirmed: true, photoPath: savedPath);
        emit(CheckState.confirmed(result: resultWithPhoto));
      } else {
        if (kDebugMode) debugPrint('[Check] detectado=false -> NÃO registra item $_itemId (motivo no log [CheckAI])');
        if (savedPath != null) await _photoStorage.delete(savedPath);
        emit(CheckState.missing(result: resultWithPhoto));
      }
    } catch (e) {
      emit(CheckState.error(message: e.toString()));
    }
  }
}
