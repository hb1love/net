import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  String id;
  String title;
  String? description;

  ResponseModel(this.id, this.title, [this.description]);

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  bool operator ==(Object other) {
    return other is ResponseModel && other.id == id && other.title == title;
  }
}
