import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/fabric_type.dart';
import 'package:mon_app_couture/models/enums/pattern_format.dart';
import 'package:mon_app_couture/models/enums/pattern_status.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/enums/sewing_level.dart';
import 'package:mon_app_couture/models/enums/wearer_category.dart';
import 'package:mon_app_couture/models/image_model.dart';

part 'pattern_model.freezed.dart';
part 'pattern_model.g.dart';

@freezed
class PatternModel with _$PatternModel {
  const factory PatternModel({
    String? id,
    required String name,
    String? description,
    String? brand,
    PatternFormat? format,
    PatternStatus? status,
    String? sizeRange,
    List<Season>? seasons,
    List<FabricType>? fabricTypes,
    PatternType? projectType,
    List<WearerCategory>? wearerCategories,
    List<ClothingType>? clothingTypes,
    SewingLevel? sewingLevel,
    List<ImageModel>? images,
    String? linkToShop,
    List<String>? necessarySupplies,
    bool? areSeamAllowancesIncluded,
    bool? isFavorite,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PatternModel;

  factory PatternModel.fromJson(Map<String, dynamic> json) =>
      _$PatternModelFromJson(json);
}
