import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mon_app_couture/models/image_model.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    String? id,
    required String name,
    String? notes,
    List<ImageModel>? images,
    String? inspirationId,
    String? patternId,
    String? fabricId,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

}
