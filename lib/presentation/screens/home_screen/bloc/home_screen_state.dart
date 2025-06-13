import 'package:dio/dio.dart';
import 'package:to_do_app/domain/entities/note.dart';

sealed class HomeScreenState {
  final List<NoteEntity>? notes;
  final bool showCompleted;
  final DioException? exception;

  HomeScreenState({this.notes, this.exception, this.showCompleted = true});
}

class NotesInitial extends HomeScreenState {
  NotesInitial();
}

class NotesLoading extends HomeScreenState {
  NotesLoading();
}

class NotesLoaded extends HomeScreenState {
  String? message;
  NotesLoaded(List<NoteEntity> notes, {super.showCompleted, this.message})
    : super(notes: notes);
}

class NotesError extends HomeScreenState {
  NotesError(DioException exception) : super(exception: exception);
}
