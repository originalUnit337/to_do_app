import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String id;
  final String textNote;
  // enum
  final String importance;
  // datetime
  final String? makeBefore;
  final bool isCompleted;

  const NoteEntity({
    required this.id,
    required this.textNote,
    required this.importance,
    this.makeBefore,
    this.isCompleted = false,
  });

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

  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json['id'] as String,
      textNote: json['textNote'] as String,
      importance: json['importance'] as String,
      makeBefore: json['makeBefore'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [textNote, importance, makeBefore, isCompleted];

  NoteEntity copyWith({
    String? id,
    String? textNote,
    String? importance,
    String? makeBefore,
    bool? isCompleted,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      textNote: textNote ?? this.textNote,
      importance: importance ?? this.importance,
      makeBefore: makeBefore ?? this.makeBefore,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
