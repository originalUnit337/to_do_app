import 'package:to_do_app/core/base_model/base_api_model.dart.dart';

class DatabaseVersionModel implements BaseApiModel {
  final String id;
  final DateTime version;

  DatabaseVersionModel(this.version, this.id);

  factory DatabaseVersionModel.fromJson(Map<String, dynamic> json) {
    return DatabaseVersionModel(
      DateTime.parse(
        (json['version'] as Map<String, dynamic>)['stringValue'] as String? ??
            '',
      ),
      json['name'].toString(),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'fields': {
        'version': {'stringValue': version.toIso8601String()},
      },
    };
  }
}
