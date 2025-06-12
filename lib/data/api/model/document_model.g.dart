// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel<T> _$DocumentModelFromJson<T>(Map<String, dynamic> json) =>
    DocumentModel<T>(
      name: json['name'] as String,
      fields: DocumentModel._dataFromJson(
        json['fields'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DocumentModelToJson<T>(DocumentModel<T> instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': DocumentModel._dataToJson(instance.fields),
    };
