import 'package:to_do_app/data/api/model/document_model.dart';

class CollectionModel {
  final List<DocumentModel> documents;

  CollectionModel({required this.documents});

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    final documentsJson = json['documents'] as List;
    final documentsList =
        documentsJson
            .map((doc) => DocumentModel.fromJson(doc as Map<String, dynamic>))
            .toList();
    return CollectionModel(documents: documentsList);
  }
}
