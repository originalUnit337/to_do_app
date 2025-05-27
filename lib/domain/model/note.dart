class Note {
  final String textNote;
  final String importance;
  final String? makeBefore;
  bool isCompleted = false;

  Note({required this.textNote, required this.importance, this.makeBefore});

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
    )..isCompleted = json['isCompleted'] as bool ?? false;
  }
}
