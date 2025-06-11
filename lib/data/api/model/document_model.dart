import 'package:to_do_app/data/api/model/note_model.dart';

class DocumentModel {
  final String name;
  final NoteModel fields;

  DocumentModel({required this.name, required this.fields});

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json['name'] as String,
      fields: NoteModel.fromJson(json['fields'] as Map<String, dynamic>),
    );
  }
}
