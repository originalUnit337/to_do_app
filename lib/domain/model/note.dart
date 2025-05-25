class Note {
  final String textNote;
  final String importance;
  final String? makeBefore;
  bool isCompleted = false;

  Note({required this.textNote, required this.importance, this.makeBefore});
}
