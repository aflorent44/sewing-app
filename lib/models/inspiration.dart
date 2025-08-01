import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/image_model.dart';

class Inspiration {
  final String? id;
  final String name;
  final String? notes;
  final String? link;
  final PatternType? projectType;
  final List<ClothingType>? clothingTypes;
  final List<Colour>? colours;
  final List<Season>? seasons;
  final List<ImageModel>? images;
  final bool? isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;

  Inspiration({
    this.id,
    required this.name,
    this.notes,
    this.link,
    this.projectType,
    this.clothingTypes,
    this.colours,
    this.seasons,
    this.images,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Inspiration.fromJson(Map<String, dynamic> json) => Inspiration(
    id: json['_id'] as String?,
    name: json['name'] as String,
    notes: json['notes'] as String?,
    link: json['link'] as String?,
    projectType: json['projectType'] != null
        ? PatternType.fromJson(json['projectType'])
        : null,
    clothingTypes: (json['clothingTypes'] as List<dynamic>?)
        ?.map((e) => ClothingType.fromJson(e as String))
        .toList(),
    colours: (json['colours'] as List<dynamic>?)
        ?.map((e) => Colour.fromJson(e as String))
        .toList(),
    seasons: (json['seasons'] as List<dynamic>?)
        ?.map((e) => Season.fromJson(e as String))
        .toList(),
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    isFavorite: json['isFavorite'] as bool?,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'] as String)
        : null,
    userId: json['user_id'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id,
    'name': name,
    if (notes != null) 'notes': notes,
    if (link != null) 'link': link,
    if (projectType != null) 'projectType': projectType!.toJson(),
    if (clothingTypes != null)
      'clothingTypes': clothingTypes!.map((c) => c.toJson()).toList(),
    if (colours != null) 'colours': colours!.map((c) => c.toJson()).toList(),
    if (seasons != null) 'seasons': seasons!.map((s) => s.toJson()).toList(),
    if (images != null) 'images': images!.map((i) => i.toJson()).toList(),
    'isFavorite': isFavorite,
    if (createdAt != null) 'createdAt': createdAt,
    if (updatedAt != null) 'updatedAt': updatedAt,
    if (userId != null) 'user_id': userId,
  };

  Inspiration copyWith({
    String? id,
    String? name,
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
  }) => Inspiration(
    id: id ?? this.id,
    name: name ?? this.name,
    notes: notes ?? this.notes,
    link: link ?? this.link,
    projectType: projectType ?? this.projectType,
    clothingTypes: clothingTypes ?? this.clothingTypes,
    colours: colours ?? this.colours,
    seasons: seasons ?? this.seasons,
    images: images ?? this.images,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userId: userId ?? this.userId,
  );
}
