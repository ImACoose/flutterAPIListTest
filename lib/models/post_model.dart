import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart'; // need json serialisable dependency to generate this

@freezed
class PostModel with _$PostModel {
  const factory PostModel(
      {required int userId,
      required int id,
      required String title,
      required String body}) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
