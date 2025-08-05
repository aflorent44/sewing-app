import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspiration.freezed.dart';
part 'inspiration.g.dart';

@freezed
class Inspiration with _$Inspiration {
  const factory Inspiration({
    String? id,
    required String name,
    String? notes,
    String? link,
    PatternType? projectType,
    List<ClothingType>? clothingTypes,
    List<Colour>? colours,
    List<Season>? seasons,
    List<ImageModel>? images,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) = _Inspiration;

  factory Inspiration.fromJson(Map<String, dynamic> json) =>
      _$InspirationFromJson(json);
}