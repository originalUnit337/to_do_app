import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/core/usecase/usecase.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class SyncNoteUseCase implements UseCase<DataState<bool>, void> {
  final NoteRepository _noteRepository;

  SyncNoteUseCase(this._noteRepository);

  @override
  Future<DataState<bool>> call({void params}) {
    return _noteRepository.syncNotes();
  }
}
