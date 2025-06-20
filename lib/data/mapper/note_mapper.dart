import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/domain/entities/note.dart';

class NoteMapper {
  static NoteModel toModel(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      textNote: entity.textNote,
      importance: entity.importance,
      isCompleted: entity.isCompleted,
      makeBefore: entity.makeBefore,
    );
  }

  static NoteEntity toEntity(NoteModel model) {
    return NoteEntity(
      id: model.id,
      textNote: model.textNote,
      importance: model.importance,
      isCompleted: model.isCompleted,
      makeBefore: model.makeBefore,
    );
  }
}
