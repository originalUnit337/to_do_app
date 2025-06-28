import 'package:json_annotation/json_annotation.dart';
import 'package:to_do_app/core/base_model/base_api_model.dart.dart';
import 'package:to_do_app/data/api/model/database_version_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';

part 'document_model.g.dart';

@JsonSerializable()
class DocumentModel<T extends BaseApiModel> {
  final String name;
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final T fields;
  final String createTime;
  final String updateTime;

  DocumentModel({
    required this.name,
    required this.fields,
    required this.createTime,
    required this.updateTime,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    (json['fields'] as Map<String, dynamic>).addAll({'name': json['name']});
    return _$DocumentModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  static T _dataFromJson<T>(Map<String, dynamic> json) {
    if (json.containsKey('textNote') && json.containsKey('importance')) {
      return NoteModel.fromJson(json) as T;
    } else if (json.containsKey('version')) {
      return DatabaseVersionModel.fromJson(json) as T;
    } else {
      throw Exception('Not supported type');
    }
  }

  static dynamic _dataToJson<T>(T value) {
    if (value is BaseApiModel) {
      return value.toJson();
    } else {
      throw Exception('Not supported type.');
    }
  }
}
