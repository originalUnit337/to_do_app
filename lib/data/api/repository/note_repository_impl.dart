import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  @override
  Future<DataState<List<NoteModel>>> getAllNotes() {
    // TODO: implement getAllNotes
    throw UnimplementedError();
  }
}
