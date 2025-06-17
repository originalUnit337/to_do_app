import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/core/usecase/usecase.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class CreateNoteUseCase implements UseCase<DataState<NoteEntity>, NoteEntity> {
  final NoteRepository _noteRepository;

  CreateNoteUseCase(this._noteRepository);

  @override
  Future<DataState<NoteEntity>> call({required NoteEntity params}) async {
    return _noteRepository.createNote(params);
  }
}
