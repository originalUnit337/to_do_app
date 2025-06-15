import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/data/api/model/document_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/domain/entities/note.dart';

abstract class NoteRepository {
  Future<DataState<List<NoteEntity>>> getAllNotes();
  Future<DataState<bool>> updateNote(NoteEntity note);
}
