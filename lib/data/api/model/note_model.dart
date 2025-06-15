import 'package:to_do_app/core/base_model/base_api_model.dart.dart';
import 'package:to_do_app/domain/entities/note.dart';

class NoteModel extends NoteEntity implements BaseApiModel {
  const NoteModel({
    required super.id,
    required super.textNote,
    required super.importance,
    super.makeBefore,
    super.isCompleted,
  });
  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      id: map['name'].toString(),
      textNote:
          (map['textNote'] as Map<String, dynamic>)['stringValue'] as String,
      importance:
          (map['importance'] as Map<String, dynamic>)['stringValue'] as String,
      makeBefore:
          (map['makeBefore'] as Map<String, dynamic>?)?['stringValue']
              as String?,
      isCompleted:
          (map['isCompleted'] as Map<String, dynamic>?)?['booleanValue']
              as bool,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'fields': {
        'textNote': {'stringValue': textNote},
        'importance': {'stringValue': importance},
        'makeBefore':
            makeBefore != null
                ? {'stringValue': makeBefore}
                : {'nullValue': 'NULL_VALUE'},
        'isCompleted': {'booleanValue': isCompleted},
      },
    };
  }
}
