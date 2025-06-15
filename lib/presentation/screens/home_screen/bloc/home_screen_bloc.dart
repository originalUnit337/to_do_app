import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final GetAllNotesUseCase _getAllNotesUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  HomeScreenBloc(this._getAllNotesUseCase, this._updateNoteUseCase)
    : super(NotesInitial()) {
    on<GetAllNotesEvent>(_getAllNotes);
    on<ToggleNoteCompletion>(_toggleNoteCompletion);
    on<ToggleShowCompleted>(_toggleShowCompleted);
  }

  Future<void> _getAllNotes(
    GetAllNotesEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final notesData = await _getAllNotesUseCase();

    if (notesData is DataSuccess && notesData.data != null) {
      emit(NotesLoaded(notesData.data!));
    } else {
      if (notesData is DataFailed) {
        emit(NotesError(notesData.exception!));
      }
    }
  }

  FutureOr<void> _toggleNoteCompletion(
    ToggleNoteCompletion event,
    Emitter<HomeScreenState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      final response = await _updateNoteUseCase(
        params: event.note.copyWith(isCompleted: !event.note.isCompleted),
      );
      if (response.data ?? false) {
        final updatedNotes =
            currentState.notes?.map((note) {
              if (note == event.note) {
                return note.copyWith(isCompleted: !note.isCompleted);
              }
              return note;
            }).toList();
        if (updatedNotes != null) {
          emit(
            NotesLoaded(
              updatedNotes,
              showCompleted: currentState.showCompleted,
              isUpdated: response.data,
            ),
          );
        }
      } else {
        throw Exception('updatedNotes is null');
      }
    }
  }

  FutureOr<void> _toggleShowCompleted(
    ToggleShowCompleted event,
    Emitter<HomeScreenState> emit,
  ) async {
    if (state is NotesLoaded) {
      emit(NotesLoaded(state.notes ?? [], showCompleted: !state.showCompleted));
    }
  }
}
