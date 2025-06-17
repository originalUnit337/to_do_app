import 'package:equatable/equatable.dart';
import 'package:to_do_app/domain/entities/note.dart';

sealed class InfoNoteScreenState extends Equatable {
  const InfoNoteScreenState();

  @override
  List<Object?> get props => [];
}

class InfoNoteInitial extends InfoNoteScreenState {
  const InfoNoteInitial();
}

class InfoNoteLoading extends InfoNoteScreenState {
  const InfoNoteLoading();
}

class InfoNoteLoaded extends InfoNoteScreenState {
  final NoteEntity note;
  final bool isUpdated;

  const InfoNoteLoaded(this.note, {required this.isUpdated});
  @override
  List<Object?> get props => [note, isUpdated];
}

class InfoNoteError extends InfoNoteScreenState {
  final Exception _exception;

  const InfoNoteError(this._exception);

  Exception get exception => _exception;
}

class InfoNoteDeleted extends InfoNoteScreenState {
  final NoteEntity note;
  const InfoNoteDeleted(this.note);
}
