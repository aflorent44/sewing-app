import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/image_model.dart';

class PatternModel {
  final String? id;
  final String name;
  final String? description;
  final String? brand;
  final String? format;
  final String? status;
  final String? sizeRange;
  final List<Season>? seasons;
  final String? typeOfProject;
  final List<String>? typesOfClothing;
  final String? sewingLevel;
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
    this.typeOfProject,
    this.typesOfClothing,
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
      format: json['format'] as String?,
      status: json['status'] as String?,
      sizeRange: json['sizeRange'] as String?,
      seasons: json['seasons'] != null
          ? (json['seasons'] as List<dynamic>)
                .map((s) => Season.fromJson(s))
                .toList()
          : null,
      typeOfProject: json['typeOfProject'] as String?,
      typesOfClothing: json['typesOfClothing'] != null
          ? (json['typesOfClothing'] as List<dynamic>).cast<String>()
          : null,
      sewingLevel: json['sewingLevel'] as String?,
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
    if (format != null) 'format': format,
    if (status != null) 'status': status,
    if (sizeRange != null) 'sizeRange': sizeRange,
    if (seasons != null) 'seasons': seasons!.map((s) => s.toJson()).toList(),
    if (typeOfProject != null) 'typeOfProject': typeOfProject,
    if (typesOfClothing != null) 'typesOfClothing': typesOfClothing,
    if (sewingLevel != null) 'sewingLevel': sewingLevel,
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
    String? format,
    String? status,
    String? sizeRange,
    List<Season>? seasons,
    String? typeOfProject,
    List<String>? typesOfClothing,
    String? sewingLevel,
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
    typeOfProject: typeOfProject ?? this.typeOfProject,
    typesOfClothing: typesOfClothing ?? this.typesOfClothing,
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