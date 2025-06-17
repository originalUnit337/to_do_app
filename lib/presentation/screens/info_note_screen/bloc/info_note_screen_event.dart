import 'package:to_do_app/domain/entities/note.dart';

sealed class InfoNoteScreenEvent {
  const InfoNoteScreenEvent();
}

class SaveNoteEvent extends InfoNoteScreenEvent {
  final NoteEntity note;
  const SaveNoteEvent(this.note);
}

class CreateNoteEvent extends InfoNoteScreenEvent {
  final NoteEntity note;
  const CreateNoteEvent(this.note);
}
