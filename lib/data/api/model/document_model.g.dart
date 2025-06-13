// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel<T> _$DocumentModelFromJson<T extends BaseApiModel>(
  Map<String, dynamic> json,
) => DocumentModel<T>(
  name: json['name'] as String,
  fields: DocumentModel._dataFromJson(json['fields'] as Map<String, dynamic>),
  createTime: json['createTime'] as String,
  updateTime: json['updateTime'] as String,
);

Map<String, dynamic> _$DocumentModelToJson<T extends BaseApiModel>(
  DocumentModel<T> instance,
) => <String, dynamic>{
  'name': instance.name,
  'fields': DocumentModel._dataToJson(instance.fields),
  'createTime': instance.createTime,
  'updateTime': instance.updateTime,
};
