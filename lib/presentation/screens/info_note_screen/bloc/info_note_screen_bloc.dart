import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_event.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_state.dart';

class InfoNoteScreenBloc
    extends Bloc<InfoNoteScreenEvent, InfoNoteScreenState> {
  final UpdateNoteUseCase _updateNoteUseCase;
  InfoNoteScreenBloc(this._updateNoteUseCase) : super(const InfoNoteInitial()) {
    on<SaveNoteEvent>(_saveNote);
  }

  FutureOr<void> _saveNote(
    SaveNoteEvent event,
    Emitter<InfoNoteScreenState> emit,
  ) async {
    final response = await _updateNoteUseCase(params: event.note);
    if (response.data ?? false) {
      emit(InfoNoteLoaded(event.note, isUpdated: true));
    } else {
      emit(InfoNoteError(Exception('Something went wrong')));
    }
  }
}
