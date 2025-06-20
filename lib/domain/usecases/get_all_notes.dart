import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/core/usecase/usecase.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class GetAllNotesUseCase implements UseCase<DataState<List<NoteEntity>>, void> {
  final NoteRepository _noteRepository;

  GetAllNotesUseCase(this._noteRepository);
  @override
  Future<DataState<List<NoteEntity>>> call({void params}) async {
    return _noteRepository.getAllNotes();
  }
}
