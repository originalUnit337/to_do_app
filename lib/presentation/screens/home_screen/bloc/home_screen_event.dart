import 'package:equatable/equatable.dart';
import 'package:to_do_app/domain/entities/note.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object?> get props => [];
}

class GetAllNotesEvent extends HomeScreenEvent {
  const GetAllNotesEvent();
}

class ToggleNoteCompletion extends HomeScreenEvent {
  final NoteEntity note;
  const ToggleNoteCompletion(this.note);
}

class ToggleShowCompleted extends HomeScreenEvent {}
