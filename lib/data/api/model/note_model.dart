import 'package:to_do_app/domain/entities/note.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    required super.textNote,
    required super.importance,
    super.makeBefore,
    super.isCompleted,
  });

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      textNote: map['textNote'] as String,
      importance: map['importance'] as String,
      makeBefore: map['makeBefore'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
