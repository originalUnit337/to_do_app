import 'package:to_do_app/domain/entities/note.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    required super.textNote,
    required super.importance,
    super.makeBefore,
    super.isCompleted,
  });

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    final fields = map['fields'] as Map<String, dynamic>;
    return NoteModel(
      textNote:
          (fields['textNote'] as Map<String, dynamic>)['stringValue'] as String,
      importance:
          (fields['importance'] as Map<String, dynamic>)['stringValue']
              as String,
      makeBefore:
          (fields['makeBefore'] as Map<String, dynamic>?)?['stringValue']
              as String?,
      isCompleted:
          (fields['isCompleted'] as Map<String, dynamic>?)?['booleanValue']
              as bool,
    );
  }
}
