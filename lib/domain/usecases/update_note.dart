import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/core/usecase/usecase.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class UpdateNoteUseCase implements UseCase<DataState<bool>, NoteEntity> {
  final NoteRepository _noteRepository;

  UpdateNoteUseCase(this._noteRepository);

  @override
  Future<DataState<bool>> call({required NoteEntity params}) async {
    return _noteRepository.updateNote(params);
  }
}
