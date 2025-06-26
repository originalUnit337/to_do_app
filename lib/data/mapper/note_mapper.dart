import 'package:to_do_app/core/common/enums/importance.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/data/data_sources/local/note_local_service.dart';
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

  static NoteEntity fromLocalToEntity(Note note) {
    return NoteEntity(
      id: '',
      textNote: note.textNote,
      importance: Importance.fromString(note.importance),
      isCompleted: note.isCompleted,
      makeBefore: DateTime.tryParse(note.makeBefore ?? ''),
    );
  }

  static Note toLocal(NoteEntity entity) {
    return Note(
      id: entity.id,
      textNote: entity.textNote,
      importance: entity.importance.label,
      isCompleted: entity.isCompleted,
      makeBefore: entity.makeBefore?.toIso8601String(),
      updateTime: DateTime.now(),
    );
  }
}
