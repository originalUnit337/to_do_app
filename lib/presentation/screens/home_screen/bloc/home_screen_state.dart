import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/domain/entities/note.dart';

sealed class HomeScreenState extends Equatable {
  final List<NoteEntity>? notes;
  final bool showCompleted;
  final DioException? exception;

  const HomeScreenState({
    this.notes,
    this.exception,
    this.showCompleted = true,
  });

  @override
  List<Object?> get props => [notes, showCompleted, exception];
}

class NotesInitial extends HomeScreenState {
  const NotesInitial();
}

class NotesLoading extends HomeScreenState {
  const NotesLoading();
}

class NotesLoaded extends HomeScreenState {
  final String? message;
  const NotesLoaded(List<NoteEntity> notes, {super.showCompleted, this.message})
    : super(notes: notes);

  @override
  List<Object?> get props => [notes, showCompleted, exception, message];
}

class NotesError extends HomeScreenState {
  const NotesError(DioException exception) : super(exception: exception);
}
