import 'package:dio/dio.dart';
import 'package:to_do_app/domain/entities/note.dart';

abstract class HomeScreenState {
  final List<NoteEntity>? notes;
  final DioException? exception;

  const HomeScreenState({this.notes, this.exception});
}

class NotesLoading extends HomeScreenState {
  const NotesLoading();
}

class NotesLoaded extends HomeScreenState {
  const NotesLoaded(List<NoteEntity> notes) : super(notes: notes);
}

class NotesError extends HomeScreenState {
  const NotesError(DioException exception) : super(exception: exception);
}
