import 'package:to_do_app/core/base_model/base_api_model.dart.dart';
import 'package:to_do_app/core/common/enums/importance.dart';
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
      importance: Importance.fromString(
        (map['importance'] as Map<String, dynamic>)['stringValue'] as String,
      ),
      makeBefore: DateTime.tryParse(
        (map['makeBefore'] as Map<String, dynamic>?)?['stringValue']
                as String? ??
            '',
      ),
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
        'importance': {'stringValue': importance.label},
        'makeBefore':
            makeBefore != null
                ? {'stringValue': makeBefore?.toIso8601String()}
                : {'nullValue': 'NULL_VALUE'},
        'isCompleted': {'booleanValue': isCompleted},
      },
    };
  }
}
