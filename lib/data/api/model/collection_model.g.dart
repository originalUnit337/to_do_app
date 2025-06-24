// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModel<T> _$CollectionModelFromJson<T extends BaseApiModel>(
  Map<String, dynamic> json,
) => CollectionModel<T>(
  documents:
      (json['documents'] as List<dynamic>)
          .map((e) => DocumentModel<T>.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CollectionModelToJson<T extends BaseApiModel>(
  CollectionModel<T> instance,
) => <String, dynamic>{'documents': instance.documents};
