class Note {
  final String textNote;
  // enum
  final String importance;
  // datetime
  final String? makeBefore;
  bool isCompleted;

  Note({
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

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      textNote: json['textNote'] as String,
      importance: json['importance'] as String,
      makeBefore: json['makeBefore'] as String,
      isCompleted: json['isCompleted'] as bool,
    ); // .. убрать
  }
}
