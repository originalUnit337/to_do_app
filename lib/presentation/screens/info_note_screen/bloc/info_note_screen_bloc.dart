import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/domain/usecases/create_note.dart';
import 'package:to_do_app/domain/usecases/delete_note.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_event.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_state.dart';

class InfoNoteScreenBloc
    extends Bloc<InfoNoteScreenEvent, InfoNoteScreenState> {
  final UpdateNoteUseCase _updateNoteUseCase;
  final CreateNoteUseCase _createNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  InfoNoteScreenBloc(
    this._updateNoteUseCase,
    this._createNoteUseCase,
    this._deleteNoteUseCase,
  ) : super(const InfoNoteInitial()) {
    on<SaveNoteEvent>(_saveNote);
    on<CreateNoteEvent>(_createNote);
    on<DeleteNoteEvent>(_deleteNote);
  }

  FutureOr<void> _saveNote(
    SaveNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    final response = await _updateNoteUseCase(params: event.note);
    if (response.data ?? false) {
      emit(InfoNoteLoaded(event.note, isUpdated: true));
    } else {
      emit(const InfoNoteError(InfoNoteErrorType.saveFailed));
    }
  }

  FutureOr<void> _createNote(
    CreateNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    emit(const InfoNoteLoading());
    final response = await _createNoteUseCase(params: event.note);
    if (response.data != null) {
      emit(InfoNoteLoaded(response.data!, isUpdated: true));
    } else {
      emit(const InfoNoteError(InfoNoteErrorType.saveFailed));
    }
  }

  FutureOr<void> _deleteNote(
    DeleteNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    final response = await _deleteNoteUseCase(params: event.note);
    if (response.data ?? false) {
      emit(InfoNoteDeleted(event.note));
    } else {
      emit(const InfoNoteError(InfoNoteErrorType.deleteFailed));
    }
  }
}
