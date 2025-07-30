import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/fabric_type.dart';
import 'package:mon_app_couture/models/enums/pattern_format.dart';
import 'package:mon_app_couture/models/enums/pattern_status.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/enums/sewing_level.dart';
import 'package:mon_app_couture/models/enums/wearer_category.dart';
import 'package:mon_app_couture/models/image_model.dart';

class PatternModel {
  final String? id;
  final String name;
  final String? description;
  final String? brand;
  final PatternFormat? format;
  final PatternStatus? status;
  final String? sizeRange;
  final List<Season>? seasons;
  final List<FabricType>? fabricTypes;
  final PatternType? projectType;
  final List<WearerCategory>? wearerCategories;
  final List<ClothingType>? clothingTypes;
  final SewingLevel? sewingLevel;
  final List<ImageModel>? images;
  final String? linkToShop;
  final List<String>? necessarySupplies;
  final bool? areSeamAllowancesIncluded;
  final bool? isFavorite;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatternModel({
    this.id,
    required this.name,
    this.description,
    this.brand,
    this.format,
    this.status,
    this.sizeRange,
    this.seasons,
    this.fabricTypes,
    this.projectType,
    this.wearerCategories,
    this.clothingTypes,
    this.sewingLevel,
    this.images,
    this.linkToShop,
    this.necessarySupplies,
    this.areSeamAllowancesIncluded,
    this.isFavorite,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory PatternModel.fromJson(Map<String, dynamic> json) {
    return PatternModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      format: json['format'] != null
          ? PatternFormat.fromJson(json['format'])
          : null,
      status: json['status'] != null
          ? PatternStatus.fromJson(json['status'])
          : null,
      sizeRange: json['sizeRange'] as String?,
      seasons: json['seasons'] != null
          ? (json['seasons'] as List<dynamic>)
                .map((s) => Season.fromJson(s))
                .toList()
          : null,
      fabricTypes: json['fabricTypes'] != null
          ? (json['fabricTypes'] as List<dynamic>)
                .map((t) => FabricType.fromJson(t))
                .toList()
          : null,
      wearerCategories: json['wearerCategories'] != null
          ? (json['wearerCategories'] as List<dynamic>)
                .map((wc) => WearerCategory.fromJson(wc))
                .toList()
          : null,
      projectType: json['projectType'] != null
          ? PatternType.fromJson(json['projectType'])
          : null,
      clothingTypes: json['clothingTypes'] != null
          ? (json['clothingTypes'] as List<dynamic>)
                .map((ct) => ClothingType.fromJson(ct))
                .toList()
          : null,
      sewingLevel: json['sewingLevel'] != null
          ? SewingLevel.fromJson(json['sewingLevel'])
          : null,
      images: json['images'] != null
          ? (json['images'] as List<dynamic>)
                .map((i) => ImageModel.fromJson(i))
                .toList()
          : null,
      linkToShop: json['linkToShop'] as String?,
      necessarySupplies: json['necessarySupplies'] != null
          ? (json['necessarySupplies'] as List<dynamic>).cast<String>()
          : null,
      areSeamAllowancesIncluded: json['areSeamAllowancesIncluded'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id,
    'name': name,
    if (description != null) 'description': description,
    if (brand != null) 'brand': brand,
    if (format != null) 'format': format!.toJson(),
    if (status != null) 'status': status!.toJson(),
    if (sizeRange != null) 'sizeRange': sizeRange,
    if (seasons != null) 'seasons': seasons!.map((s) => s.toJson()).toList(),
    if (fabricTypes != null)
      'fabricTypes': fabricTypes!.map((t) => t.toJson()).toList(),
    if (projectType != null) 'projectType': projectType!.toJson(),
    if (wearerCategories != null)
      'wearerCategories': wearerCategories!.map((wc) => wc.toJson()).toList(),
    if (clothingTypes != null)
      'clothingTypes': clothingTypes!.map((ct) => ct.toJson()).toList(),
    if (sewingLevel != null) 'sewingLevel': sewingLevel!.toJson(),
    if (images != null) 'images': images!.map((i) => i.toJson()).toList(),
    if (linkToShop != null) 'linkToShop': linkToShop,
    if (necessarySupplies != null) 'necessarySupplies': necessarySupplies,
    if (areSeamAllowancesIncluded != null)
      'areSeamAllowancesIncluded': areSeamAllowancesIncluded,
    'isFavorite': isFavorite,
    if (userId != null) 'userId': userId,
    if (createdAt != null) 'createdAt': createdAt,
    if (updatedAt != null) 'updatedAt': updatedAt,
  };

  PatternModel copyWith({
    String? id,
    String? name,
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
  }) => PatternModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    brand: brand ?? this.brand,
    format: format ?? this.format,
    status: status ?? this.status,
    sizeRange: sizeRange ?? this.sizeRange,
    seasons: seasons ?? this.seasons,
    fabricTypes: fabricTypes ?? this.fabricTypes,
    projectType: projectType ?? this.projectType,
    wearerCategories: wearerCategories ?? this.wearerCategories,
    clothingTypes: clothingTypes ?? this.clothingTypes,
    sewingLevel: sewingLevel ?? this.sewingLevel,
    images: images ?? this.images,
    linkToShop: linkToShop ?? this.linkToShop,
    necessarySupplies: necessarySupplies ?? this.necessarySupplies,
    areSeamAllowancesIncluded:
        areSeamAllowancesIncluded ?? this.areSeamAllowancesIncluded,
    isFavorite: isFavorite ?? this.isFavorite,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
