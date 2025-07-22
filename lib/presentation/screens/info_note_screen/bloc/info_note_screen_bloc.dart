import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'package:to_do_app/core/common/log/good_log.dart';
import 'package:to_do_app/domain/usecases/create_note.dart';
import 'package:to_do_app/domain/usecases/delete_note.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_event.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_state.dart';

class InfoNoteScreenBloc
    extends Bloc<InfoNoteScreenEvent, InfoNoteScreenState> {
  final Talker _talker;
  final UpdateNoteUseCase _updateNoteUseCase;
  final CreateNoteUseCase _createNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  InfoNoteScreenBloc(
    this._updateNoteUseCase,
    this._createNoteUseCase,
    this._deleteNoteUseCase,
    this._talker,
  ) : super(const InfoNoteInitial()) {
    _talker.log('Creating InfoNoteScreenBloc...');
    on<SaveNoteEvent>(_saveNote);
    on<CreateNoteEvent>(_createNote);
    on<DeleteNoteEvent>(_deleteNote);
  }

  FutureOr<void> _saveNote(
    SaveNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    _talker.log('[BLOC EVENT HANDLER] Saving note... ');
    final response = await _updateNoteUseCase(params: event.note);
    if (response.data ?? false) {
      _talker.logCustom(
        GoodLog('[BLOC EVENT HANDLER] Successfully note saved'),
      );
      emit(InfoNoteLoaded(event.note, isUpdated: true));
    } else {
      _talker.error('[BLOC EVENT HANDLER] Error during saving note...');
      emit(const InfoNoteError(InfoNoteErrorType.saveFailed));
    }
  }

  FutureOr<void> _createNote(
    CreateNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    _talker.log('[BLOC EVENT HANDLER] Creating note...');
    emit(const InfoNoteLoading());
    final response = await _createNoteUseCase(params: event.note);
    if (response.data != null) {
      _talker.logCustom(
        GoodLog('[BLOC EVENT HANDLER] SUCCESS Creating note ...'),
      );
      emit(InfoNoteLoaded(response.data!, isUpdated: true));
    } else {
      _talker.error('[BLOC EVENT HANDLER] ERROR creating note');
      emit(const InfoNoteError(InfoNoteErrorType.saveFailed));
    }
  }

  FutureOr<void> _deleteNote(
    DeleteNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    _talker.log('[BLOC EVENT HANDLER] Deleting note...');
    final response = await _deleteNoteUseCase(params: event.note);
    if (response.data ?? false) {
      _talker.logCustom(
        GoodLog('[BLOC EVENT HANDLER] SUCCESS Creating note...'),
      );
      emit(InfoNoteDeleted(event.note));
    } else {
      _talker.error('[BLOC EVENT HANDLER] ERROR deleting note');
      emit(const InfoNoteError(InfoNoteErrorType.deleteFailed));
    }
  }
}
