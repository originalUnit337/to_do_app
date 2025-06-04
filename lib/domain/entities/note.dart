import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String textNote;
  // enum
  final String importance;
  // datetime
  final String? makeBefore;
  final bool isCompleted;

  const NoteEntity({
    required this.textNote,
    required this.importance,
    this.makeBefore,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'textNote': textNote,
      'importance': importance,
      'makeBefore': makeBefore,
      'isCompleted': isCompleted,
    };
  }

  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      textNote: json['textNote'] as String,
      importance: json['importance'] as String,
      makeBefore: json['makeBefore'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [textNote, importance, makeBefore, isCompleted];
}
