import 'package:equatable/equatable.dart';
import 'package:to_do_app/core/common/enums/importance.dart';

class NoteEntity extends Equatable {
  final String id;
  final String textNote;
  // enum
  final Importance importance;
  final DateTime? makeBefore;
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
      importance: Importance.fromString(json['importance'] as String),
      makeBefore: json['makeBefore'] as DateTime,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [
    id,
    textNote,
    importance,
    makeBefore,
    isCompleted,
  ];

  NoteEntity copyWith({
    String? id,
    String? textNote,
    Importance? importance,
    DateTime? makeBefore,
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
