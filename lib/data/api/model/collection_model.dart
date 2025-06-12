import 'package:json_annotation/json_annotation.dart';
import 'package:to_do_app/data/api/model/document_model.dart';

part 'collection_model.g.dart';

@JsonSerializable()
class CollectionModel<T> {
  final List<DocumentModel<T>> documents;

  CollectionModel({required this.documents});

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);
}
