abstract class BaseApiModel {
  Map<String, dynamic> toJson();
  factory BaseApiModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented in subclasses');
  }
}
